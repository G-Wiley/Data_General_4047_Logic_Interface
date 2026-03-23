//------------------------------------------------
// UNIT TEST for: SN7440.v
//------------------------------------------------
`include "SN7440.v"
module ut_SN7440();

// Declare inputs as regs and outputs as wires
  wire g1A;
  wire g1B;
  wire g1C;
  wire g1D;
  wire g2A;
  wire g2B;
  wire g2C;
  wire g2D;

  wire g1Y;
  wire g2Y;

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
reg latched_error;

assign g1A = inputscount[0];
assign g1B = inputscount[1];
assign g1C = inputscount[2];
assign g1D = inputscount[3];
assign g2A = inputscount[4];
assign g2B = inputscount[5];
assign g2C = inputscount[6];
assign g2D = inputscount[7];

// Logic functions to test each of the four outputs of the UUT
assign compare_1Y = (g1Y == (~(g1A & g1B & g1C & g1D))) ? 0 : 1;
assign compare_2Y = (g2Y == (~(g2A & g2B & g2C & g2D))) ? 0 : 1;

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
    latched_error <= latched_error | (compare_1Y | compare_2Y);
  end

end

// Connecct DUT to test bench
SN7440 E1_SN7440 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .p1 (g1A),
    .p2 (g1B),
    .p4 (g1C),
    .p5 (g1D),
    .p9 (g2A),
    .p10 (g2B),
    .p12 (g2C),
    .p13 (g2D),
    
    //-------------------Output Ports-------------------------------------
    .p6 (g1Y),
    .p8 (g2Y)

);

endmodule
