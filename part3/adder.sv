module adder #(parameter N=8) (input logic[N-1:0] A,M, output logic C, output logic [N-1:0] Sum);
 // N+1-bit arithmetic addition allows to extract carry
 always_comb
   {C,Sum} = {1'b0,A} + {1'b0,M};

endmodule
