//------------------------------------------------
// UNIT TEST for: SN7410.v
//------------------------------------------------
`include "SN7410.v"
module ut_SN7410();

// Declare inputs as regs and outputs as wires
  wire g1A;
  wire g1B;
  wire g1C;
  wire g2A;
  wire g2B;
  wire g2C;
  wire g3A;
  wire g3B;
  wire g3C;

  wire g1Y;
  wire g2Y;
  wire g3Y;

// Initialize all variables
initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  #1 reset = 1; // Assert the reset
  #20 reset = 0; // De-assert the reset

  #10300 $finish;
end

reg clock;
reg reset;
reg [8:0] inputscount;
wire compare_1Y;
wire compare_2Y;
wire compare_3Y;
reg latched_error;

assign g1A = inputscount[0];
assign g1B = inputscount[1];
assign g1C = inputscount[2];
assign g2A = inputscount[3];
assign g2B = inputscount[4];
assign g2C = inputscount[5];
assign g3A = inputscount[6];
assign g3B = inputscount[7];
assign g3C = inputscount[8];

// Logic functions to test each of the four outputs of the UUT
assign compare_1Y = (g1Y == (~(g1A & g1B & g1C))) ? 0 : 1;
assign compare_2Y = (g2Y == (~(g2A & g2B & g2C))) ? 0 : 1;
assign compare_3Y = (g3Y == (~(g3A & g3B & g3C))) ? 0 : 1;

// Clock generator
always begin
  #10.0 clock = ~clock; // Toggle clock every 10.0 ticks
end

always @ (posedge clock)
begin : TESTCONDTIONS // block name
  if(reset == 1'b1) begin
    inputscount = 9'd0;
    latched_error = 1'b0;
  end
  else begin
    inputscount <= inputscount + 1;
    latched_error <= latched_error | (compare_1Y | compare_2Y | compare_3Y);
  end

end

// Connecct DUT to test bench
SN7410 E1_SN7410 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .p1 (g1A),
    .p2 (g1B),
    .p13 (g1C),
    .p3 (g2A),
    .p4 (g2B),
    .p5 (g2C),
    .p9 (g3A),
    .p10 (g3B),
    .p11 (g3C),
    
    //-------------------Output Ports-------------------------------------
    .p12 (g1Y),
    .p6 (g2Y),
    .p8 (g3Y)

);

endmodule
