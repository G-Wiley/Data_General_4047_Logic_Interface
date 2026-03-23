//------------------------------------------------
// UNIT TEST for: F_9015.v
//------------------------------------------------
`include "F_9015.v"
module ut_F_9015();

// Declare inputs as regs and outputs as wires
  wire g1A;
  wire g1B;
  wire g2A;
  wire g2B;
  wire g3A;
  wire g3B;
  wire g4A;
  wire g4B;
  wire g4C;
  wire g4D;

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

  #20480 $finish;
end

reg clock;
reg reset;
reg [9:0] inputscount;
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
assign g4C = inputscount[8];
assign g4D = inputscount[9];

// Logic functions to test each of the four outputs of the UUT
assign compare_1Y = (g1Y == (~(g1A | g1B))) ? 0 : 1;
assign compare_2Y = (g2Y == (~(g2A | g2B))) ? 0 : 1;
assign compare_3Y = (g3Y == (~(g3A | g3B))) ? 0 : 1;
assign compare_4Y = (g4Y == (~(g4A | g4B | g4C | g4D))) ? 0 : 1;

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
F_9015 E1_F_9015 (
    //-------------------Input Ports-------------------------------------
    //.p2(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .p2 (g1A),
    .p3 (g1B),
    .p5 (g2A),
    .p6 (g2B),
    .p10 (g3A),
    .p11 (g3B),
    .p13 (g4A),
    .p14 (g4B),
    .p15 (g4C),
    .p1 (g4D),
    
    //-------------------Output Ports-------------------------------------
    .p4 (g1Y),
    .p7 (g2Y),
    .p9 (g3Y),
    .p12 (g4Y)

);

endmodule
