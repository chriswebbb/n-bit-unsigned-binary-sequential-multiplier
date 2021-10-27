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
				next_state = shifting;      
				cntN_state = three; //added code     if(Q0)       add='1;    else      next_state = idle;    end 
			if(Q0)
				add = '1;
			else
				next_state = idle;
			end
		shifting:begin    
			shift = '1;    
			unique case(cntP_state)     
			zero: 	begin      
				count = 0;      
				cntN_state = four;      
				next_state = stopped;      
				end     
			one: 	begin      
				cntN_state = zero;      
				next_state = shifting;      
				if(Q0)       
					add='1;      
				end     
			two: 	begin      
				cntN_state = one;      
				next_state = shifting;      
				if(Q0)       
					add='1;      
				end     
			three:  begin      
				cntN_state =two;      
				next_state = shifting;      
				if(Q0)       
					add='1;      
				end    
			endcase    
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
      
              
             
