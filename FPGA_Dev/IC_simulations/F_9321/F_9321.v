//==========================================================================================================
// TTL IC functions
// Fairchild 9321 Dual 2-Line to 4-Line Decoder/Demultiplexer
// File Name: F_9321.v
// Functions: 
//   Two four-output decoders.
//
//==========================================================================================================

module F_9321(
    input wire p1,   // input ~1E
    input wire p2,   // input 1A0
    input wire p3,   // input 1A1
    input wire p13,  // input 2A1
    input wire p14,  // input 2A0
    input wire p15,  // input ~2E

    output wire p4,  // output ~1Y0
    output wire p5,  // output ~1Y1
    output wire p6,  // output ~1Y2
    output wire p7,  // output ~1Y3
    output wire p9,  // output ~2Y3
    output wire p10, // output ~2Y2
    output wire p11, // output ~2Y1
    output wire p12  // output ~2Y0
);

//============================ Internal Connections ==================================

// no internal connections

//============================ Start of Code =========================================

assign p4  = ~(~p1 & ~p3 & ~p2); // output ~1Y0 = 1E & ~1A1 & ~1A0
assign p5  = ~(~p1 & ~p3 &  p2); // output ~1Y1 = 1E & ~1A1 &  1A0
assign p6  = ~(~p1 &  p3 & ~p2); // output ~1Y2 = 1E &  1A1 & ~1A0
assign p7  = ~(~p1 &  p3 &  p2); // output ~1Y3 = 1E &  1A1 &  1A0

assign p12 = ~(~p15 & ~p13 & ~p14); // output ~2Y0 = 2E & ~2A1 & ~2A0
assign p11 = ~(~p15 & ~p13 &  p14); // output ~2Y1 = 2E & ~2A1 &  2A0
assign p10 = ~(~p15 &  p13 & ~p14); // output ~2Y2 = 2E &  2A1 & ~2A0
assign p9  = ~(~p15 &  p13 &  p14); // output ~2Y3 = 2E &  2A1 &  2A0

endmodule // End of Module F_9321
