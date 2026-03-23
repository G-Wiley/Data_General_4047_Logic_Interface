//==========================================================================================================
// TTL IC functions
// SN7440 Quad 2-Input NAND
// File Name: SN7440.v
// Functions: 
//   The 2 gates of a 7440.
//
//==========================================================================================================

module SN7440(
    input wire p1,   // input 1A
    input wire p2,   // input 1B
    input wire p4,   // input 1C
    input wire p5,   // input 1D
    input wire p9,   // input 2A
    input wire p10,  // input 2B
    input wire p12,  // input 2C
    input wire p13,  // input 2D

    output wire p6,  // output 1Y
    output wire p8   // output 2Y
);

//============================ Internal Connections ==================================

// no internal connections

//============================ Start of Code =========================================

assign p6 = ~(p1 & p2 & p4 & p5);
assign p8 = ~(p9 & p10 & p12 & p13);

endmodule // End of Module SN7440
