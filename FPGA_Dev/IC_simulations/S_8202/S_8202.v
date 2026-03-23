//==========================================================================================================
// TTL IC functions
// 8202 10-bit Buffer Register
// File Name: S_8202.v
// Functions: 
//   The 10 D-type flip flops of a Signetics 8202.
//
//==========================================================================================================

module S_8202(
    input wire clock,               // master clock 40 MHz
    input wire reset,               // active high synchronous reset input
    input wire p1,   // input CLK
    input wire p2,   // input D1
    input wire p3,   // input D2
    input wire p4,   // input D3
    input wire p5,   // input D4
    input wire p6,   // input D5
    input wire p7,   // input D6
    input wire p8,   // input D7
    input wire p9,   // input D8
    input wire p10,  // input D9
    input wire p11,  // input D10
    input wire p23,  // input RESETB

    output wire p13,  // output Q10
    output wire p14,  // output Q9
    output wire p15,  // output Q8
    output wire p16,  // output Q7
    output wire p17,  // output Q6
    output wire p18,  // output Q5
    output wire p19,  // output Q4
    output wire p20,  // output Q3
    output wire p21,  // output Q2
    output wire p22   // output Q1
);

//============================ Internal Connections ==================================

    reg q1;   // output Q1
    reg q2;   // output Q2
    reg q3;   // output Q3
    reg q4;   // output Q4
    reg q5;   // output Q5
    reg q6;   // output Q6
    reg q7;   // output Q7
    reg q8;   // output Q8
    reg q9;   // output Q9
    reg q10;   // output Q10
    
    wire clrb;
    wire clk;
    wire d1;
    wire d2;
    wire d3;
    wire d4;
    wire d5;
    wire d6;
    wire d7;
    wire d8;
    wire d9;
    wire d10;
    
    reg clk_d;
    wire clk_enbl;

//============================ Start of Code =========================================

assign clrb = p23;
assign clk = p1;
assign d1 = p2;
assign d2 = p3;
assign d3 = p4;
assign d4 = p5;
assign d5 = p6;
assign d6 = p7;
assign d7 = p8;
assign d8 = p9;
assign d9 = p10;
assign d10 = p11;

assign p22 = q1;
assign p21 = q2;
assign p20 = q3;
assign p19 = q4;
assign p18 = q5;
assign p17 = q6;
assign p16 = q7;
assign p15 = q8;
assign p14 = q9;
assign p13 = q10;

assign clk_enbl = clk & ~clk_d;

always @ (posedge clock)
begin : REG8202 // block name

  if(reset==1'b1) begin
    q1 <= 1'b0;
    q2 <= 1'b0;
    q3 <= 1'b0;
    q4 <= 1'b0;
    q5 <= 1'b0;
    q6 <= 1'b0;
    q7 <= 1'b0;
    q8 <= 1'b0;
    q9 <= 1'b0;
    q10 <= 1'b0;
    clk_d <= clk;
  end
  else begin
    clk_d <= clk;
    q1  <= ~clrb ? 1'b0 : (clk_enbl ? d1 : q1);
    q2  <= ~clrb ? 1'b0 : (clk_enbl ? d2 : q2);
    q3  <= ~clrb ? 1'b0 : (clk_enbl ? d3 : q3);
    q4  <= ~clrb ? 1'b0 : (clk_enbl ? d4 : q4);
    q5  <= ~clrb ? 1'b0 : (clk_enbl ? d5 : q5);
    q6  <= ~clrb ? 1'b0 : (clk_enbl ? d6 : q6);
    q7  <= ~clrb ? 1'b0 : (clk_enbl ? d7 : q7);
    q8  <= ~clrb ? 1'b0 : (clk_enbl ? d8 : q8);
    q9  <= ~clrb ? 1'b0 : (clk_enbl ? d9 : q9);
    q10 <= ~clrb ? 1'b0 : (clk_enbl ? d10 : q10);
  end
end
endmodule // End of Module REG8202
