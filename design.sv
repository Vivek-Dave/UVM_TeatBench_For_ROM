module ROM(rd,
		   addr,
		   out,
		   clk,
           rst
		   );
		   
    parameter ADDR=5; // 32 locations 
	parameter WIDTH=8;	  
	
	input rd;
	input clk;
  	input rst;
	input [ADDR-1:0]addr;
	
	output reg [WIDTH-1:0]out;
	reg [WIDTH-1:0] temp;

  always@(posedge clk or posedge rst)
    if(rst==1)
      begin
        out<=0;
      end
     else
	   begin
		out<=temp;
	   end

	always@(addr or rd)
		begin
			if(rd)
				begin
					case(addr)
						0:temp=8'h45;
						1:temp=8'h60;
						2:temp=8'h23;
						3:temp=8'h79;
						4:temp=8'h12;
						5:temp=8'hab;
						6:temp=8'hcf;
						7:temp=8'h9a;
						8:temp=8'hb2;
						9:temp=8'hc4;
						10:temp=8'h8d;
						11:temp=8'h1d;
						12:temp=8'h34;
						13:temp=8'he4;
						14:temp=8'ha6;
						15:temp=8'h9d;
						16:temp=8'h87;
						17:temp=8'h21;
						18:temp=8'h3a;
						19:temp=8'h0a;
						20:temp=8'ha0;
						21:temp=8'hbc;
						22:temp=8'hcd;
						23:temp=8'h67;
						24:temp=8'h39;
						25:temp=8'hda;
						26:temp=8'hd4;
						27:temp=8'h9b;
						28:temp=8'h5b;
						29:temp=8'h6a;
						30:temp=8'h7c;
						31:temp=8'hc3;
						default:temp=8'bx;
					endcase
				end //end if
			else
				begin
					temp=8'bx;
				end
			
		end
endmodule
