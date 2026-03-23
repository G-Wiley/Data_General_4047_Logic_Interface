//------------------------------------------------
// UNIT TEST for: SN7400.v
//------------------------------------------------
`include "SN7400.v"
module ut_SN7400();

// Declare inputs as regs and outputs as wires
  wire g1A;
  wire g1B;
  wire g2A;
  wire g2B;
  wire g3A;
  wire g3B;
  wire g4A;
  wire g4B;

  wire g1Y;
  wire g2Y;
  wire g3Y;
  wire g4Y;

// Initialize all variables
initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  #1 reset = 1; // Assert the reset
  #20 reset = 0; // De-assert the reset

  #5120 $finish;
end

reg clock;
reg reset;
reg [7:0] inputscount;
wire compare_1Y;
wire compare_2Y;
wire compare_3Y;
wire compare_4Y;
reg latched_error;

assign g1A = inputscount[0];
assign g1B = inputscount[1];
assign g2A = inputscount[2];
assign g2B = inputscount[3];
assign g3A = inputscount[4];
assign g3B = inputscount[5];
assign g4A = inputscount[6];
assign g4B = inputscount[7];

// Logic functions to test each of the four outputs of the UUT
assign compare_1Y = (g1Y == (~(g1A & g1B))) ? 0 : 1;
assign compare_2Y = (g2Y == (~(g2A & g2B))) ? 0 : 1;
assign compare_3Y = (g3Y == (~(g3A & g3B))) ? 0 : 1;
assign compare_4Y = (g4Y == (~(g4A & g4B))) ? 0 : 1;

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
    latched_error <= latched_error | (compare_1Y | compare_2Y | compare_3Y | compare_4Y);
  end

end

// Connecct DUT to test bench
SN7400 E1_SN7400 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .p1 (g1A),
    .p2 (g1B),
    .p4 (g2A),
    .p5 (g2B),
    .p9 (g3A),
    .p10 (g3B),
    .p12 (g4A),
    .p13 (g4B),
    
    //-------------------Output Ports-------------------------------------
    .p3 (g1Y),
    .p6 (g2Y),
    .p8 (g3Y),
    .p11 (g4Y)

);

endmodule
