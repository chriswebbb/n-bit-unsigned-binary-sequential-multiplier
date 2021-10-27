module reg_m #(parameter N=8) (input logic clock, reset, 
              input logic[N-1:0] Min, output logic[N-1:0] M);

always_ff @ (posedge clock)
  if (reset)  // clear C,A and load Q, M
    M <= Min;

endmodule
