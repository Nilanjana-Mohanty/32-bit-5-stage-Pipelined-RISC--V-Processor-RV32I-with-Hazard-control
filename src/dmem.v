module dmem (
    input  wire        clk, WE,
    input  wire [31:0] A, WD,
    output wire [31:0] RD
);
    reg [31:0] RAM [63:0];
    assign RD = RAM[A[7:2]]; // Word aligned read

    always @(posedge clk) begin
        if (WE) RAM[A[7:2]] <= WD;
    end
endmodule
