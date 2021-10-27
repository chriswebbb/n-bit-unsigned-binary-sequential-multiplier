module sequencer (input logic start, clock, Q0, n_rst,
 output logic add, shift, ready, reset);

enum{idle, adding, shifting, stopped} present_state, next_state; //A = idle, B = adding, C = shifting, D = stopped

enum{zero, one, two, three, four} cntP_state, cntN_state;

logic count;

always_ff @ (posedge clock, negedge n_rst)
	begin: SEQ
	if(!n_rst)
		present_state <= idle;
	else
		present_state <= next_state;
	end

always_ff @ (posedge clock, negedge n_rst)
	begin: CNT
	if(!n_rst)
		cntP_state <= four;
	else
		cntP_state <= cntN_state;
	end

always_comb
	begin: CNTCOM
	count = 1;
	cntN_state = cntP_state;
	unique case(cntP_state)
	zero:	begin
		count = 0;
		cntN_state = four;
		end
	one:	begin
		if(present_state == adding)
			cntN_state = zero;
		end
	two:	begin
		if(present_state == adding)
			cntN_state = one;
		end
	three:	begin
		if(present_state == adding)
			cntN_state = two;
		end
	four:	begin
		if(present_state == adding)
			cntN_state = three;
		end
	endcase
	end

always_comb
	begin: COM
	add = '0;
	shift = '0;
	ready = '0;
	reset = '0;
	next_state = present_state;
	unique case (present_state)
		idle:   begin
			reset = '1;
			if(start)
				next_state = adding;
			else 
				next_state = idle;
			end
		adding: begin
			//$display("Count value = ", count);
			next_state = shifting;		

			if(Q0)
				add = '1;
			end
		shifting:begin
			shift = '1;
			if(count>0)
				next_state = adding;
			else
				next_state = stopped;
			end
		stopped:begin
			ready = '1;
			if(start)
				next_state = idle;
			else
				next_state = stopped;
			end
	endcase
	end
endmodule              
             
