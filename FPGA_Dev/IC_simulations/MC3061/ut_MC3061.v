//------------------------------------------------
// UNIT TEST for: MC3061.v
//------------------------------------------------
`include "MC3061.v"
module ut_MC3061();

// Declare inputs as regs and outputs as wires
  reg resetb;    // input common clear/reset, active-low
  reg clockb;    // input common clock, falling edge

  reg k1;        // input 1 K
  reg j1;        // input 1 J
  reg set1b;     // input 1 SET

  reg k2;        // input 2 K
  reg j2;        // input 2 J
  reg set2b;     // input 2 SET

  wire q1_out;
  wire q1b_out;
  wire q2_out;
  wire q2b_out;

  reg q1_ref;
  reg q1b_ref;
  reg q2_ref;
  reg q2b_ref;

  reg q1_ref_delayed;
  reg q1b_ref_delayed;
  reg q2_ref_delayed;
  reg q2b_ref_delayed;
  
  reg marker; // marker pulse for debugging, to mark locations in the timing diagram

// variables for simulation
reg clock;
reg reset;
reg [3:0] ffclk_count;
wire compare_1q;
wire compare_1qb;
wire compare_2q;
wire compare_2qb;
reg latched_error;

// Logic functions to test each of the four outputs of the UUT
assign compare_1q =  (q1_out  == q1_ref_delayed) ? 0 : 1;
assign compare_1qb = (q1b_out == q1b_ref_delayed) ? 0 : 1;
assign compare_2q =  (q2_out  == q2_ref_delayed) ? 0 : 1;
assign compare_2qb = (q2b_out == q2b_ref_delayed) ? 0 : 1;

// Initialize all variables

initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  marker = 0;
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  resetb = 1; 
  clockb = 1;
  set1b = 1; 
  set2b = 1;
  j1 = 0;
  k1 = 0;
  j2 = 0;
  k2 = 0;

  #1 reset = 1;   // Assert the reset
  #10 reset = 0;  // De-assert the reset
  
  // first, test FF 1
  marker = 1;
  #10
  marker = 0;
  #10
  set1b = 0;   // Assert the preset
  j1 = 0;
  k1 = 0;
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #120
  resetb = 0;    // Assert the clear
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #10
  set1b = 1;  // De-assert the preset
  #110
  resetb = 1;   // De-assert the clear
  marker = 1;
  #10
  marker = 0;
  #10
  j1 = 1;
  k1 = 0;
  #10
  clockb = 0;    // falling edge on clock, jk=10, q=0
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #50
  clockb = 1;
  j1 = 1;
  k1 = 0;
  #50
  clockb = 0;    // falling edge on clock, jk=10, q=1
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #50
  clockb = 1;
  j1 = 0;
  k1 = 0;
  #50
  clockb = 0;    // falling edge on clock, jk=00, q=1
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #50
  clockb = 1;
  j1 = 0;
  k1 = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=01, q=1
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #50
  clockb = 1;
  j1 = 0;
  k1 = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=01, q=0
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #50
  clockb = 1;
  j1 = 0;
  k1 = 0;
  #50
  clockb = 0;    // falling edge on clock, jk=00, q=0
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #50
  j1 = 1;
  k1 = 1;
  clockb = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=11, q=0
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #50
  clockb = 1;
  j1 = 1;
  k1 = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=11, q=1
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #50
  j1 = 1;
  k1 = 1;
  clockb = 1;
  
  // now test FF 2
  marker = 1;
  #10
  marker = 0;
  j1 = 0;      // j1 and k1 to zero so FF 1 doesn't toggle while testing FF 2
  k1 = 0;
  #10
  set2b = 0;   // Assert the preset
  j2 = 0;
  k2 = 0;
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #120
  resetb = 0;    // Assert the clear
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #10
  set2b = 1;  // De-assert the preset
  #110
  resetb = 1;   // De-assert the clear
  #10
  j2 = 1;
  k2 = 0;
  #10
  clockb = 0;    // falling edge on clock, jk=10, q=0
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #50
  clockb = 1;
  j2 = 1;
  k2 = 0;
  #50
  clockb = 0;    // falling edge on clock, jk=10, q=1
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #50
  clockb = 1;
  j2 = 0;
  k2 = 0;
  #50
  clockb = 0;    // falling edge on clock, jk=00, q=1
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #50
  clockb = 1;
  j2 = 0;
  k2 = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=01, q=1
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #50
  clockb = 1;
  j2 = 0;
  k2 = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=01, q=0
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #50
  clockb = 1;
  j2 = 0;
  k2 = 0;
  #50
  clockb = 0;    // falling edge on clock, jk=00, q=0
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #50
  j2 = 1;
  k2 = 1;
  clockb = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=11, q=0
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #50
  clockb = 1;
  j2 = 1;
  k2 = 1;
  #50
  clockb = 0;    // falling edge on clock, jk=11, q=1
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #50
  j2 = 1;
  k2 = 1;
  clockb = 1;

  #500 $finish;
end

// Clock generator
always begin
  #5.0 clock = ~clock; // Toggle clock every 5.0 ticks
end

always @ (posedge clock)
begin : TESTCONDTIONS // block name
  if(reset == 1'b1) begin
    ffclk_count <= 4'd3;
    latched_error <= 1'b0;
    
    q1_ref_delayed <= 1'b0;
    q1b_ref_delayed <= 1'b1;
    q2_ref_delayed <= 1'b0;
    q2b_ref_delayed <= 1'b1;
  end
  else begin
    ffclk_count <= (ffclk_count == 4'd12) ? 4'd3 : ffclk_count + 1;
    latched_error <= latched_error | (compare_1q | compare_1qb | compare_2q | compare_2qb);
    
    q1_ref_delayed <= q1_ref;
    q1b_ref_delayed <= q1b_ref;
    q2_ref_delayed <= q2_ref;
    q2b_ref_delayed <= q2b_ref;
  end

end

// Connecct DUT to test bench
MC3061 E1_MC3061 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    // to test the error check capability, uncomment the ".p1(1'b0)" port definition above and comment out ".p1 (resetb)" below
    .clock (clock),  // system clock
    .reset (reset),  // active high synchronous reset input
    .p1 (resetb),    // input common clear/reset, active-low
    .p13 (clockb),   // input common clock, falling edge
    .p2 (k1),        // input 1 K
    .p3 (j1),        // input 1 J
    .p4 (set1b),     // input 1 SET
    .p12 (k2),       // input 2 K
    .p11 (j2),       // input 2 J
    .p10 (set2b),    // input 2 SET

    //-------------------Output Ports-------------------------------------
    .p5 (q1_out),    // output 1Q
    .p6 (q1b_out),   // output 1QB
    .p9 (q2_out),    // output 2Q
    .p8 (q2b_out)    // output 2QB

);

endmodule
