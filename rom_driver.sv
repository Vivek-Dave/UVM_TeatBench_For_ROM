
class rom_driver extends uvm_driver #(rom_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(rom_driver)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 
  
  uvm_analysis_port #(rom_sequence_item) drv2sb;

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    rom_sequence_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      @(posedge vif.clk);
      vif.rst  = txn.rst;
      vif.addr = txn.addr;
      vif.rd   = txn.rd;
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------
  
endclass:rom_driver