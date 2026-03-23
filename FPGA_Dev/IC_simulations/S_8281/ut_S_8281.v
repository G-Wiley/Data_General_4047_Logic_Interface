//------------------------------------------------
// UNIT TEST for: S_8281.v
//------------------------------------------------
`include "S_8281.v"
module ut_S_8281();

// Declare inputs as regs and outputs as wires
  wire clk1;          // input CLK1
  wire clk2;          // input CLK2
  wire resetb;        // input RESET bar
  wire data_strobe_b; // input DATA STROBE bar
  wire da;            // input DA
  wire db;            // input DB
  wire dc;            // input DC
  wire dd;            // input DD

  wire ao;            // output AO
  wire bo;            // output BO
  wire co;            // output CO
  wire do;            // output DO

  reg ao_ref;
  reg bo_ref;
  reg co_ref;
  reg do_ref;

  reg marker; // marker pulse for debugging, to mark locations in the timing diagram

// variables for simulation
reg clock;
reg reset;
wire compare_ao;
wire compare_bo;
wire compare_co;
wire compare_do;
reg latched_error;
reg [9:0] inputscount;

reg clk1_d;
wire clk1_enbl;
reg clk2_d;
wire clk2_enbl;

// Logic functions to test each of the four outputs of the UUT

assign clk1_enbl = ~clk1 & clk1_d;
assign clk2_enbl = ~clk2 & clk2_d;

assign clk1 = inputscount[2];
assign clk2 = inputscount[3];
assign da = inputscount[4];
assign db = inputscount[5];
assign dc = inputscount[6];
assign dd = inputscount[7];
assign data_strobe_b = ~(inputscount[8] & clk1);
assign resetb = ~(inputscount[9] * clk1);

assign compare_ao =  (ao   == ao_ref) ? 0 : 1;
assign compare_bo =  (bo   == bo_ref) ? 0 : 1;
assign compare_co =  (co   == co_ref) ? 0 : 1;
assign compare_do =  (do   == do_ref) ? 0 : 1;

// Initialize all variables
initial begin
  clock = 1; // initial value of clock
  reset = 0; // initial value of reset
  marker = 0;
  #1 reset = 1; // Assert the reset
  #10 reset = 0; // De-assert the reset

  #10240 $finish;
end

// Clock generator
always begin
  #5.0 clock = ~clock; // Toggle clock every 5.0 ticks
end

always @ (posedge clock)
begin : TESTCONDTIONS // block name
  if(reset == 1'b1) begin
    clk1_d <= 1'b0;
    clk2_d <= 1'b0;
    ao_ref <= 1'b0;
    bo_ref <= 1'b0;
    co_ref <= 1'b0;
    do_ref <= 1'b0;
    latched_error <= 1'b0;
    
    inputscount <= 10'd0;
  end
  else begin
    clk1_d <= clk1;
    clk2_d <= clk2;
    ao_ref <= ~resetb ? 1'b0 : (~data_strobe_b ? da : (clk1_enbl ? ~ao : ao));
    bo_ref <= ~resetb ? 1'b0 : (~data_strobe_b ? db : (clk2_enbl ? ~bo : bo));
    co_ref <= ~resetb ? 1'b0 : (~data_strobe_b ? dc : (clk2_enbl & bo ? ~co : co));
    do_ref <= ~resetb ? 1'b0 : (~data_strobe_b ? dd : (clk2_enbl & co & bo ? ~do : do));

    inputscount <= inputscount + 1;
    latched_error <= latched_error | (compare_ao | compare_bo | compare_co | compare_do);
  end

end

// Connecct DUT to test bench
S_8281 E1_S_8281 (
    //-------------------Input Ports-------------------------------------
    .clock (clock),      // system clock
    .reset (reset),      // active high synchronous reset input
    .p8 (clk1),          // input CLOCK1
    .p6 (clk2),          // input CLOCK2
    .p13 (resetb),       // input RESET bar
    .p1 (data_strobe_b), // input RESET bar
    //.p4(1'b0),         // pin 5 stuck at zero to verify ability to detect errors
    .p4 (da),            // input DA
    .p10 (db),           // input DB
    .p3 (dc),            // input DC
    .p11 (dd),           // input DD

    //-------------------Output Ports-------------------------------------
    .p5 (ao),           // output AO
    .p9 (bo),          // output BO
    .p2 (co),           // output CO
    .p12 (do)          // output DO
);

endmodule
