module alu (
    input  wire [31:0] SrcA, SrcB,
    input  wire [2:0]  ALUControl,
    output reg  [31:0] ALUResult,
    output wire        Zero
);
    always @(*) begin
        case(ALUControl)
            3'b000: ALUResult = SrcA + SrcB;
            3'b001: ALUResult = SrcA - SrcB;
            3'b010: ALUResult = SrcA & SrcB;
            3'b011: ALUResult = SrcA | SrcB;
            3'b101: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; // slt
            default: ALUResult = 32'b0;
        endcase
    end
    assign Zero = (ALUResult == 32'b0);
endmodule
