module datapath (
    input  wire        clk, reset,
    
    // Control Signals coming IN from the Brain
    input  wire        RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD,
    input  wire [1:0]  ResultSrcD,
    input  wire [2:0]  ALUControlD, ImmSrcD,
    
    // Signal going OUT to the Brain
    output wire [31:0] InstrD
);

    // Hazard Wires
    wire StallF, StallD, FlushD, FlushE;
    wire [1:0] ForwardAE, ForwardBE;
    wire PCSrcE; // Resolved in EX Stage

    // ================== STAGE 1: FETCH (F) ==================
    wire [31:0] PCF, PCPlus4F, InstrF, PCNextF;
    wire [31:0] PCTargetE; // Comes from EX stage

    mux2 #(32) pcmux (.d0(PCPlus4F), .d1(PCTargetE), .s(PCSrcE), .y(PCNextF));
    pc         pcreg (.clk(clk), .reset(reset), .en(~StallF), .PCNext(PCNextF), .PC(PCF));
    adder      pcadd4(.a(PCF), .b(32'd4), .y(PCPlus4F));
    imem       imem  (.A(PCF), .RD(InstrF));

    // ================== IF/ID PIPELINE WALL ==================
    wire [31:0] PCD, PCPlus4D;
    if_id_reg ifid (.clk(clk), .reset(reset), .en(~StallD), .clear(FlushD), 
                    .if_PC(PCF), .if_PCPlus4(PCPlus4F), .if_Instr(InstrF),
                    .id_PC(PCD), .id_PCPlus4(PCPlus4D), .id_Instr(InstrD));

    // ================== STAGE 2: DECODE (D) ==================
    wire [31:0] RD1D, RD2D, ImmExtD;
    wire [31:0] ResultW; // Comes from WB stage
    wire [4:0]  RdW;     // Comes from WB stage
    wire        RegWriteW; // Comes from WB stage

    regfile rf (.clk(clk), .WE3(RegWriteW), .A1(InstrD[19:15]), .A2(InstrD[24:20]), 
                .A3(RdW), .WD3(ResultW), .RD1(RD1D), .RD2(RD2D));
    extend  ext(.Instr(InstrD[31:7]), .ImmSrc(ImmSrcD), .ImmExt(ImmExtD));

    // ================== ID/EX PIPELINE WALL ==================
    wire RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE;
    wire [1:0] ResultSrcE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E;
    wire [4:0] Rs1E, Rs2E, RdE;

    id_ex_reg idex (.clk(clk), .reset(reset), .clear(FlushE),
                    .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD),
                    .JumpD(JumpD), .BranchD(BranchD), .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD),
                    .RD1(RD1D), .RD2(RD2D), .PCD(PCD), .ImmExtD(ImmExtD), .PCPlus4D(PCPlus4D),
                    .Rs1D(InstrD[19:15]), .Rs2D(InstrD[24:20]), .RdD(InstrD[11:7]),
                    
                    .RegWriteE(RegWriteE), .ResultSrcE(ResultSrcE), .MemWriteE(MemWriteE),
                    .JumpE(JumpE), .BranchE(BranchE), .ALUControlE(ALUControlE), .ALUSrcE(ALUSrcE),
                    .RD1E(RD1E), .RD2E(RD2E), .PCE(PCE), .ImmExtE(ImmExtE), .PCPlus4E(PCPlus4E),
                    .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE));

    // ================== STAGE 3: EXECUTE (E) ==================
    wire [31:0] SrcAE, SrcBE, WriteDataE, ALUResultE;
    wire [31:0] ALUResultM; // Comes from MEM stage
    wire ZeroE;

    // Hazard Forwarding Muxes
    mux3 #(32) fa_mux (.d0(RD1E), .d1(ResultW), .d2(ALUResultM), .s(ForwardAE), .y(SrcAE));
    mux3 #(32) fb_mux (.d0(RD2E), .d1(ResultW), .d2(ALUResultM), .s(ForwardBE), .y(WriteDataE));
    
    mux2 #(32) srcbmux(.d0(WriteDataE), .d1(ImmExtE), .s(ALUSrcE), .y(SrcBE));
    alu        alu    (.SrcA(SrcAE), .SrcB(SrcBE), .ALUControl(ALUControlE), .ALUResult(ALUResultE), .Zero(ZeroE));
    adder      pcaddbranch(.a(PCE), .b(ImmExtE), .y(PCTargetE));
    
    // Resolve Control Hazard
    assign PCSrcE = JumpE | (BranchE & ZeroE);

    // ================== EX/MEM PIPELINE WALL ==================
    wire RegWriteM, MemWriteM;
    wire [1:0] ResultSrcM;
    wire [31:0] WriteDataM, ImmExtM, PCPlus4M;
    wire [4:0] RdM;

    ex_mem_reg exmem (.clk(clk), .reset(reset),
                      .RegWriteE(RegWriteE), .ResultSrcE(ResultSrcE), .MemWriteE(MemWriteE),
                      .ALUResultE(ALUResultE), .WriteDataE(WriteDataE), .ImmExtE(ImmExtE), .PCPlus4E(PCPlus4E), .RdE(RdE),
                      
                      .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .MemWriteM(MemWriteM),
                      .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .ImmExtM(ImmExtM), .PCPlus4M(PCPlus4M), .RdM(RdM));

    // ================== STAGE 4: MEMORY (M) ==================
    wire [31:0] ReadDataM;
    dmem dmem (.clk(clk), .WE(MemWriteM), .A(ALUResultM), .WD(WriteDataM), .RD(ReadDataM));

    // ================== MEM/WB PIPELINE WALL ==================
    wire [1:0] ResultSrcW;
    wire [31:0] ALUResultW, ReadDataW, ImmExtW, PCPlus4W;

    mem_wb_reg memwb (.clk(clk), .reset(reset),
                      .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM),
                      .ALUResultM(ALUResultM), .ReadDataM(ReadDataM), .ImmExtM(ImmExtM), .PCPlus4M(PCPlus4M), .RdM(RdM),
                      
                      .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW),
                      .ALUResultW(ALUResultW), .ReadDataW(ReadDataW), .ImmExtW(ImmExtW), .PCPlus4W(PCPlus4W), .RdW(RdW));

    // ================== STAGE 5: WRITEBACK (W) ==================
    mux4 #(32) resmux (.d0(ALUResultW), .d1(ReadDataW), .d2(PCPlus4W), .d3(ImmExtW), .s(ResultSrcW), .y(ResultW));

    // ================== THE HAZARD UNIT ==================
    hazard_unit hu (
        .Rs1D(InstrD[19:15]), .Rs2D(InstrD[24:20]), 
        .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE),
        .PCSrcE(PCSrcE), .ResultSrcE(ResultSrcE),
        .RdM(RdM), .RegWriteM(RegWriteM),
        .RdW(RdW), .RegWriteW(RegWriteW),
        
        .StallF(StallF), .StallD(StallD),
        .FlushD(FlushD), .FlushE(FlushE),
        .ForwardAE(ForwardAE), .ForwardBE(ForwardBE)
    );

endmodule
