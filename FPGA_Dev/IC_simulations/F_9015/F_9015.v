//==========================================================================================================
// TTL IC functions
// 9015 Triple 2-Input NOR Gates with One 4-Input NOR Gate
// File Name: F_9015.v
// Functions: 
//   The 4 gates of a 9015.
//
//==========================================================================================================

module F_9015(
    input wire p2,   // input 1A
    input wire p3,   // input 1B
    input wire p5,   // input 2A
    input wire p6,   // input 2B
    input wire p10,  // input 3A
    input wire p11,  // input 3B
    input wire p1,   // input 4A
    input wire p15,  // input 4B
    input wire p14,  // input 4B
    input wire p13,  // input 4B

    output wire p4,  // output 1Y
    output wire p7,  // output 2Y
    output wire p9,  // output 3Y
    output wire p12  // output 4Y
);

//============================ Internal Connections ==================================

// no internal connections

//============================ Start of Code =========================================

assign p4 = ~(p2 | p3);
assign p7 = ~(p5 | p6);
assign p9 = ~(p10 | p11);
assign p12 = ~(p1 | p15 | p14 | p13);

endmodule // End of Module F_9015
