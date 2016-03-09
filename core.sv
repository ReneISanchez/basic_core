import definitions::*;

// TODO: add trace generator?
//          - op and registers (can't do PC due to branches) w/ timestamps (must be able to toggle TS)?
//          - register file trace (initial state and writes?) w/ timestamps (must be able to toggle TS)?
//          - memory writes trace?
//          - branch trace?
//

// TODO: generate make files for everything

module core #(
        parameter imem_addr_width_p = 10,
        parameter net_ID_p = 10'b0000000001
    )
    (
        input  clk,
        input  n_reset,

        input  net_packet_s net_packet_i,
        output net_packet_s net_packet_o,

        input  mem_out_s from_mem_i,
        output mem_in_s  to_mem_o,

        output logic [mask_length_gp-1:0] barrier_o,
        output logic                      exception_o,
        output debug_s                    debug_o,
        output logic [31:0]               data_mem_addr
    );

/****************************************************************************
 *                            Adresses And Data                             *
 ****************************************************************************/

// Ins. memory address signals
logic [imem_addr_width_p-1:0] PC_r, PC_n,
                              pc_plus1, imem_addr,
                              imm_jump_add;
// Ins. memory output
instruction_s instruction, instruction_r;

//Pipeline definitions
pipeline_reg IFID; //pipeline_signals
pipeline_reg MEMWB; //pipeline signals

logic [31:0] forward_wd;

//Bubble signals. inserts a nop at the fetch stage or inserts a bubble at the decode stage
logic insert_nop_n, insert_nop_r;

// Result of ALU, Register file outputs, Data memory output data
logic [31:0] alu_result, rs_val_or_zero, rd_val_or_zero, rs_val, rd_val;
// ALU output to determine whether to jump or not
logic jump_now;
// Reg. File address
logic [($bits(instruction.rs_imm))-1:0] rd_addr, wa_addr;  //wa_addr, rs_addr, rd_addr;
// Data for Reg. File signals
logic [31:0] rf_wd;


/****************************************************************************
 *                             Control Signals                              *
 ****************************************************************************/

// controller output signals
logic is_load_op_c,  op_writes_rf_c,
      is_store_op_c, is_mem_op_c,    PC_wen,
      is_byte_op_c,  PC_wen_r;

// Final signals after network interfere
logic imem_wen, rf_wen;


//Stall signal for long memory accesses. freezes entire pipeline
logic stall;

//Exception signal
logic exception_n;


/****************************************************************************
 *                       Network and Barrier Signals                        *
 ****************************************************************************/

// Network operation signals
logic net_ID_match,      net_PC_write_cmd,  net_imem_write_cmd,
      net_reg_write_cmd, net_bar_write_cmd, net_PC_write_cmd_IDLE;

instruction_s net_instruction;

logic [mask_length_gp-1:0] barrier_r,      barrier_n,
  barrier_mask_r, barrier_mask_n;
logic fwd_rs, fwd_rd;		// for waveform convenience only


//==============================================================================
//                              Instrustion Fetch
//==============================================================================

//Wire from fetch
instruction_s imem_out;

// Instructions are shorter than 32 bits of network data
assign net_instruction = net_packet_i.net_data [0+:($bits(instruction))];
// Selection between network and core for instruction address
assign imem_addr = (net_imem_write_cmd) ? net_packet_i.net_addr
                                       : PC_n;
// Insruction memory
instr_mem #(.addr_width_p(imem_addr_width_p)) imem
           (.clk(clk)
           ,.addr_i(imem_addr)
           ,.instruction_i(net_instruction)
           ,.wen_i(imem_wen) 			//  ,.nop_i(nop) 
           ,.instruction_o(imem_out)
           );

//Prevents the next instr from getting read
assign PC_wen = net_PC_write_cmd_IDLE || (~stall && ~insert_nop_n);

