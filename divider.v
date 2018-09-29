// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name       : divider.v
// Module name     : divider
// Module Function : 任意整数时钟分频
// Author          : Derrick
//
// --------------------------------------------------------------------
// Usefully Information
// --------------------------------------------------------------------
// Posedge to next posedge is one clock
// Negedge to next negedge is one clock
// Posedge to next negedge maybe not 1/2 clock


module divider
  (
   clk,
   rst_n,
   divide_in,
   clock_out
   );

   input 	clk;
   input 	rst_n;
   input [7 : 0] divide_in;
   output 		 clock_out;

   reg [7 : 0] divide;
   reg [6 : 0] divide_half;
   reg [7 : 0] cnt_p;
   reg [7 : 0] cnt_n;
   reg 		   clk_p;
   reg 		   clk_n;

   always @(negedge clk or negedge rst_n) begin
	  if (!rst_n) begin
		 divide[7 : 0] <= 0;
		 divide_half[6 : 0] <= 0;
	  end else if (divide[7 : 0] != divide_in[7 : 0]) begin
		 if (cnt_n[7 : 0] == divide[7 : 0]) begin
			divide[7 : 0] <= divide_in[7 : 0];
			divide_half[6 : 0] <= divide_in[7 : 1] + divide_in[0];
		 end
	  end
   end

   always @(posedge clk or negedge rst_n) begin
	  if (!rst_n) begin
		 cnt_p <= 0;
	  end else if (cnt_p[7 : 0] == divide[7 : 0]) begin
		 cnt_p <= 0;
	  end else begin
		 cnt_p <= cnt_p + 1;
	  end
   end

   always @(posedge clk or negedge rst_n) begin
	  if (!rst_n) begin
		 clk_p <= 0;
	  end else if (cnt_p[7 : 0] < { 1'b 0, divide_half[6 : 0] }) begin
		 clk_p <= 0;
	  end else begin
		 clk_p <= 1;
	  end
   end

   always @(negedge clk or negedge rst_n) begin
	  if (!rst_n) begin
		 cnt_n <= 0;
	  end else if (cnt_n[7 : 0] == divide[7 : 0]) begin
		 cnt_n <= 0;
	  end else begin
		 cnt_n <= cnt_n + 1;
	  end
   end

   always @(negedge clk or negedge rst_n) begin
	  if (!rst_n) begin
		 clk_n <= 0;
	  end else if (cnt_n[7 : 0] < { 1'b 0, divide_half[6 : 0] }) begin
		 clk_n <= 0;
	  end else begin
		 clk_n <= 1;
	  end
   end

   assign clock_out = (divide[7 : 0] == 0) ? clk : divide[0] ? clk_p : (clk_p & clk_n);

endmodule
