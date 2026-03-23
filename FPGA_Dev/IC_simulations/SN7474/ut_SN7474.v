//------------------------------------------------
// UNIT TEST for: SN7474.v
//------------------------------------------------
`include "SN7474.v"
module ut_SN7474();

// Declare inputs as regs and outputs as wires
  reg clear1b;   // input 1 CLR
  reg data1;     // input 1 D
  reg clock1;    // input 1 CK
  reg preset1b;  // input 1 PR

  reg clear2b;   // input 2 CLR
  reg data2;     // input 2 D
  reg clock2;    // input 2 CK
  reg preset2b;  // input 2 PR

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
  clear1b = 1; 
  preset1b = 1; 
  clear2b = 1; 
  preset2b = 1;
  clock1 = 0;
  data1 = 0;
  clock2 = 0;
  data2 = 0;

  #1 reset = 1;   // Assert the reset
  #10 reset = 0;  // De-assert the reset
  
  // first, test FF 1
  #10
  preset1b = 0;   // Assert the preset
  data1 = 0;
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #120
  clear1b = 0;    // Assert the clear
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #10
  preset1b = 1;  // De-assert the preset
  #110
  clear1b = 1;   // De-assert the clear
  #10
  data1 = 1;
  #10
  clock1 = 1;    // rising edge on clock
  q1_ref = 1'b1;
  q1b_ref = 1'b0;
  #50
  clock1 = 0;
  data1 = 0;
  #50
  clock1 = 1;
  q1_ref = 1'b0;
  q1b_ref = 1'b1;
  #50
  data1 = 1;
  clock1 = 0;
  
  // now test FF 2
  #10
  preset2b = 0;   // Assert the preset
  data2 = 0;
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #120
  clear2b = 0;    // Assert the clear
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #10
  preset2b = 1;  // De-assert the preset
  #110
  clear2b = 1;   // De-assert the clear
  #10
  data2 = 1;
  #10
  clock2 = 1;    // rising edge on clock
  q2_ref = 1'b1;
  q2b_ref = 1'b0;
  #50
  clock2 = 0;
  data2 = 0;
  #50
  clock2 = 1;
  q2_ref = 1'b0;
  q2b_ref = 1'b1;
  #50
  data2 = 1;
  clock2 = 0;

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
SN7474 E1_SN7474 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .clock (clock),  // system clock
    .reset (reset),  // active high synchronous reset input
    .p1 (clear1b),   // input 1 CLR
    .p2 (data1),     // input 1 D
    .p3 (clock1),    // input 1 CK
    .p4 (preset1b),  // input 1 PR
    .p13 (clear2b),  // input 2 CLR
    .p12 (data2),    // input 2 D
    .p11 (clock2),   // input 2 CK
    .p10 (preset2b), // input 2 PR

    //-------------------Output Ports-------------------------------------
    .p5 (q1_out),    // output 1Q
    .p6 (q1b_out),   // output 1QB
    .p9 (q2_out),    // output 2Q
    .p8 (q2b_out)    // output 2QB

);

endmodule
