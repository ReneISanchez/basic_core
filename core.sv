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
    
    //---- Adresses and Data ----//
    // Ins. memory address signals
    logic [imem_addr_width_p-1:0] PC_r, PC_n,
                                pc_plus1, imem_addr,
                                imm_jump_add;
                                
    // Ins. memory output
    //instruction_s instruction, imem_out;
	 instruction_s instruction, imem_out, instruction_r;
	 
	 // pipcuts
	 //control_s control;
	 pipcut_if_s  pipcut_if_n,  pipcut_if_r;
	 pipcut_id_s  pipcut_id_n,  pipcut_id_r;
	 pipcut_me_s pipcut_me_n, pipcut_me_r;
	 pipcut_wb_s  pipcut_wb_n,  pipcut_wb_r;
	 
	 
	 //logic jump_flash;
    
    // Result of ALU, Register file outputs, Data memory output data
    logic [31:0] alu_result, rs_val_or_zero, rd_val_or_zero, rs_val, rd_val;
   
    // Reg. File address
    logic [($bits(instruction.rs_imm))-1:0] rd_addr;
    
    // Data for Reg. File signals
    logic [31:0] rf_wd;
    
    //---- Control signals ----//
    // ALU output to determin whether to jump or not
    logic jump_now;
    
    // controller output signals
    logic is_load_op_c,  op_writes_rf_c, valid_to_mem_c,
        is_store_op_c, is_mem_op_c,    PC_wen, PC_wen_r,
        is_byte_op_c;
		  
		  control_s control_fresh;
		  assign control_fresh.is_load_op_s = is_load_op_c;
		  assign control_fresh.op_writes_rf_s = op_writes_rf_c;
		  assign control_fresh.valid_to_mem_s = valid_to_mem_c;
		  assign control_fresh.is_store_op_s = is_store_op_c;
		  assign control_fresh.is_mem_op_s = is_mem_op_c; 
		  assign control_fresh.is_byte_op_s = is_byte_op_c; 
		  
    // Handshak protocol signals for memory
    logic yumi_to_mem_c;
    
    // Final signals after network interfere
    logic imem_wen, rf_wen;
    
    // Network operation signals
    logic net_ID_match,      net_PC_write_cmd,  net_imem_write_cmd,
        net_reg_write_cmd, net_bar_write_cmd, net_PC_write_cmd_IDLE;
    
    // Memory stages and stall signals
    dmem_req_state mem_stage_r, mem_stage_n;

	 //instruction decode signals
	 //ctrl_sig_s ctrl_sig_o;
	 
    logic stall, stall_non_mem;
    
    // Exception signal
    logic exception_n;
    
    // State machine signals
    state_e state_r,state_n;
    
    //---- network and barrier signals ----//
    instruction_s net_instruction;
    logic [mask_length_gp-1:0] barrier_r,      barrier_n,
                            barrier_mask_r, barrier_mask_n;
    
    //---- Connection to external modules ----//
    
    // Suppress warnings
    assign net_packet_o = net_packet_i;
	 
	 //Pipeline stage registers
	 //FD_reg_s  FD_reg_n,  FD_reg_r;    <- 1st pipecut. Our pipcut_if register
	 //DX_reg_s  DX_reg_n,  DX_reg_r;    <- 2nd pipecut. Our pipcut_id register
	 //XM_reg_s  XM_reg_n,  XM_reg_r;    <- 3rd pipecut. Our pipcut_me register
	 //MW_reg_s  MW_reg_n,  MW_reg_r;    <- 4th pipecut. Our pipcut_wb register

    // DEBUG Struct
    assign debug_o = {PC_r, instruction, state_r, barrier_mask_r, barrier_r};
	 
	 //Bubble used in lecture 
	 logic bubble;
	 
	 //Hazards
	 logic[1:0] forwardA;
	 logic[1:0] forwardB;
    
    // Update the PC if we get a PC write command from network, or the core is not stalled.
    assign PC_wen = (net_PC_write_cmd_IDLE || !stall);
    /*
    // Program counter
    always_ff @ (posedge clk)
        begin
        if (!n_reset)
            begin
            PC_r     <= 0;
			end
				
        else
            begin
            if (PC_wen)
                begin
                PC_r <= PC_n;
					 //pipcut_if_r.PC_r_if <= PC_r;
				

				// pipcut for stage 1
					if (jump_now)
						begin	
						//$display("ERROR: %x",jump_flash);
						pipcut_if_r <= 0;
						pipcut_id_r <= 0;
						pipcut_me_r <= pipcut_me_n;
						pipcut_wb_r <= pipcut_wb_n;
						end
					else if (net_PC_write_cmd_IDLE)
						begin
						pipcut_if_r <= 0;
						pipcut_id_r <= 0;
						pipcut_me_r <= 0;
						pipcut_wb_r <= 0;
						//also set all other pipecuts to 0
						end 
				/*else if (stall)
				begin
				pipcut_if_r <= pipcut_if_r;
				
				end*/ /*
					else
						begin	
						//$display("TRUTH: %x", jump_flash);
						pipcut_if_r <= pipcut_if_n;
						pipcut_id_r <= pipcut_id_n;
						pipcut_me_r <= pipcut_me_n;
						pipcut_wb_r <= pipcut_wb_n;
						end
			 end
			 else if(bubble)
			   begin
						pipcut_if_r <= pipcut_if_r;
						pipcut_id_r <= 0;
						pipcut_me_r <= pipcut_me_n;
						pipcut_wb_r <= pipcut_wb_n;
				end
        end
		  
		
		  

		   //pipcut for stage 2
		  /*control.is_load_op_s <= is_load_op_c;
		  control.op_writes_rf_s <= op_writes_rf_c;
		  control.is_byte_op_s <= is_byte_op_c;
		  control.is_mem_op_s <= is_mem_op_c;
		  control.is_store_op_s <= is_store_op_c;
		  
			
		  if (stall)
				begin
				
				pipcut_id.instr_id <= pipcut_id.instr_id;
				pipcut_id.rs_val_or_zero_id <= pipcut_id.rs_val_or_zero_id;
				pipcut_id.rd_val_or_zero_id <= pipcut_id.rd_val_or_zero_id;
				pipcut_id.control_id <= pipcut_id.control_id;
		   end
			else
				begin
				pipcut_id.instr_id <= pipcut_if.instr_if;
				pipcut_id.rs_val_or_zero_id <= rs_val_or_zero;
				pipcut_id.rd_val_or_zero_id <= rd_val_or_zero;
				pipcut_id.control_id <= control;
		  	end*/
			 /*
		  
    end
	 */
	 
	 // Next PC is based on network or the instruction
    always_comb
        begin
        PC_n = pc_plus1;    // Default to the next instruction.
		  if(net_PC_write_cmd_IDLE)
		     PC_n = net_packet_i.net_addr;
		  else 
			  unique casez(pipcut_id_r.instr_id)
					kJALR:
						PC_n = alu_result[0+:imem_addr_width_p];
					kBNEQZ, kBEQZ, kBLTZ, kBGTZ:
						if(jump_now)
							PC_n = imm_jump_add;
					default: begin end
				endcase
			end
    
    // Determine next PC
    assign pc_plus1     = PC_r + 1'b1;  // Increment PC.
    assign imm_jump_add = $signed(pipcut_id_r.instr_id.rs_imm) + $signed(pipcut_id_r.PC_r_id);  // Calculate possible branch address.
    /*

    // Next PC is based on network or the instruction
    always_comb
        begin
        PC_n = pc_plus1;    // Default to the next instruction.
		  //jump_flash = 0;
        // Should not update PC.
        //if (!PC_wen)
            //begin
					//PC_n = PC_r;
				//end
				
        // If the network is writing to PC, use that instead.
         if (net_PC_write_cmd_IDLE)
            begin
            PC_n = net_packet_i.net_addr;
            end
        else
            begin
            unique casez (pipcut_id_r.instr_id)
                // On a JALR, jump to the address in RS (passed via alu_result).
                kJALR:
                    begin
						  //jump_flash = 1;
                    PC_n = alu_result[0+:imem_addr_width_p];
                end
        
                // Branch instructions
                kBNEQZ, kBEQZ, kBLTZ, kBGTZ:
                    begin
						  
                    // If the branch is taken, use the calculated branch address.
                    if (jump_now)
                        begin
								//$display("jump %x\n",jump_flash);
								//jump_flash = 1;
                        PC_n = imm_jump_add;
                    end
                end
                
                default: 
					 begin 
					     //jump_flash = 0;
					 end
            endcase
        end
    end
    */
    // Selection between network and core for instruction address
    assign imem_addr = (net_imem_write_cmd) ? net_packet_i.net_addr
                                        : PC_n;
                                        
    // Instruction memory
    instr_mem #(
            .addr_width_p(imem_addr_width_p)
        ) 
        imem (
            .clk(clk),
            .addr_i(imem_addr),
            .instruction_i(net_instruction),
            .wen_i(imem_wen),
            .instruction_o(imem_out)
        );
    
    // Since imem has one cycle delay and we send next cycle's address, PC_n
    assign instruction = (PC_wen_r)? imem_out : instruction_r;

    // Decode module
    cl_decode decode (
        .instruction_i(pipcut_if_r.instr_if),
        .is_load_op_o(is_load_op_c),
        .op_writes_rf_o(op_writes_rf_c),
        .is_store_op_o(is_store_op_c),
        .is_mem_op_o(is_mem_op_c),
        .is_byte_op_o(is_byte_op_c)
    );
    
	 
    // Selection between network and address included in the instruction which is exeuted
    // Address for Reg. File is shorter than address of Ins. memory in network data
    // Since network can write into immediate registers, the address is wider
    // but for the destination register in an instruction the extra bits must be zero
    assign rd_addr = (net_reg_write_cmd)
                    ? (net_packet_i.net_addr [0+:($bits(instruction.rs_imm))])
                    : ({{($bits(instruction.rs_imm)-$bits(instruction.rd)){1'b0}}
                        ,{pipcut_wb_r.instr_wb.rd}});
    
    // Register file
    reg_file #(
            .addr_width_p($bits(instruction.rs_imm))
        )
        rf (
            .clk(clk),
            .rs_addr_i(pipcut_if_r.instr_if.rs_imm),
            //.rd_addr_i(rd_addr),
				.rd_addr_i({{($bits(instruction_r.rs_imm)-$bits(instruction_r.rd)){1'b0}},{pipcut_if_r.instr_if.rd}}),
            .w_addr_i(rd_addr),
            .wen_i(rf_wen),
            .w_data_i(rf_wd),
            .rs_val_o(rs_val),
            .rd_val_o(rd_val)
        );
    /*
    //assign rs_val_or_zero = pipcut_if_r.instr_if.rs_imm ? rs_val : 32'b0;
    //assign rd_val_or_zero = rd_addr            ? rd_val : 32'b0;
	 */
	 always_comb
	   unique casez (forwardA)
		2'b10:
			rs_val_or_zero = pipcut_me_r.alu_result_me;
		2'b01:
			rs_val_or_zero = rf_wd;
		default: 
			rs_val_or_zero = pipcut_id_r.instr_id.rs_imm? pipcut_id_r.rs_val_id : 32'b0;
		endcase
	 
	 always_comb
		unique casex(forwardB)
			2'b10: 
				rd_val_or_zero = pipcut_me_r.alu_result_me;
			2'b01: 
				rd_val_or_zero = rf_wd;
			default:
				rd_val_or_zero = pipcut_id_r.instr_id.rd? pipcut_id_r.rd_val_id: 32'b0;
	endcase
	
	assign pipcut_if_n.instr_if = instruction;
	assign pipcut_if_n.PC_r_if = PC_r;
	 
	 assign pipcut_id_n.instr_id = pipcut_if_r.instr_if;
	 assign pipcut_id_n.PC_r_id = pipcut_if_r.PC_r_if;
	 assign pipcut_id_n.rs_val_id = rs_val;
	 assign pipcut_id_n.rd_val_id = rd_val;
	 assign pipcut_id_n.control_id = control_fresh;
    
    // ALU
    alu alu_1 (
            //.rd_i(pipcut_id.rd_val_or_zero_id),
            //.rs_i(pipcut_id.rs_val_or_zero_id),
				.rd_i(rd_val_or_zero),
				.rs_i(rs_val_or_zero),
            //.op_i(pipcut_id.instr_id),
				.op_i(pipcut_id_r.instr_id),
            .result_o(alu_result),
            .jump_now_o(jump_now)
        );
		  
		 
	 assign pipcut_me_n.instr_me = pipcut_id_r.instr_id;
	 assign pipcut_me_n.PC_r_me = pipcut_id_r.PC_r_id;
	 assign pipcut_me_n.rs_val_me = rs_val_or_zero; 
	 assign pipcut_me_n.rd_val_me = rd_val_or_zero; 
	 assign pipcut_me_n.control_me = pipcut_id_r.control_id;
	 assign pipcut_me_n.alu_result_me = alu_result;
    
    // Data_mem
    assign to_mem_o = '{
        write_data    : pipcut_me_r.rs_val_me,
        valid         : valid_to_mem_c,
        wen           : pipcut_me_r.control_me.is_store_op_s,
        byte_not_word : pipcut_me_r.control_me.is_byte_op_s,
        yumi          : yumi_to_mem_c
    };
    assign data_mem_addr = pipcut_me_r.alu_result_me;
    
	 assign pipcut_wb_n.instr_wb = pipcut_me_r.instr_me;
	 assign pipcut_wb_n.PC_r_wb = pipcut_me_r.PC_r_me;
	 assign pipcut_wb_n.rs_val_wb = pipcut_me_r.rs_val_me;
	 assign pipcut_wb_n.rd_val_wb = pipcut_me_r.rd_val_me;
	 assign pipcut_wb_n.control_wb = pipcut_me_r.control_me;
	 assign pipcut_wb_n.alu_result_wb = pipcut_me_r.alu_result_me;
	 assign pipcut_wb_n.mem_i_wb = from_mem_i;
	 
    // stall and memory stages signals
    // rf structural hazard and imem structural hazard (can't load next instruction)
    assign stall_non_mem = (net_reg_write_cmd && pipcut_wb_r.control_wb.op_writes_rf_s)
                        || (net_imem_write_cmd);
    // Stall if LD/ST still active; or in non-RUN state
    //assign stall = stall_non_mem || (mem_stage_n != DMEM_REQ_ACKED) || (state_r != RUN) || bubble;
    assign stall = stall_non_mem || (mem_stage_n != 0) || (state_r != RUN) || bubble;
	 
    // Launch LD/ST: must hold valid high until data memory acknowledges request.
    assign valid_to_mem_c = pipcut_me_r.control_me.is_mem_op_s & (mem_stage_r < 2'b10);
    
    always_comb
        begin
        yumi_to_mem_c = 1'b0;
        mem_stage_n   = mem_stage_r;
        
        // Send data memory request.
        if (valid_to_mem_c)
            mem_stage_n   = DMEM_REQ_SENT;
        
        // Request from data memory acknowledged, must still wait for valid for completion.
        if (from_mem_i.yumi)
            mem_stage_n   = DMEM_REQ_ACKED;
        
        // If we get a valid from data memmory and can commit the LD/ST this cycle, then 
        // acknowledge dmem's response
        if (from_mem_i.valid & ~stall_non_mem)
            begin
            mem_stage_n   = DMEM_IDLE;   // Request completed, go back to idle.
            yumi_to_mem_c = 1'b1;   // Send acknowledge to data memory to finish access.
				end
    end
    
    // If either the network or instruction writes to the register file, set write enable.
    assign rf_wen = net_reg_write_cmd || (pipcut_wb_r.control_wb.op_writes_rf_s && (!stall || bubble));
    
    // Select the write data for register file from network, the PC_plus1 for JALR,
    // data memory or ALU result
    always_comb
        begin
        // When the network sends a reg file write command, take data from network.
        if (net_reg_write_cmd)
            begin
            rf_wd = net_packet_i.net_data;
            end
        // On a JALR, we want to write the return address to the destination register.
        else if (pipcut_wb_r.instr_wb ==? kJALR) // TODO: this is written poorly. 
            begin
            rf_wd = (pipcut_wb_r.instr_wb.rd == 0)? 0:pipcut_wb_r.PC_r_wb+1;
            end
        // On a load, we want to write the data from data memory to the destination register.
        else if (pipcut_wb_r.control_wb.is_load_op_s)
            begin
            rf_wd = pipcut_wb_r.mem_i_wb.read_data;
            end
        // Otherwise, the result should be the ALU output.
        else
            begin
            rf_wd = pipcut_wb_r.alu_result_wb;
        end
    end
    
	 
    // Sequential part, including barrier, exception and state
    always_ff @ (posedge clk)
        if (!n_reset)
			begin
				PC_r            <= 0;
            barrier_mask_r  <= 0;
            barrier_r       <= 0;
            state_r         <= IDLE;
				instruction_r   <= 0;
				PC_wen_r        <= 0;
            exception_o     <= 0;
            mem_stage_r     <= DMEM_IDLE;
				pipcut_if_r     <= 0;
				pipcut_id_r     <= 0;
				pipcut_me_r     <= 0;
				pipcut_wb_r     <= 0;
            end
        else
            begin
				if(PC_wen)
					begin
					PC_r <= PC_n;
					if(jump_now)
						begin
						pipcut_if_r     <= 0;
						pipcut_id_r     <= 0;
						pipcut_me_r     <= pipcut_me_n;
						pipcut_wb_r     <= pipcut_wb_n;
						end
					else if(net_PC_write_cmd_IDLE)
						begin
						pipcut_if_r     <= 0;
						pipcut_id_r     <= 0;
						pipcut_me_r     <= 0;
						pipcut_wb_r     <= 0;
						end
					else
						begin
						pipcut_if_r     <= pipcut_if_n;
						pipcut_id_r     <= pipcut_id_n;
						pipcut_me_r     <= pipcut_me_n;
						pipcut_wb_r     <= pipcut_wb_n;
						end
					end
				else if(bubble)
					begin
					pipcut_if_r <= pipcut_if_r;
					pipcut_id_r <= 0;
					pipcut_me_r <= pipcut_me_n;
					pipcut_wb_r <= pipcut_wb_n;
					end
					
            barrier_mask_r <= barrier_mask_n;
            barrier_r      <= barrier_n;
            state_r        <= state_n;
            exception_o    <= exception_n;
            mem_stage_r    <= mem_stage_n;
				instruction_r   <= instruction;
				PC_wen_r       <= PC_wen;
        end
	 
	 ///////////////////////////////////////////////
	 //hazard control START
	 ///////////////////////////////////////////////
	 
    //forwardA logic
	 always_comb begin
	    if(pipcut_me_r.control_me.op_writes_rf_s && pipcut_me_r.instr_me.rd && (pipcut_me_r.instr_me.rd == pipcut_id_r.instr_id.rs_imm))
		      forwardA = 2'b10;
		 else if (pipcut_wb_r.control_wb.op_writes_rf_s && pipcut_wb_r.instr_wb.rd && !(pipcut_wb_r.control_wb.op_writes_rf_s && pipcut_me_r.instr_me.rd &&
		          (pipcut_me_r.instr_me.rd === pipcut_id_r.instr_id.rs_imm)) && (pipcut_wb_r.instr_wb.rd === pipcut_id_r.instr_id.rs_imm))
				forwardA = 2'b01;
		 else 
				forwardA = 2'b00;
	 end
	 
	 //forwardB logic
	 always_comb begin
		if(pipcut_me_r.control_me.op_writes_rf_s && pipcut_me_r.instr_me.rd &&
				(pipcut_me_r.instr_me.rd == pipcut_id_r.instr_id.rd))
				forwardB = 2'b10;
		else if(pipcut_wb_r.control_wb.op_writes_rf_s && pipcut_wb_r.instr_wb.rd && !(pipcut_me_r.control_me.op_writes_rf_s && pipcut_me_r.instr_me.rd &&
		          (pipcut_me_r.instr_me.rd === pipcut_id_r.instr_id.rd)) && (pipcut_wb_r.instr_wb.rd === pipcut_id_r.instr_id.rd))
				forwardB = 2'b01;
		else 
				forwardB = 2'b00;
		end
		
		//Bubble logic
	  assign bubble = (pipcut_id_r.control_id.is_load_op_s || pipcut_id_r.control_id.is_store_op_s) &&
							 ((pipcut_id_r.instr_id.rd == pipcut_if_r.instr_if.rs_imm) ||
							 (pipcut_id_r.instr_id.rd == pipcut_if_r.instr_if.rd) ||
							  control_fresh.is_load_op_s || control_fresh.is_store_op_s);
	  
	 /////////////////////////////////////////////// 
	 //hazard control END
	 //////////////////////////////////////////////
	 
    // State machine
    cl_state_machine state_machine (
        .instruction_i(pipcut_me_r.instr_me),
        .state_i(state_r),
        .exception_i(exception_o),
        .net_PC_write_cmd_IDLE_i(net_PC_write_cmd_IDLE),
        .stall_i(stall),
        .state_o(state_n)
    );
    
    //---- Datapath with network ----//
    // Detect a valid packet for this core
    assign net_ID_match = (net_packet_i.ID == net_ID_p);
    
    // Network operation
    assign net_PC_write_cmd      = (net_ID_match && (net_packet_i.net_op == PC));       // Receive command from network to update PC.
    assign net_imem_write_cmd    = (net_ID_match && (net_packet_i.net_op == INSTR));    // Receive command from network to write instruction memory.
    assign net_reg_write_cmd     = (net_ID_match && (net_packet_i.net_op == REG));      // Receive command from network to write to reg file.
    assign net_bar_write_cmd     = (net_ID_match && (net_packet_i.net_op == BAR));      // Receive command from network for barrier write.
    assign net_PC_write_cmd_IDLE = (net_PC_write_cmd && (state_r == IDLE));
    
    // Barrier final result, in the barrier mask, 1 means not mask and 0 means mask
    assign barrier_o = barrier_mask_r & barrier_r;
    
    // The instruction write is just for network
    assign imem_wen  = net_imem_write_cmd;
    
    // Instructions are shorter than 32 bits of network data
    assign net_instruction = net_packet_i.net_data [0+:($bits(instruction))];
    
    // barrier_mask_n, which stores the mask for barrier signal
    always_comb
        begin
        // Change PC packet
        if (net_bar_write_cmd && (state_r != ERR))
            begin
            barrier_mask_n = net_packet_i.net_data [0+:mask_length_gp];
            end
        else
            begin
            barrier_mask_n = barrier_mask_r;
        end
    end
    
    // barrier_n signal, which contains the barrier value
    // it can be set by PC write network command if in IDLE
    // or by an an BAR instruction that is committing
    assign barrier_n = net_PC_write_cmd_IDLE
                    ? net_packet_i.net_data[0+:mask_length_gp]
                    : ((pipcut_me_r.instr_me ==? kBAR) & ~stall)
                        ? pipcut_me_r.alu_result_me [0+:mask_length_gp]
                        : barrier_r;
    
    // exception_n signal, which indicates an exception
    // We cannot determine next state as ERR in WORK state, since the instruction
    // must be completed, WORK state means start of any operation and in memory
    // instructions which could take some cycles, it could mean wait for the
    // response of the memory to aknowledge the command. So we signal that we recieved
    // a wrong package, but do not stop the execution. Afterwards the exception_r
    // register is used to avoid extra fetch after this instruction.
    always_comb
        begin
        if ((state_r == ERR) || (net_PC_write_cmd && (state_r != IDLE)))
            begin
            exception_n = 1'b1;
            end
        else
            begin
            exception_n = exception_o;
        end
    end
    
endmodule
