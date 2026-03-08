module mem_wb_reg (
    input  wire        clk, reset,
    // Control
    input  wire        RegWriteM,
    input  wire [1:0]  ResultSrcM,
    // Data
    input  wire [31:0] ALUResultM, ReadDataM, ImmExtM, PCPlus4M,
    input  wire [4:0]  RdM,
    
    // Outputs
    output reg         RegWriteW,
    output reg  [1:0]  ResultSrcW,
    output reg  [31:0] ALUResultW, ReadDataW, ImmExtW, PCPlus4W,
    output reg  [4:0]  RdW
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            RegWriteW <= 0; ResultSrcW <= 0;
            ALUResultW <= 0; ReadDataW <= 0; ImmExtW <= 0; PCPlus4W <= 0; RdW <= 0;
        end else begin
            RegWriteW <= RegWriteM; ResultSrcW <= ResultSrcM;
            ALUResultW <= ALUResultM; ReadDataW <= ReadDataM; ImmExtW <= ImmExtM; PCPlus4W <= PCPlus4M; RdW <= RdM;
        end
    end
endmodule
