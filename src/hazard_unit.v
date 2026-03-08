module hazard_unit (
    input  wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    input  wire       RegWriteM, RegWriteW, PCSrcE,
    input  wire [1:0] ResultSrcE,
    
    output wire       StallF, StallD, FlushD, FlushE,
    output reg  [1:0] ForwardAE, ForwardBE
);
    wire lwStall;

    // 1. Data Hazards (Forwarding)
    always @(*) begin
        if      (((Rs1E == RdM) && RegWriteM) && (Rs1E != 5'b0)) ForwardAE = 2'b10;
        else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 5'b0)) ForwardAE = 2'b01;
        else                                                     ForwardAE = 2'b00; 

        if      (((Rs2E == RdM) && RegWriteM) && (Rs2E != 5'b0)) ForwardBE = 2'b10;
        else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 5'b0)) ForwardBE = 2'b01;
        else                                                     ForwardBE = 2'b00; 
    end

    // 2. Load-Use Hazards (Stalling)
    assign lwStall = (ResultSrcE == 2'b01) & ((Rs1D == RdE) | (Rs2D == RdE));
    assign StallF  = lwStall;
    assign StallD  = lwStall;

    // 3. Control Hazards (Flushing)
    assign FlushD  = PCSrcE;
    assign FlushE  = lwStall | PCSrcE;
endmodule
