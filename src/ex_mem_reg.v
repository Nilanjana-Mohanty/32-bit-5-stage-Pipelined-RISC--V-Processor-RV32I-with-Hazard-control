module ex_mem_reg (
    input  wire        clk, reset,
    // Control
    input  wire        RegWriteE, MemWriteE,
    input  wire [1:0]  ResultSrcE,
    // Data
    input  wire [31:0] ALUResultE, WriteDataE, ImmExtE, PCPlus4E,
    input  wire [4:0]  RdE,
    
    // Outputs
    output reg         RegWriteM, MemWriteM,
    output reg  [1:0]  ResultSrcM,
    output reg  [31:0] ALUResultM, WriteDataM, ImmExtM, PCPlus4M,
    output reg  [4:0]  RdM
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            RegWriteM <= 0; MemWriteM <= 0; ResultSrcM <= 0;
            ALUResultM <= 0; WriteDataM <= 0; ImmExtM <= 0; PCPlus4M <= 0; RdM <= 0;
        end else begin
            RegWriteM <= RegWriteE; MemWriteM <= MemWriteE; ResultSrcM <= ResultSrcE;
            ALUResultM <= ALUResultE; WriteDataM <= WriteDataE; ImmExtM <= ImmExtE; PCPlus4M <= PCPlus4E; RdM <= RdE;
        end
    end
endmodule
