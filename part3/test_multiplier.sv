module test_multiplier;

logic start, n_rst, clock; 
logic [7:0] Min, Qin; 
logic ready; 
logic[15:0] AQ;

multiplier m0 (.*);

initial 
begin
  clock = 1'b0; 
  forever #10ns clock = ~clock; 
end

initial
  begin
  n_rst = '1;
  #2ns n_rst = '0;
  #2ns n_rst = '1;
  end
  
initial
  begin
  start = '0;
  Min = '0;
  Qin = '0;
  #5ns start = '1;
  Min = 3;
  Qin = 5;
  @(posedge ready) // Wait for ready to become true
    if (AQ==Min*Qin)
      $display("Test passed: at %t Min = %d, Qin = %d, AQ = 15", $time, Min, Qin);
    else
      $display("Test passed: at %t Min = %d, Qin = %d, AQ = 15", $time, Min, Qin);
  end
  
endmodule
