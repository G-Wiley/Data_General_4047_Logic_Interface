//==========================================================================================================
// TTL IC functions
// SN7410 Triple 3-Input NAND
// File Name: SN7410.v
// Functions: 
//   The 3 gates of a 7410.
//
//==========================================================================================================

module SN7410(
    input wire p1,   // input 1A
    input wire p2,   // input 1B
    input wire p13,  // input 1C
    input wire p3,   // input 2A
    input wire p4,   // input 2B
    input wire p5,   // input 2C
    input wire p9,   // input 3A
    input wire p10,  // input 3B
    input wire p11,  // input 3C

    output wire p12, // output 1Y
    output wire p6,  // output 2Y
    output wire p8   // output 3Y
);

//============================ Internal Connections ==================================

// no internal connections

//============================ Start of Code =========================================

assign p12 = ~(p1 & p2 & p13);
assign p6 = ~(p3 & p4 & p5);
assign p8 = ~(p9 & p10 & p11);

endmodule // End of Module SN7410
