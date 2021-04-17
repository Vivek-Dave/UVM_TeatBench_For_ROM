module adder(in1,
            in2,
            out,
            clk,
            rst);

    input [3:0]in1,in2;
    input rst,clk;

    output reg [4:0] out;

    always@(posedge clk or posedge rst)
    begin
        if(rst==1)
        begin
            out<=0;
        end
        else 
        begin
            out<=in1+in2;    
        end
    end

endmodule
