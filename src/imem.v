module imem (
    input  wire [31:0] A,
    output wire [31:0] RD
);
    reg [31:0] RAM [63:0];
    initial $readmemh("mem/program.hex", RAM);
    assign RD = RAM[A[7:2]]; // Word aligned read
endmodule
