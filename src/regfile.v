module regfile (
    input  wire        clk, WE3,
    input  wire [4:0]  A1, A2, A3,
    input  wire [31:0] WD3,
    output wire [31:0] RD1, RD2
);
    reg [31:0] rf [31:0];
    
    // Asynchronous read (Register 0 is hardwired to 0)
    assign RD1 = (A1 != 5'b0) ? rf[A1] : 32'b0;
    assign RD2 = (A2 != 5'b0) ? rf[A2] : 32'b0;

    // Synchronous write
    always @(posedge clk) begin
        if (WE3) rf[A3] <= WD3;
    end
endmodule