//imem has one cycle delay and we send next cycle's address, PC_n
//if the PC is not written, the instruction must not change
always_comb
begin
  if (PC_wen_r)
    instruction = imem_out;
  else if (insert_nop_r)
    instruction = 16'b1111111111111111;
  else if (stall)
    instruction = instruction_r;
end

// Determine next PC
assign pc_plus1     = PC_r + 1'b1;
assign imm_jump_add = $signed(IFID.instruction.rs_imm)  + $signed(PC_r);

// Next pc is based on network or the instruction
always_comb
  begin
    PC_n = pc_plus1;
    if (net_PC_write_cmd_IDLE)
      PC_n = net_packet_i.net_addr;
    else
      unique casez (IFID.instruction)   //branches and jumps happen in exe stage
        kJALR: begin
          PC_n = alu_result[0+:imem_addr_width_p];
        end

        kBNEQZ,kBEQZ,kBLTZ,kBGTZ: begin
          if (jump_now)
            PC_n = imm_jump_add;
        end

        default: begin end
      endcase
  end

//==============================================================================
//                                IF/ID Pipeline
//==============================================================================

pipeline_reg IFID_n;
assign IFID_n.instruction  = (~stall) ? instruction : IFID.instruction;
assign IFID_n.is_load_op = 0;
assign IFID_n.op_writes_rf = 0;
assign IFID_n.is_store_op = 0;
assign IFID_n.is_mem_op = 0;
assign IFID_n.is_byte_op = 0;

always_ff @(posedge clk) begin
  IFID <= IFID_n;
  insert_nop_r = insert_nop_n;
end

always_comb
begin
  insert_nop_n = 1'b0;
  unique casez (instruction)
    kJALR, kBNEQZ, kBEQZ, kBLTZ, kBGTZ, kLW, kLBU, kSW, kSB:
      insert_nop_n = 1'b1;
    default: begin end
  endcase
  unique casez (IFID.instruction)
    kJALR, kBNEQZ, kBEQZ, kBLTZ, kBGTZ, kLW, kLBU, kSW, kSB:
      insert_nop_n = 1'b0;
    default: begin end
  endcase
end

//==============================================================================
//                              Instruction Decode
//==============================================================================

cl_decode decode (.instruction_i(IFID.instruction)
                  //,.ctrl_sigs_o(control_sigs)
                  ,.is_load_op_o(is_load_op_c)
                  ,.op_writes_rf_o(op_writes_rf_c)
                  ,.is_store_op_o(is_store_op_c)
                  ,.is_mem_op_o(is_mem_op_c)
                  ,.is_byte_op_o(is_byte_op_c)
                  );

// State machine signals
state_e state_r, state_n;
//cl_state_machine state_machine (.instruction_i(IFID.instruction)
cl_state_machine state_machine (.instruction_i(instruction) // state changes in ID / EX stage
                               ,.state_i(state_r)
                               ,.exception_i(exception_o)
                               ,.net_PC_write_cmd_IDLE_i(net_PC_write_cmd_IDLE)
                               ,.stall_i(stall)
                               ,.state_o(state_n)
                               );

