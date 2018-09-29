// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : selector_tb.v
// Module name  : selector_tb
// Author       : Derrick
// Description  : two choice selector test


`timescale 1ns/100ps

module selector_tb();
   reg    clk;
   reg 	  rst_n;

   reg 	  select;
   reg [7 : 0] divide_1;
   reg [7 : 0] divide_2;
   wire 	   global_clock;
   wire 	   global_clock1;
   wire 	   global_clock2;

   initial 
     begin 
		clk = 0;
		rst_n = 0;
		select = 0;
		divide_1[7 : 0] = 3;
		divide_2[7 : 0] = 8;
		#10 rst_n = 1;
	    #90 select = 1;
		#100 select = 0;
		#100 select = 1;
		#100 select = 0;
		#100 select = 1;
		#100 select = 0;
		#100 select = 1;
		#100 select = 0;
		#100 select = 1;
		#100 select = 0;
     end

   always #1 clk = ~clk;

   divider clock1_divider (.clk       (clk),
						   .rst_n     (rst_n),
						   .divide_in (divide_1),
						   .clock_out (global_clock1)
						   );

   divider clock2_divider (.clk       (clk),
						   .rst_n     (rst_n),
						   .divide_in (divide_2),
						   .clock_out (global_clock2)
						   );

   // Attention : BUFGMUX need wait 100 ns after power on
   //             So we need to change select after 100 ns
   BUFGMUX BUFGMUX_inst (.O(global_clock),   // 1-bit output : Clock output
						 .I0(global_clock1), // 1-bit input  : Clock input (S=0)
						 .I1(global_clock2), // 1-bit input  : Clock input (S=1)
						 .S(select)          // 1-bit input  : Clock select
						 );

endmodule
