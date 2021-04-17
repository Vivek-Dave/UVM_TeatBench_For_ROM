
interface intf(input bit clk);

    parameter ADDR=5; // 32 locations 
	  parameter WIDTH=8;
    // ------------------- port declaration-------------------------------------
    logic [ADDR-1:0]addr;
    logic rd;
    logic [WIDTH-1:0]out;
    logic rst;
    //--------------------------------------------------------------------------
 
endinterface

