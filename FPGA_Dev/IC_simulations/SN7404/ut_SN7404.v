//------------------------------------------------
// UNIT TEST for: SN7404.v
//------------------------------------------------
`include "SN7404.v"
module ut_SN7404();

// Declare inputs as regs and outputs as wires
  wire in1A;
  wire in2A;
  wire in3A;
  wire in4A;
  wire in5A;
  wire in6A;

  wire out1Y;
  wire out2Y;
  wire out3Y;
  wire out4Y;
  wire out5Y;
  wire out6Y;

// Initialize all variables
initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  #1 reset = 1; // Assert the reset
  #20 reset = 0; // De-assert the reset

  #1320 $finish;
end

reg clock;
reg reset;
reg [5:0] inputscount;
wire compare_1Y;
wire compare_2Y;
wire compare_3Y;
wire compare_4Y;
wire compare_5Y;
wire compare_6Y;
reg latched_error;

assign in1A = inputscount[0];
assign in2A = inputscount[1];
assign in3A = inputscount[2];
assign in4A = inputscount[3];
assign in5A = inputscount[4];
assign in6A = inputscount[5];

// Logic functions to test each of the four outputs of the UUT
assign compare_1Y = (out1Y == (~in1A)) ? 0 : 1;
assign compare_2Y = (out2Y == (~in2A)) ? 0 : 1;
assign compare_3Y = (out3Y == (~in3A)) ? 0 : 1;
assign compare_4Y = (out4Y == (~in4A)) ? 0 : 1;
assign compare_5Y = (out5Y == (~in5A)) ? 0 : 1;
assign compare_6Y = (out6Y == (~in6A)) ? 0 : 1;

// Clock generator
always begin
  #10.0 clock = ~clock; // Toggle clock every 10.0 ticks
end

always @ (posedge clock)
begin : TESTCONDTIONS // block name
  if(reset == 1'b1) begin
    inputscount = 8'd0;
    latched_error = 1'b0;
  end
  else begin
    inputscount <= inputscount + 1;
    latched_error <= latched_error | (compare_1Y | compare_2Y | compare_3Y | compare_4Y | compare_5Y | compare_6Y);
  end

end

// Connecct DUT to test bench
SN7404 E1_SN7404 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .p1  (in1A),
    .p3  (in2A),
    .p5  (in3A),
    .p9  (in4A),
    .p11 (in5A),
    .p13 (in6A),
    
    //-------------------Output Ports-------------------------------------
    .p2  (out1Y),
    .p4  (out2Y),
    .p6  (out3Y),
    .p8  (out4Y),
    .p10 (out5Y),
    .p12 (out6Y)

);

endmodule
