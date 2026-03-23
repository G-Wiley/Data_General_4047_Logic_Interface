//==========================================================================================================
// TTL IC functions
// MC3061 Dual J-K Flip Flop
// File Name: MC3061.v
// Functions: 
//   The 2 flip flops of an MC3061.
//
//==========================================================================================================

module MC3061(
    input wire clock,               // master clock 40 MHz
    input wire reset,               // active high synchronous reset input
    input wire p1,   // input common RESETB
    input wire p13,  // input common CLKB
    input wire p2,   // input 1 K
    input wire p3,   // input 1 J
    input wire p4,   // input 1 SETB
    input wire p12,  // input 2 K
    input wire p11,  // input 2 J
    input wire p10,  // input 2 SETB

    output wire p5,  // output 1Q
    output wire p6,  // output 1QB
    output wire p9,  // output 2Q
    output wire p8   // output 2QB
);

//============================ Internal Connections ==================================

    reg q1;   // output 1Q
    reg q2;   // output 2Q
    
    wire clkb;
    wire rstb;
    wire j1;
    wire k1;
    wire set1b;
    wire j2;
    wire k2;
    wire set2b;
    
    reg clkb_d;
    wire clk_enbl;

//============================ Start of Code =========================================

assign rstb = p1;
assign clkb = p13;

assign j1 = p3;
assign k1 = p2;
assign set1b = p4;

assign j2 = p11;
assign k2 = p12;
assign set2b = p10;

assign p5 = q1;
assign p6 = ~q1;
assign p9 = q2;
assign p8 = ~q2;

assign clk_enbl = ~clkb & clkb_d;

always @ (posedge clock)
begin : FLOP3061 // block name

  if(reset==1'b1) begin
    q1 <= 1'b0;
    q2 <= 1'b0;
    clkb_d <= clkb;
  end
  else begin
    clkb_d <= clkb;
    // D <= (J & ~Q) | (~K & Q);
    q1 <= ~rstb ? 1'b0 : (~set1b ? 1'b1 : (clk_enbl ? ((j1 & ~q1) | (~k1 & q1)) : q1));
    q2 <= ~rstb ? 1'b0 : (~set2b ? 1'b1 : (clk_enbl ? ((j2 & ~q2) | (~k2 & q2)) : q2));
  end
end
endmodule // End of Module MC3061
