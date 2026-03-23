//==========================================================================================================
// TTL IC functions
// SN7474 Dual Type-D Flip Flop
// File Name: SN7474.v
// Functions: 
//   The 2 flip flops of a 7474.
//
//==========================================================================================================

module SN7474(
    input wire clock,               // master clock 40 MHz
    input wire reset,               // active high synchronous reset input
    input wire p1,   // input 1 CLR
    input wire p2,   // input 1 D
    input wire p3,   // input 1 CK
    input wire p4,   // input 1 PR
    input wire p13,  // input 2 CLR
    input wire p12,  // input 2 D
    input wire p11,  // input 2 CK
    input wire p10,  // input 2 PR

    output wire p5,  // output 1Q
    output wire p6,  // output 1QB
    output wire p9,  // output 2Q
    output wire p8   // output 2QB
);

//============================ Internal Connections ==================================

    reg q1;   // output 1Q
    reg q2;   // output 2Q
    
    wire clr1b;
    wire d1;
    wire ck1;
    wire pre1b;
    wire clr2b;
    wire d2;
    wire ck2;
    wire pre2b;
    
    reg ck1_d;
    reg ck2_d;
    wire ck1_enbl;
    wire ck2_enbl;

//============================ Start of Code =========================================

assign clr1b = p1;
assign d1 = p2;
assign ck1 = p3;
assign pre1b = p4;

assign clr2b = p13;
assign d2 = p12;
assign ck2 = p11;
assign pre2b = p10;

assign p5 = q1;
assign p6 = ~q1;
assign p9 = q2;
assign p8 = ~q2;

assign ck1_enbl = ck1 & ~ck1_d;
assign ck2_enbl = ck2 & ~ck2_d;

always @ (posedge clock)
begin : FLOP74 // block name

  if(reset==1'b1) begin
    q1 <= 1'b0;
    q2 <= 1'b0;
    ck1_d <= ck1;
    ck2_d <= ck2;
  end
  else begin
    ck1_d <= ck1;
    ck2_d <= ck2;
    q1 <= ~clr1b ? 1'b0 : (~pre1b ? 1'b1 : (ck1_enbl ? d1 : q1));
    q2 <= ~clr2b ? 1'b0 : (~pre2b ? 1'b1 : (ck2_enbl ? d2 : q2));
  end
end
endmodule // End of Module SN7474
