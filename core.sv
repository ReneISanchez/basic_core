import definitions::*;

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

// Ins. memory address signals
logic [imem_addr_width_p-1:0] PC_r, PC_n,
                              pc_plus1, imem_addr,
                              imm_jump_add;
// Ins. memory output
instruction_s instruction, instruction_r, imem_out, nop_instr;

assign nop_instr = 16'b1111111111111111;

//Pipcuts
pipcut_if_s pipcut_if_n, pipcut_if_r;   //Between IF and ID
 //pipcut_id_s  pipcut_id_n,  pipcut_id_r;
 //pipcut_me_s  pipcut_me_n,  pipcut_me_r;
pipcut_wb_s pipcut_wb_n, pipcut_wb_r; //Between Mem and WB

// State machine signals
state_e state_r, state_n;

logic [31:0] forward;

//Bubble signals
logic bubble_n, bubble_r;

// Result of ALU, Register file outputs, Data memory output data
logic [31:0] alu_result, rs_val_or_zero, rd_val_or_zero, rs_val, rd_val;

// ALU output to determine whether to jump or not
logic jump_now;

// Reg. File address
logic [($bits(instruction.rs_imm))-1:0] rd_addr, w_addr;

// Data for Reg. File signals
logic [31:0] rf_wd;


// controller output signals
logic is_load_op_c,  op_writes_rf_c,
      is_store_op_c, is_mem_op_c,    PC_wen,
      is_byte_op_c,  PC_wen_r;

control_s control_fresh;
assign control_fresh.is_load_op_s = is_load_op_c;
assign control_fresh.op_writes_rf_s = op_writes_rf_c;
assign control_fresh.is_store_op_s = is_store_op_c;
assign control_fresh.is_mem_op_s = is_mem_op_c;
assign control_fresh.is_byte_op_s = is_byte_op_c;

// Final signals after network interfere
logic imem_wen, rf_wen;

//Stall signal for long memory accesses. freezes entire pipeline
logic stall, stall_non_mem;

//Exception signal
logic exception_n;

// Network operation signals
logic net_ID_match,      net_PC_write_cmd,  net_imem_write_cmd,
      net_reg_write_cmd, net_bar_write_cmd, net_PC_write_cmd_IDLE;

instruction_s net_instruction;

logic [mask_length_gp-1:0] barrier_r,      barrier_n,
  barrier_mask_r, barrier_mask_n;

// Instructions are shorter than 32 bits of network data
assign net_instruction = net_packet_i.net_data [0+:($bits(instruction))];

// Selection between network and core for instruction address
assign imem_addr = (net_imem_write_cmd) ? net_packet_i.net_addr : PC_n;

//Prevents the next instr from getting read
assign PC_wen = net_PC_write_cmd_IDLE || (!stall && !bubble_n);

// Determine next PC
assign pc_plus1     = PC_r + 1'b1;
assign imm_jump_add = $signed(pipcut_if_r.instr_if.rs_imm)  + $signed(PC_r);

logic valid_to_mem_c, yumi_to_mem_c;
logic [1:0] mem_stage_r, mem_stage_n, mem_hazard;

  // stall and memory stages signals
    // rf structural hazard and imem structural hazard (can't load next instruction)
assign stall_non_mem =  (net_reg_write_cmd && op_writes_rf_c)  || (net_imem_write_cmd);

  // Stall if LD/ST still active; or in non-RUN state
assign stall =    stall_non_mem || (mem_stage_n != 0)  || (state_r != RUN);

// Launch LD/ST
assign valid_to_mem_c = is_mem_op_c & (mem_stage_r < 2'b10); //ID_EX_r.ctrl_sigs.is_mem_op_o & (mem_stage_r < 2'b10) : 0;


