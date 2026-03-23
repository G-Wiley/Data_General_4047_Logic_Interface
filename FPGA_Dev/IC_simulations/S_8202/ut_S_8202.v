//------------------------------------------------
// UNIT TEST for: S_8202.v
//------------------------------------------------
`include "S_8202.v"
module ut_S_8202();

// Declare inputs as regs and outputs as wires
  wire clk;     // input CK
  wire resetb;  // input reset bar
  wire d1;      // input D1
  wire d2;      // input D2
  wire d3;      // input D3
  wire d4;      // input D4
  wire d5;      // input D5
  wire d6;      // input D6
  wire d7;      // input D7
  wire d8;      // input D8
  wire d9;      // input D9
  wire d10;     // input D10

  wire q1;     // output Q1
  wire q2;     // output Q2
  wire q3;     // output Q3
  wire q4;     // output Q4
  wire q5;     // output Q5
  wire q6;     // output Q6
  wire q7;     // output Q7
  wire q8;     // output Q8
  wire q9;     // output Q9
  wire q10;    // output Q10

  reg q1_ref;
  reg q2_ref;
  reg q3_ref;
  reg q4_ref;
  reg q5_ref;
  reg q6_ref;
  reg q7_ref;
  reg q8_ref;
  reg q9_ref;
  reg q10_ref;

  reg marker; // marker pulse for debugging, to mark locations in the timing diagram

// variables for simulation
reg clock;
reg reset;
wire compare_q1;
wire compare_q2;
wire compare_q3;
wire compare_q4;
wire compare_q5;
wire compare_q6;
wire compare_q7;
wire compare_q8;
wire compare_q9;
wire compare_q10;
reg latched_error;
reg [13:0] inputscount;

reg clk_d;
wire clk_enbl;

// Logic functions to test each of the ten outputs of the UUT

assign clk_enbl = clk & ~clk_d;

assign clk = inputscount[2];
assign resetb = inputscount[3];
assign d1 = inputscount[4];
assign d2 = inputscount[5];
assign d3 = inputscount[6];
assign d4 = inputscount[7];
assign d5 = inputscount[8];
assign d6 = inputscount[9];
assign d7 = inputscount[10];
assign d8 = inputscount[11];
assign d9 = inputscount[12];
assign d10 = inputscount[13];

assign compare_q1 =  (q1   == q1_ref) ? 0 : 1;
assign compare_q2 =  (q2   == q2_ref) ? 0 : 1;
assign compare_q3 =  (q3   == q3_ref) ? 0 : 1;
assign compare_q4 =  (q4   == q4_ref) ? 0 : 1;
assign compare_q5 =  (q5   == q5_ref) ? 0 : 1;
assign compare_q6 =  (q6   == q6_ref) ? 0 : 1;
assign compare_q7 =  (q7   == q7_ref) ? 0 : 1;
assign compare_q8 =  (q8   == q8_ref) ? 0 : 1;
assign compare_q9 =  (q9   == q9_ref) ? 0 : 1;
assign compare_q10 = (q10  == q10_ref) ? 0 : 1;

// Initialize all variables
initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  marker = 0;
  #1 reset = 1; // Assert the reset
  #10 reset = 0; // De-assert the reset

  #163840 $finish;
end

// Clock generator
always begin
  #5.0 clock = ~clock; // Toggle clock every 5.0 ticks
end

always @ (posedge clock)
begin : TESTCONDTIONS // block name
  if(reset == 1'b1) begin
    clk_d <= clk;
    q1_ref <= 1'b0;
    q2_ref <= 1'b0;
    q3_ref <= 1'b0;
    q4_ref <= 1'b0;
    q5_ref <= 1'b0;
    q6_ref <= 1'b0;
    q7_ref <= 1'b0;
    q8_ref <= 1'b0;
    q9_ref <= 1'b0;
    q10_ref <= 1'b0;
    latched_error <= 1'b0;
    
    inputscount <= 14'd0;
  end
  else begin
    clk_d <= clk;
    q1_ref <= ~resetb ? 1'b0 : (clk_enbl ? d1 : q1);
    q2_ref <= ~resetb ? 1'b0 : (clk_enbl ? d2 : q2);
    q3_ref <= ~resetb ? 1'b0 : (clk_enbl ? d3 : q3);
    q4_ref <= ~resetb ? 1'b0 : (clk_enbl ? d4 : q4);
    q5_ref <= ~resetb ? 1'b0 : (clk_enbl ? d5 : q5);
    q6_ref <= ~resetb ? 1'b0 : (clk_enbl ? d6 : q6);
    q7_ref <= ~resetb ? 1'b0 : (clk_enbl ? d7 : q7);
    q8_ref <= ~resetb ? 1'b0 : (clk_enbl ? d8 : q8);
    q9_ref <= ~resetb ? 1'b0 : (clk_enbl ? d9 : q9);
    q10_ref <= ~resetb ? 1'b0 : (clk_enbl ? d10 : q10);

    inputscount <= inputscount + 1;
    latched_error <= latched_error | (compare_q1 | compare_q2 | compare_q3 | compare_q4 | compare_q5 |
                                      compare_q6 | compare_q7 | compare_q8 | compare_q9 | compare_q10);
  end

end

// Connecct DUT to test bench
S_8202 E1_S_8202 (
    //-------------------Input Ports-------------------------------------
    .clock (clock),  // system clock
    .reset (reset),  // active high synchronous reset input
    .p1 (clk),       // input CLOCK
    //.p2(1'b0),     // pin 2 stuck at zero to verify ability to detect errors
    .p2 (d1),        // input D1
    .p3 (d2),        // input D2
    .p4 (d3),        // input D3
    .p5 (d4),        // input D4
    .p6 (d5),        // input D5
    .p7 (d6),        // input D6
    .p8 (d7),        // input D7
    .p9 (d8),        // input D8
    .p10 (d9),       // input D9
    .p11 (d10),      // input D10
    .p23 (resetb),   // input RESET bar

    //-------------------Output Ports-------------------------------------
    .p13 (q10),      // output Q10
    .p14 (q9),       // output Q9
    .p15 (q8),       // output Q8
    .p16 (q7),       // output Q7
    .p17 (q6),       // output Q6
    .p18 (q5),       // output Q5
    .p19 (q4),       // output Q4
    .p20 (q3),       // output Q3
    .p21 (q2),       // output Q2
    .p22 (q1)        // output Q1
);

endmodule
