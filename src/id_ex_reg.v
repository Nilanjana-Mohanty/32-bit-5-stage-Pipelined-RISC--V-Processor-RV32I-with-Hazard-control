module id_ex_reg (
    input  wire        clk, reset, clear,
    input  wire        RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD,
    input  wire [1:0]  ResultSrcD, 
    input  wire [2:0]  ALUControlD,
    input  wire [31:0] RD1, RD2, PCD, ImmExtD, PCPlus4D,
    input  wire [4:0]  Rs1D, Rs2D, RdD,
    
    output reg         RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
    output reg  [1:0]  ResultSrcE,
    output reg  [2:0]  ALUControlE,
    output reg  [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E,
    output reg  [4:0]  Rs1E, Rs2E, RdE
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // 1. Hardware Asynchronous Reset
            RegWriteE <= 0; MemWriteE <= 0; JumpE <= 0; BranchE <= 0; ALUSrcE <= 0;
            ResultSrcE <= 0; ALUControlE <= 0;
            RD1E <= 0; RD2E <= 0; PCE <= 0; ImmExtE <= 0; PCPlus4E <= 0;
            Rs1E <= 0; Rs2E <= 0; RdE <= 0;
        end else if (clear) begin
            // 2. Synchronous Pipeline Flush (from Hazard Unit)
            RegWriteE <= 0; MemWriteE <= 0; JumpE <= 0; BranchE <= 0; ALUSrcE <= 0;
            ResultSrcE <= 0; ALUControlE <= 0;
            RD1E <= 0; RD2E <= 0; PCE <= 0; ImmExtE <= 0; PCPlus4E <= 0;
            Rs1E <= 0; Rs2E <= 0; RdE <= 0;
        end else begin
            // 3. Normal Operation
            RegWriteE <= RegWriteD; MemWriteE <= MemWriteD; JumpE <= JumpD; BranchE <= BranchD; ALUSrcE <= ALUSrcD;
            ResultSrcE <= ResultSrcD; ALUControlE <= ALUControlD;
            RD1E <= RD1; RD2E <= RD2; PCE <= PCD; ImmExtE <= ImmExtD; PCPlus4E <= PCPlus4D;
            Rs1E <= Rs1D; Rs2E <= Rs2D; RdE <= RdD;
        end
    end
endmodule