// Selects from network or from rd bits of instr. Extends to correct length of bits
assign rd_addr = ({{($bits(instruction.rs_imm)-$bits(instruction.rd)){1'b0}}
                 ,{pipcut_if_r.instr_if.rd}});

assign pipcut_if_n.instr_if  = (stall) ? pipcut_if_r.instr_if : instruction;
assign pipcut_if_n.control_if = 0;

// Insruction memory
instr_mem #(.addr_width_p(imem_addr_width_p)) imem
           (.clk(clk)
           ,.addr_i(imem_addr)
           ,.instruction_i(net_instruction)
           ,.wen_i(imem_wen) 
           ,.instruction_o(imem_out)
           );

//imem has one cycle delay and we send next cycle's address, PC_n
//if the PC is not written, the instruction must not change
always_comb
begin
  if (PC_wen_r)
    instruction = imem_out;
  else if (bubble_r)
    instruction = nop_instr;
  else if (stall)
    instruction = instruction_r;
end

// Next pc is based on network or the instruction
always_comb
  begin
    PC_n = pc_plus1;
    if (net_PC_write_cmd_IDLE)
      PC_n = net_packet_i.net_addr;
    else
      unique casez (pipcut_if_r.instr_if)   //branches and jumps happen in exe stage
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

always_comb
begin
  bubble_n = 1'b0;
   unique casez (pipcut_if_r.instr_if)
    kJALR, kBNEQZ, kBEQZ, kBLTZ, kBGTZ:
      bubble_n = 1'b0;
	 kLW, kLBU, kSW, kSB:
		bubble_n = 1'b0;
    default: begin end
	endcase
	
  unique casez (instruction)
    kJALR, kBNEQZ, kBEQZ, kBLTZ, kBGTZ:
      bubble_n = 1'b1;
	kLW, kLBU, kSW, kSB:
		bubble_n = 1'b1;
    default: begin end
  endcase
end

cl_decode decode (.instruction_i(pipcut_if_r.instr_if)
                  ,.is_load_op_o(is_load_op_c)
                  ,.op_writes_rf_o(op_writes_rf_c)
                  ,.is_store_op_o(is_store_op_c)
                  ,.is_mem_op_o(is_mem_op_c)
                  ,.is_byte_op_o(is_byte_op_c)
                  );


//cl_state_machine state_machine (.instruction_i(IFID.instruction)
cl_state_machine state_machine (.instruction_i(instruction) // state changes in ID / EX stage
                               ,.state_i(state_r)
                               ,.exception_i(exception_o)
                               ,.net_PC_write_cmd_IDLE_i(net_PC_write_cmd_IDLE)
                               ,.stall_i(stall)
                               ,.state_o(state_n)
                               );

reg_file #(.addr_width_p($bits(instruction.rs_imm))) rf
          (.clk(clk)
          ,.rs_addr_i(pipcut_if_r.instr_if.rs_imm)
          ,.rd_addr_i(rd_addr)
          ,.wen_i(rf_wen)
          ,.w_addr_i (w_addr)
          ,.w_data_i(rf_wd)
          ,.rs_val_o(rs_val)
          ,.rd_val_o(rd_val)
          );

/////////////////////////////////////////////////////////
///        Hazard / Forwarding start
/////////////////////////////////////////////////////////
always_comb
  if (pipcut_if_r.instr_if.rs_imm == pipcut_wb_r.instr_wb.rd) begin
    rs_val_or_zero = forward;
  end
  else begin
    rs_val_or_zero = pipcut_if_r.instr_if.rs_imm ? rs_val : 32'b0;
  end

always_comb
  if(pipcut_if_r.instr_if.rd == pipcut_wb_r.instr_wb.rd) begin
    rd_val_or_zero = forward;
  end
  else begin
    rd_val_or_zero = rd_addr ? rd_val :32'b0;
  end
/////////////////////////////////////////////////////////
///        Hazard / Forwarding end
/////////////////////////////////////////////////////////

alu alu_1 (.rd_i(rd_val_or_zero)
          ,.rs_i(rs_val_or_zero)
          ,.op_i(pipcut_if_r.instr_if)
          ,.result_o(alu_result)
          ,.jump_now_o(jump_now)
          );

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

    if (from_mem_i.valid & ~stall_non_mem) 
      begin
        mem_stage_n   = 2'b00;
        yumi_to_mem_c = 1'b1;
      end
    end

//Transition Values
mem_out_s wb_from_mem_i;
logic [31:0] wb_alu_result;
logic [imem_addr_width_p-1:0] wb_pc_plus1;

assign pipcut_wb_n = (~stall) ? pipcut_if_r : pipcut_wb_r;

assign forward = rf_wd;

// Register write could be from network or the controller
assign rf_wen    = (net_reg_write_cmd || (pipcut_wb_r.control_wb.op_writes_rf_s && ~stall));

assign w_addr = (net_reg_write_cmd)
            ? (net_packet_i.net_addr [0+:($bits(instruction.rs_imm))])
            : ({{($bits(instruction.rs_imm)-$bits(instruction.rd)){1'b0}}
            ,{pipcut_wb_r.instr_wb.rd}});


// select the input data for Register file, from network, the PC_plus1 for JALR, Data Memory or ALU result
always_comb
  begin
    if (net_reg_write_cmd)
      rf_wd = net_packet_i.net_data;
    else if (pipcut_wb_r.instr_wb==?kJALR) //after ex stage
      rf_wd =  wb_pc_plus1;
    else if (pipcut_wb_r.control_wb.is_load_op_s)
      rf_wd = wb_from_mem_i.read_data;
    else
      rf_wd = wb_alu_result;
  end

always_ff @ (posedge clk)
  begin
    pipcut_if_r <= pipcut_if_n;
	 pipcut_wb_r.instr_wb <= pipcut_wb_n.instr_wb;
    bubble_r = bubble_n;
	 
  if (!stall) begin
    pipcut_wb_r.control_wb <= control_fresh;
	 
    wb_from_mem_i   <= from_mem_i;
    wb_alu_result   <= alu_result;
    wb_pc_plus1     <= pc_plus1;
  end
  
  if (!n_reset)
      begin
        PC_r            <= 0;
        barrier_mask_r  <= {(mask_length_gp){1'b0}};
        barrier_r       <= {(mask_length_gp){1'b0}};
        state_r         <= IDLE;
        instruction_r   <= 0;
        PC_wen_r        <= 0;
        exception_o     <= 0;
        mem_stage_r     <= DMEM_IDLE;
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
assign barrier_n = net_PC_write_cmd_IDLE
                   ? net_packet_i.net_data[0+:mask_length_gp]
                   : ((pipcut_if_r.instr_if==?kBAR) & ~stall)
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
