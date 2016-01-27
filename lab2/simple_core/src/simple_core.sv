/*  Simple Core
 *  
 *  Description: A simple CPU core that does not write to the register file.
 *  
 *  Notes:
 *      None.
 *
 *  Revision History:
 *      sokai       01/19/2016  1) Initial revision.
 *
 */
 
import simple_definitions::*;

module simple_core (
        input clk,                          // Clock
        input n_reset,                      // Active low reset
        output logic [31:0] alu_result_o,   // ALU result
        output logic alu_result_valid_o,    // ALU result is valid flag
        output logic stop_o                 // Stop execution flag
    );
    
    logic [2:0] pc;
    const int MAX_PC = 7;
    
    instruction_s instruction;
    logic rf_wen = 0;           // This core does not modify the reg file, no feedback.
    logic [31:0] rd_val;
    logic [31:0] rs_val;
    logic [31:0] alu_result;
    logic stop;
	 
	 reg [31:0] regFile_to_ALU1;
	 reg [31:0] regFile_to_ALU2;
	 
	 instruction_s inst_regOne;
	 instruction_s inst_regTwo;
	 
    
    always_ff @(posedge clk)
        begin
        // Clear PC on reset.
        if (!n_reset)
            begin
            pc <= 0;
            end
        // Increment PC unless it has reached its max value.
        else if (pc != MAX_PC)
            begin
            pc <= pc + 1;
        end
		  
		  regFile_to_ALU1 <= rs_val;
		  regFile_to_ALU2 <= rd_val;
		  
		  inst_regOne <= instruction;
		  inst_regTwo <= inst_regOne;
    end // always_ff
    
    // Instruction memory
    simple_imem imem (
        .clk(clk),
        .n_reset(n_reset),
        .addr_i(pc),
        .instruction(instruction)
    );
    
    // Register file
    simple_reg_file rf (
        .clk(clk),
        //.rs_addr_i(instruction.rs),
		  .rs_addr_i(inst_regOne.rs),
        //.rd_addr_i(instruction.rd),
		  .rd_addr_i(inst_regOne.rd),
        .rs_val_o(rs_val),
        .rd_val_o(rd_val)
    );
    
    // ALU
    simple_alu alu (
        //.rd_i(rd_val),
		  .rd_i(regFile_to_ALU2),
        //.rs_i(rs_val),
		  .rs_i(regFile_to_ALU1),
        .op_i(inst_regTwo),
        .writes_rf_o(alu_result_valid),
        .result_o(alu_result),
        .stop_o(stop)
    );
    
    always_ff @(posedge clk)
        begin
        if (!n_reset) 
            begin
            end
        else
            begin
            alu_result_o <= alu_result;
            alu_result_valid_o <= alu_result_valid;
            stop_o <= stop;
        end
    end
    
endmodule