// Selects from network or from rd bits of instr. Extends to correct length of bits
assign rd_addr = ({{($bits(instruction.rs_imm)-$bits(instruction.rd)){1'b0}}
                 ,{IFID.instruction.rd}});

reg_file #(.addr_width_p($bits(instruction.rs_imm))) rf
          (.clk(clk)
          ,.rs_addr_i(IFID.instruction.rs_imm)
          ,.rd_addr_i(rd_addr)
          ,.wen_i(rf_wen)
          ,.w_addr_i (wa_addr)
          ,.w_data_i(rf_wd)
          ,.rs_val_o(rs_val)
          ,.rd_val_o(rd_val)
          );

//Forward MEMWB values to alu input if necessary
always_comb
  if (IFID.instruction.rs_imm == MEMWB.instruction.rd) begin
    rs_val_or_zero = forward_wd;
    fwd_rs = 1;
  end
  else begin
    rs_val_or_zero = IFID.instruction.rs_imm ? rs_val : 32'b0;
    fwd_rs = 0;
  end

always_comb
  if(IFID.instruction.rd == MEMWB.instruction.rd) begin
    rd_val_or_zero = forward_wd;
    fwd_rd = 1;
  end
  else begin
    rd_val_or_zero = rd_addr ? rd_val :32'b0;
    fwd_rd = 0;
  end

//==============================================================================
//                                   Execute
//==============================================================================

alu alu_1 (.rd_i(rd_val_or_zero)
          ,.rs_i(rs_val_or_zero)
          ,.op_i(IFID.instruction)
          ,.result_o(alu_result)
          ,.jump_now_o(jump_now)
          );

//==============================================================================
//                                    Memory
//==============================================================================

//MEM-only signals
logic valid_to_mem_c, yumi_to_mem_c;
logic [1:0] mem_stage_r, mem_stage_n, mem_hazard;

// rf structural hazard and imem structural hazard (can't load next instruction)

assign mem_hazard =    (net_reg_write_cmd && op_writes_rf_c)
                    || (net_imem_write_cmd);

// Stall if LD/ST still active; or in non-RUN state
assign stall =    mem_hazard
               || (mem_stage_n != 0)
               || (state_r != RUN);

// Launch LD/ST
assign valid_to_mem_c = is_mem_op_c & (mem_stage_r < 2'b10); //ID_EX_r.ctrl_sigs.is_mem_op_o & (mem_stage_r < 2'b10) : 0;

// Data_mem
assign to_mem_o = '{write_data    : rs_val_or_zero
                   ,valid         : valid_to_mem_c
                   ,wen           : is_store_op_c
                   ,byte_not_word : is_byte_op_c
                   ,yumi          : yumi_to_mem_c
                   };
assign data_mem_addr = alu_result;

always_comb
  begin
    yumi_to_mem_c = 1'b0;
    mem_stage_n   = mem_stage_r;

    if (valid_to_mem_c)
        mem_stage_n   = 2'b01;

    if (from_mem_i.yumi)
        mem_stage_n   = 2'b10;

    // If we can commit the LD/ST this cycle, the acknowledge dmem's response
    if (from_mem_i.valid & ~mem_hazard) //&& ???************************************************
      begin
        mem_stage_n   = 2'b00;
        yumi_to_mem_c = 1'b1;
      end
    end

//==============================================================================
//                               MEM/WB Pipeline
//==============================================================================

pipeline_reg MEMWB_n;

//Transition Values
mem_out_s MEMWB_from_mem_i;
logic [31:0] MEMWB_alu_result;
logic [imem_addr_width_p-1:0] MEMWB_pc_plus1;

assign MEMWB_n = (~stall) ? IFID : MEMWB;

always_ff @(posedge clk) begin
  MEMWB.instruction <= MEMWB_n.instruction;
  if (~stall) begin
    MEMWB.is_load_op   <= is_load_op_c;
    MEMWB.op_writes_rf <= op_writes_rf_c;
    MEMWB.is_store_op  <= is_store_op_c;
    MEMWB.is_mem_op    <= is_mem_op_c;
    MEMWB.is_byte_op   <= is_byte_op_c;

    MEMWB_from_mem_i   <= from_mem_i;
    MEMWB_alu_result   <= alu_result;
    MEMWB_pc_plus1     <= pc_plus1;
  end
end

assign forward_wd = rf_wd;

//==============================================================================
//                                  Write Back
//==============================================================================

// Register write could be from network or the controller
assign rf_wen    = (net_reg_write_cmd || (MEMWB.op_writes_rf && ~stall));


//TODO POTENTIAL BUG ******************************************************************
assign wa_addr = (net_reg_write_cmd)
            ? (net_packet_i.net_addr [0+:($bits(instruction.rs_imm))])
            : ({{($bits(instruction.rs_imm)-$bits(instruction.rd)){1'b0}}
            ,{MEMWB.instruction.rd}});


// select the input data for Register file, from network, the PC_plus1 for JALR, Data Memory or ALU result
always_comb
  begin
    if (net_reg_write_cmd)
      rf_wd = net_packet_i.net_data;
    else if (MEMWB.instruction==?kJALR) //after ex stage
      rf_wd =  MEMWB_pc_plus1;
    else if (MEMWB.is_load_op)
      rf_wd = MEMWB_from_mem_i.read_data;
    else
      rf_wd = MEMWB_alu_result;
  end

//==============================================================================
//                               Sequential Logic
//==============================================================================

always_ff @ (posedge clk)
  begin
    if (!n_reset)
      begin
        PC_r            <= 0;
        barrier_mask_r  <= {(mask_length_gp){1'b0}};
        barrier_r       <= {(mask_length_gp){1'b0}};
        state_r         <= IDLE;
        instruction_r   <= 0;
        PC_wen_r        <= 0;
        exception_o     <= 0;
        mem_stage_r     <= 2'b00;
      end

    else
      begin

        if (PC_wen) begin
          PC_r         <= PC_n;
        end

        barrier_mask_r <= barrier_mask_n;
        barrier_r      <= barrier_n;
        state_r        <= state_n;
        instruction_r  <= instruction;
        PC_wen_r       <= PC_wen;
        exception_o    <= exception_n;
        mem_stage_r    <= mem_stage_n;
      end
  end 


//---- Connection to external modules ----//

// Suppress warnings
assign net_packet_o = net_packet_i;

// DEBUG Struct
assign debug_o = {PC_r, instruction, state_r, barrier_mask_r, barrier_r};

//---- Datapath with network ----//

// Detect a valid packet for this core
assign net_ID_match = (net_packet_i.ID==net_ID_p);

// Network operation
assign net_PC_write_cmd      = (net_ID_match && (net_packet_i.net_op==PC));
assign net_imem_write_cmd    = (net_ID_match && (net_packet_i.net_op==INSTR));
assign net_reg_write_cmd     = (net_ID_match && (net_packet_i.net_op==REG));
assign net_bar_write_cmd     = (net_ID_match && (net_packet_i.net_op==BAR));
assign net_PC_write_cmd_IDLE = (net_PC_write_cmd && (state_r==IDLE));

// Barrier final result, in the barrier mask, 1 means not mask and 0 means mask
assign barrier_o = barrier_mask_r & barrier_r;
// The instruction write is just for network
assign imem_wen  = net_imem_write_cmd;


// barrier_mask_n, which stores the mask for barrier signal
always_comb
  // Change PC packet
  if (net_bar_write_cmd && (state_r != ERR))
    barrier_mask_n = net_packet_i.net_data [0+:mask_length_gp];
  else
    barrier_mask_n = barrier_mask_r;

// barrier_n signal, which contains the barrier value
// it can be set by PC write network command if in IDLE
// or by an an BAR instruction that is committing

//TODO POTENTIAL BUG ******************************************************************
assign barrier_n = net_PC_write_cmd_IDLE
                   ? net_packet_i.net_data[0+:mask_length_gp]
                   : ((IFID.instruction==?kBAR) & ~stall)
                     ? alu_result [0+:mask_length_gp]
                     : barrier_r;

// exception_n signal, which indicates an exception
// We cannot determine next state as ERR in WORK state, since the instruction
// must be completed, WORK state means start of any operation and in memory
// instructions which could take some cycles, it could mean wait for the
// response of the memory to aknowledge the command. So we signal that we recieved
// a wrong package, but do not stop the execution. Afterwards the exception_r
// register is used to avoid extra fetch after this instruction.
always_comb
  if ((state_r==ERR) || (net_PC_write_cmd && (state_r!=IDLE)))
    exception_n = 1'b1;
  else
    exception_n = exception_o;

endmodule
