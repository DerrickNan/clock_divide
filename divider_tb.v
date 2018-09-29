// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : divider_tb.v
// Module name  : divider_tb
// Author       : Derrick
// Description  : clock divider test


`timescale 1ns/100ps

module divider_tb();
   reg    clk;
   reg 	  rst_n;
   reg [7 : 0] divide;
   wire 	   clkout;

   initial 
     begin 
		clk = 0;
		rst_n = 0;
		#5 rst_n = 1;
		#10 divide[7 : 0] <= 0;
		#30 divide[7 : 0] <= 1;
		#50 divide[7 : 0] <= 2;
		#70 divide[7 : 0] <= 3;
		#90 divide[7 : 0] <= 4;
		#110 divide[7 : 0] <= 5;
		#130 divide[7 : 0] <= 6;
		#150 divide[7 : 0] <= 7;
     end

   always #1 clk = ~clk;

   divider  #(.WIDTH(4), .N(11))  u1 (.clk	    (clk),
									  .rst_n	    (rst_n),
									  .divide_in (divide),
									  .clkout	(clkout)   
									  );
endmodule
