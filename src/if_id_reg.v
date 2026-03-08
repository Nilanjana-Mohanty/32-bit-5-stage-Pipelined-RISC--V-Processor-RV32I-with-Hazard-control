module if_id_reg (
    input  wire        clk, reset, en, clear,
    input  wire [31:0] if_PC, if_PCPlus4, if_Instr,
    output reg  [31:0] id_PC, id_PCPlus4, id_Instr
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // 1. Hardware Asynchronous Reset
            id_PC <= 32'b0; id_PCPlus4 <= 32'b0; id_Instr <= 32'b0;
        end else if (clear) begin
            // 2. Synchronous Pipeline Flush (from Hazard Unit)
            id_PC <= 32'b0; id_PCPlus4 <= 32'b0; id_Instr <= 32'b0;
        end else if (en) begin
            // 3. Normal Operation
            id_PC <= if_PC; id_PCPlus4 <= if_PCPlus4; id_Instr <= if_Instr;
        end
    end
endmodule
