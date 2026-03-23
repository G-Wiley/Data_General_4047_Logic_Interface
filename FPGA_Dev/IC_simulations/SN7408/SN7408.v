//==========================================================================================================
// TTL IC functions
// SN7408 Quad 2-Input AND
// File Name: SN7408.v
// Functions: 
//   The 4 gates of a 7408.
//
//==========================================================================================================

module SN7408(
    input wire p1,   // input 1A
    input wire p2,   // input 1B
    input wire p4,   // input 2A
    input wire p5,   // input 2B
    input wire p9,   // input 3A
    input wire p10,  // input 3B
    input wire p12,  // input 4A
    input wire p13,  // input 4B

    output wire p3,  // output 1Y
    output wire p6,  // output 2Y
    output wire p8,  // output 3Y
    output wire p11  // output 4Y
);

//============================ Internal Connections ==================================

// no internal connections

//============================ Start of Code =========================================

assign p3 = p1 & p2;
assign p6 = p4 & p5;
assign p8 = p9 & p10;
assign p11 = p12 & p13;

endmodule // End of Module SN7408
