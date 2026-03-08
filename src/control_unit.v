module control_unit (
    input  wire [6:0] op,
    input  wire [2:0] funct3,
    input  wire       funct7_5,
    
    output wire       RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD,
    output wire [1:0] ResultSrcD,
    output reg  [2:0] ALUControlD, ImmSrcD
);
    reg [1:0] ALUOp;
    reg       Main_RegWrite, Main_MemWrite, Main_Jump, Main_Branch, Main_ALUSrc;
    reg [1:0] Main_ResultSrc;

    // 1. MAIN DECODER
    always @(*) begin
        Main_RegWrite = 0; ImmSrcD = 3'b000; Main_ALUSrc = 0; Main_MemWrite = 0; 
        Main_ResultSrc = 2'b00; Main_Branch = 0; Main_Jump = 0; ALUOp = 2'b00;
        
        case(op)
            7'b0000011: begin Main_RegWrite=1; ImmSrcD=3'b000; Main_ALUSrc=1; Main_MemWrite=0; Main_ResultSrc=2'b01; end // lw
            7'b0100011: begin Main_RegWrite=0; ImmSrcD=3'b001; Main_ALUSrc=1; Main_MemWrite=1; Main_ResultSrc=2'b00; end // sw
            7'b0110011: begin Main_RegWrite=1; ImmSrcD=3'b000; Main_ALUSrc=0; Main_MemWrite=0; Main_ResultSrc=2'b00; ALUOp=2'b10; end // R-Type
            7'b1100011: begin Main_RegWrite=0; ImmSrcD=3'b010; Main_ALUSrc=0; Main_MemWrite=0; Main_ResultSrc=2'b00; Main_Branch=1; ALUOp=2'b01; end // beq
            7'b0010011: begin Main_RegWrite=1; ImmSrcD=3'b000; Main_ALUSrc=1; Main_MemWrite=0; Main_ResultSrc=2'b00; ALUOp=2'b10; end // I-Type
            7'b1101111: begin Main_RegWrite=1; ImmSrcD=3'b011; Main_ALUSrc=0; Main_MemWrite=0; Main_ResultSrc=2'b10; Main_Jump=1; end // jal
            7'b0110111: begin Main_RegWrite=1; ImmSrcD=3'b100; Main_ALUSrc=0; Main_MemWrite=0; Main_ResultSrc=2'b11; end // lui
        endcase
    end

    // 2. ALU DECODER
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControlD = 3'b000; 
            2'b01: ALUControlD = 3'b001; 
            2'b10: begin                
                case(funct3)
                    3'b000: if ({op[5], funct7_5} == 2'b11) ALUControlD = 3'b001; else ALUControlD = 3'b000;
                    3'b010: ALUControlD = 3'b101; 
                    3'b110: ALUControlD = 3'b011; 
                    3'b111: ALUControlD = 3'b010; 
                    default: ALUControlD = 3'b000;
                endcase
            end
            default: ALUControlD = 3'b000;
        endcase
    end

    assign RegWriteD  = Main_RegWrite;
    assign MemWriteD  = Main_MemWrite;
    assign JumpD      = Main_Jump;
    assign BranchD    = Main_Branch;
    assign ALUSrcD    = Main_ALUSrc;
    assign ResultSrcD = Main_ResultSrc;
endmodule
