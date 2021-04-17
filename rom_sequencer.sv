class rom_sequencer extends uvm_sequencer#(rom_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(rom_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="rom_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:rom_sequencer

