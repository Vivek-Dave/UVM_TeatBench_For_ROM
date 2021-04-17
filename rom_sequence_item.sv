class rom_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------
  parameter ADDR=5; // 32 locations 
	parameter WIDTH=8;

  rand logic [ADDR-1:0]addr;  //i/p
  rand logic rd;

  logic [WIDTH-1:0]out;       //o/p
  logic rst;

  //---------------- register rom_sequence_item class with factory --------
  `uvm_object_utils_begin(rom_sequence_item) 
     `uvm_field_int( addr ,UVM_ALL_ON)
     `uvm_field_int( rd   ,UVM_ALL_ON)
     `uvm_field_int( out  ,UVM_ALL_ON)
  	 `uvm_field_int( rst  ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="rom_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("addr=%d  rd=%0b rst=%0b", addr,rd,rst));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("out=%8h ", out));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), "  ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:rom_sequence_item
