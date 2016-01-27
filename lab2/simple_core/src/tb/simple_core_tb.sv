/*  Simple Core Test Bench
 *  
 *  Description: A test bench for the simple core.
 *  
 *  Notes:
 *      None.
 *
 *  Revision History:
 *      sokai       01/19/2016  1) Initial revision.
 *
 */
 
`timescale 1ns / 1ps

module simple_core_tb();
    logic clk;
    logic n_reset;
	 logic n_reset_q;
	 logic n_reset_qq;
    logic [31:0] alu_result;
    logic alu_result_valid;
    logic stop;
    logic [0:2] stop_shr;
    int sim_pass = 0;
    int i = 0;
    int NUM_TESTS = 16;
    
    // Expected valid flags
    logic [0:7] expected_alu_valid = 8'b11101110;
    
    // Expected outputs
    logic [31:0] expected_alu_result[0:7] = {32'h00000008, 32'hFFFFFFFE, 
                                             32'h00000008, 32'h00000000,
                                             32'h00000003, 32'hFFFFFFFF,
                                             32'h00000007, 32'h00000000};
                                             
                                             
    
    // Toggle the clock every 10 ns
    initial
        begin
        clk = 0;
        forever #10ns clk = !clk;
    end
    
    initial
        begin
        // Hold reset for 4 clocks.
        n_reset = 0;
        @ (negedge clk);
        @ (negedge clk);
        @ (negedge clk);
        @ (negedge clk);
        n_reset = 1;
    end
    
    always_ff @(negedge clk)
        begin
        
        // Clear stop signal shift register.
        if (!n_reset_qq)
            begin
            stop_shr <= 0;
            end
        else
            begin
            // If not stopped yet, check outputs.
            if (!stop_shr[0])
                begin
                sim_pass += (alu_result_valid == expected_alu_valid[i]) + 
                                (alu_result == expected_alu_result[i]);
                i++;
            end
            
            // Shift stop signal through. This makes sure we stop after the stop signal is
            // output.
            stop_shr[0:2] <= {stop, stop_shr[0:1]};
            if (stop_shr[2])
                begin
                if (sim_pass != NUM_TESTS)
                    begin
                    $display("Test failed!");
                    end
                else
                    begin
                    $display("All tests passed!");
                end               
                $stop;
            end
        end
    end
	 
	 always@(posedge clk) begin
		n_reset_q <= n_reset;
		n_reset_qq <= n_reset_q;
	 end
    
    simple_core dut (
        .clk(clk),
        .n_reset(n_reset),
        .alu_result_o(alu_result),
        .alu_result_valid_o(alu_result_valid),
        .stop_o(stop)
    );
    
endmodule
    