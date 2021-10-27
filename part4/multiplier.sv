module multiplier(input logic start, n_rst, clock, input logic [3:0] Min, Qin, 
                  output logic ready, output logic[7:0] AQ);

logic C, reset, shift, add;
logic [3:0] Sum, M;


adder A0(.A(AQ[7:4]), .M(M), .C(C), .Sum(Sum));
register R0 (.*);
reg_m R1 (.*);
sequencer S(.start(start), .clock(clock), .reset(reset), .Q0(AQ[0]), .n_rst(n_rst),
 .add(add), .shift(shift), .ready(ready));
  
endmodule
