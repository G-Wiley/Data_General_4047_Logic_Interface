//------------------------------------------------
// UNIT TEST for: F_9321.v
//------------------------------------------------
`include "F_9321.v"
module ut_F_9321();

// Declare inputs as regs and outputs as wires
  wire p1E_N;
  wire p1A0;
  wire p1A1;
  wire p2E_N;
  wire p2A0;
  wire p2A1;

  wire p1Y0_N;
  wire p1Y1_N;
  wire p1Y2_N;
  wire p1Y3_N;
  wire p2Y0_N;
  wire p2Y1_N;
  wire p2Y2_N;
  wire p2Y3_N;

// Initialize all variables
initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  #1 reset = 1; // Assert the reset
  #20 reset = 0; // De-assert the reset

  #1280 $finish;
end

reg clock;
reg reset;
reg [5:0] inputscount;
wire compare_1Y0;
wire compare_1Y1;
wire compare_1Y2;
wire compare_1Y3;
wire compare_2Y0;
wire compare_2Y1;
wire compare_2Y2;
wire compare_2Y3;
reg latched_error;

assign p1E_N = inputscount[0];
assign p1A0 = inputscount[1];
assign p1A1 = inputscount[2];
assign p2E_N = inputscount[3];
assign p2A0 = inputscount[4];
assign p2A1 = inputscount[5];

// Logic functions to test each of the eight outputs of the UUT
assign compare_1Y0 = (p1Y0_N == (~(~p1E_N & ~p1A1 & ~p1A0))) ? 0 : 1;
assign compare_1Y1 = (p1Y1_N == (~(~p1E_N & ~p1A1 &  p1A0))) ? 0 : 1;
assign compare_1Y2 = (p1Y2_N == (~(~p1E_N &  p1A1 & ~p1A0))) ? 0 : 1;
assign compare_1Y3 = (p1Y3_N == (~(~p1E_N &  p1A1 &  p1A0))) ? 0 : 1;
assign compare_2Y0 = (p2Y0_N == (~(~p2E_N & ~p2A1 & ~p2A0))) ? 0 : 1;
assign compare_2Y1 = (p2Y1_N == (~(~p2E_N & ~p2A1 &  p2A0))) ? 0 : 1;
assign compare_2Y2 = (p2Y2_N == (~(~p2E_N &  p2A1 & ~p2A0))) ? 0 : 1;
assign compare_2Y3 = (p2Y3_N == (~(~p2E_N &  p2A1 &  p2A0))) ? 0 : 1;

// Clock generator
always begin
  #10.0 clock = ~clock; // Toggle clock every 10.0 ticks
end

always @ (posedge clock)
begin : TESTCONDTIONS // block name
  if(reset == 1'b1) begin
    inputscount = 6'd0;
    latched_error = 1'b0;
  end
  else begin
    inputscount <= inputscount + 1;
    latched_error <= latched_error | (compare_1Y0 | compare_1Y1 | compare_1Y2 | compare_1Y3 | compare_2Y0 | compare_2Y1 | compare_2Y2 | compare_2Y3);
  end

end

// Connecct DUT to test bench
F_9321 E1_F_9321 (
    //-------------------Input Ports-------------------------------------
    //.p1(1'b0),  // pin 1 stuck at zero to verify ability to detect errors
    .p1 (p1E_N),
    .p2 (p1A0),
    .p3 (p1A1),
    .p13 (p2A1),
    .p14 (p2A0),
    .p15 (p2E_N),
    
    //-------------------Output Ports-------------------------------------
    .p4 (p1Y0_N),
    .p5 (p1Y1_N),
    .p6 (p1Y2_N),
    .p7 (p1Y3_N),
    .p9  (p2Y3_N),
    .p10 (p2Y2_N),
    .p11 (p2Y1_N),
    .p12 (p2Y0_N)

);

endmodule
