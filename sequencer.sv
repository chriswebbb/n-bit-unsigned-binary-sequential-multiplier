module sequencer (input logic start, clock, Q0, n_rst,
 output logic add, shift, ready, reset);
 
enum {idle,adding,shifting,stopped} present_state, next_state;
	logic [3:0]count = 4;
always_ff @(posedge clock, negedge n_rst)
	begin: SEQ
	if (~n_rst)
		begin
			count <= 4;
			present_state <= idle;
		end
	else
		begin
		if (present_state == adding)
			count <= count - 1;
		if (present_state == idle)
			count <= 4;
		present_state <= next_state;
		end
	end
	
always_comb
	begin: COM
	reset = '0;
	add = '0; 
	shift= '0;
	ready = '0;
	next_state = present_state;
	unique case (present_state)
		idle: begin
				ready = '0;
				reset = '1;
				if (start)
					next_state = adding;
		end


		adding: begin
			reset = '0;
			shift = '0;
			if (count == 0)
				next_state = stopped;
			else
				next_state = adding;
			if (Q0)
				add = '1;
			else
				begin
					add = '0;
					shift = '1;
				end
			
		end
			
		shifting: begin
			add = '0;
			shift = '1;
			if (count == 0)
				next_state = stopped;
			else
				next_state = adding;
		end
		stopped: begin
			shift = '0;
			ready = '1;
			if (start)
				next_state = idle;
		end
	endcase
	end
endmodule

      
              
             
