module top (
    input wire clk, reset
);
    wire [31:0] InstrD;
    wire RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;
    wire [1:0] ResultSrcD;
    wire [2:0] ALUControlD, ImmSrcD;

    control_unit c_unit (
        .op(InstrD[6:0]), .funct3(InstrD[14:12]), .funct7_5(InstrD[30]),
        .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD),
        .JumpD(JumpD), .BranchD(BranchD), .ALUSrcD(ALUSrcD), 
        .ALUControlD(ALUControlD), .ImmSrcD(ImmSrcD)
    );

    datapath d_path (
        .clk(clk), .reset(reset),
        .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD),
        .JumpD(JumpD), .BranchD(BranchD), .ALUSrcD(ALUSrcD), 
        .ALUControlD(ALUControlD), .ImmSrcD(ImmSrcD),
        .InstrD(InstrD)
    );
endmodule
