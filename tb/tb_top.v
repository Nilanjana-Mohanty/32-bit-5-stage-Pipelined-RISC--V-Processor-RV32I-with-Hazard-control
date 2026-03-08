`timescale 1ns / 1ps
module tb_top;
    reg clk, reset;
    
    top uut (.clk(clk), .reset(reset));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $dumpfile("riscv_pipeline.vcd");
        $dumpvars(0, tb_top);

        reset = 1; #15; reset = 0; 
        #250; // Run longer so the pipeline has time to flush out

        $display("Simulation Complete.");
        $finish;
    end
endmodule
