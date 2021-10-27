module register (input logic clock, reset, add, shift, C,
              input logic[7:0] Qin, Sum, output logic[15:0] AQ);

logic Creg; // MSB carry bit storage

always_ff @ (posedge clock)
  if (reset)  // clear C,A and load Q, M
  begin
   Creg <= 0;
   AQ[15:8] <= 0;
   AQ[7:0] <= Qin; // load multiplier into Q
  end
  else if (add) // store Sum in C,A
  begin
   Creg <= C;
   {Creg,AQ} <= {1'b0,C,Sum,AQ[7:1]};
  end
  else if (shift) // shift A, Q
  begin
   {Creg,AQ} <= {1'b0,Creg,AQ[15:1]};
  end
endmodule
