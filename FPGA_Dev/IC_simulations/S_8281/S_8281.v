//==========================================================================================================
// TTL IC functions
// 8281 4-bit Binary Conter
// File Name: S_8281.v
// Functions: 
//   The 4-bit binary counter with asynchronous parallel load of a Signetics 8202.
//
//==========================================================================================================

module S_8281(
    input wire clock,               // master clock 40 MHz
    input wire reset,               // active high synchronous reset input
    input wire p8,   // input CLK1
    input wire p6,   // input CLK2
    input wire p1,   // input DATA STROBE bar
    input wire p13,  // input RESET bar
    input wire p4,   // input DA
    input wire p10,  // input DB
    input wire p3,   // input DC
    input wire p11,  // input DD

    output wire p5,  // output AO
    output wire p9,  // output BO
    output wire p2,  // output CO
    output wire p12  // output DO
);

//============================ Internal Connections ==================================

    reg ao;   // output ao
    reg bo;   // output bo
    reg co;   // output co
    reg do;   // output do
    
    wire clk1;
    wire clk2;
    wire resetb;
    wire data_strobe_b;
    wire da;
    wire db;
    wire dc;
    wire dd;
    
    reg clk1_d;
    wire clk1_enbl;
    reg clk2_d;
    wire clk2_enbl;

//============================ Start of Code =========================================

assign clk1 = p8;
assign clk2 = p6;
assign data_strobe_b = p1;
assign resetb = p13;
assign da = p4;
assign db = p10;
assign dc = p3;
assign dd = p11;

assign p5  = ao;
assign p9  = bo;
assign p2  = co;
assign p12 = do;

assign clk1_enbl = ~clk1 & clk1_d;
assign clk2_enbl = ~clk2 & clk2_d;

always @ (posedge clock)
begin : CTR8281 // block name

  if(reset==1'b1) begin
    ao <= 1'b0;
    bo <= 1'b0;
    co <= 1'b0;
    do <= 1'b0;
    clk1_d <= 1'b0;
    clk2_d <= 1'b0;
  end
  else begin
    clk1_d <= clk1;
    clk2_d <= clk2;
    ao  <= ~resetb ? 1'b0 : (~data_strobe_b ? da : (clk1_enbl ? ~ao : ao));
    // The actual part uses an async ripple carry for bits b, c, and d. However, we will implement a synchronous carry in Verilog.
    bo  <= ~resetb ? 1'b0 : (~data_strobe_b ? db : (clk2_enbl ? ~bo : bo));
    co  <= ~resetb ? 1'b0 : (~data_strobe_b ? dc : (clk2_enbl & bo ? ~co : co));
    do  <= ~resetb ? 1'b0 : (~data_strobe_b ? dd : (clk2_enbl & co & bo ? ~do : do));
  end
end
endmodule // End of Module CTR8281
