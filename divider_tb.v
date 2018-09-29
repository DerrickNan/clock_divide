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
   wire 	   clock_out;

   initial 
     begin 
		clk = 0;
		rst_n = 0;
		#10 rst_n = 1;
		divide[7 : 0] <= 0;
		#50 divide[7 : 0] <= 1;
		#50 divide[7 : 0] <= 2;
		#50 divide[7 : 0] <= 3;
		#50 divide[7 : 0] <= 4;
		#50 divide[7 : 0] <= 5;
		#50 divide[7 : 0] <= 6;
		#50 divide[7 : 0] <= 7;
		#50 divide[7 : 0] <= 6;
		#50 divide[7 : 0] <= 5;
		#50 divide[7 : 0] <= 4;
		#50 divide[7 : 0] <= 3;
		#50 divide[7 : 0] <= 2;
		#50 divide[7 : 0] <= 1;
     end

   always #1 clk = ~clk;

   divider clock_divider (.clk       (clk),
						  .rst_n     (rst_n),
						  .divide_in (divide),
						  .clock_out (clock_out)
						  );
endmodule
