/////////////////////////////////////////////////////////////////////
// Design unit: adder
//            :
// File name  : adder.sv
//            :
// Description: Code for M4 Lab exercise
//            : adder
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Tom Kazmierski & Mark Zwolinski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//
// Revision   : Version 1.0 17/10/13 tjk
//            : modified for DE1-SoC: mz, 16/10/17
/////////////////////////////////////////////////////////////////////

module adder #(parameter N=4) (input logic[N-1:0] A,M, output logic C, output logic [N-1:0] Sum);
 // N+1-bit arithmetic addition allows to extract carry
 always_comb
   {C,Sum} = {1'b0,A} + {1'b0,M};

endmodule