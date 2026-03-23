//==========================================================================================================
// TTL IC functions
// SN7404 Hex Inverter
// File Name: SN7404.v
// Functions: 
//   The 6 gates of a 7404.
//
//==========================================================================================================

module SN7404(
    input wire p1,   // input 1A
    input wire p3,   // input 2A
    input wire p5,   // input 3A
    input wire p9,   // input 4A
    input wire p11,  // input 5A
    input wire p13,  // input 6A

    output wire p2,  // output 1Y
    output wire p4,  // output 2Y
    output wire p6,  // output 3Y
    output wire p8,  // output 4Y
    output wire p10, // output 5Y
    output wire p12  // output 6Y
);

//============================ Internal Connections ==================================

// no internal connections

//============================ Start of Code =========================================

assign p2 = ~p1;
assign p4 = ~p3;
assign p6 = ~p5;
assign p8 = ~p9;
assign p10 = ~p11;
assign p12 = ~p13;

endmodule // End of Module SN7404
