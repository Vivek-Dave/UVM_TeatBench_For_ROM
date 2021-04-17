
class rom_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(rom_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  rom_sequence_item  txn;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(rom_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
    txn=rom_sequence_item::type_id::create("txn",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    forever
    begin
      @(negedge vif.clk);
      txn.rst  = vif.rst;
      txn.addr = vif.addr;
      txn.rd   = vif.rd;
      txn.out  = vif.out;
      ap_mon.write(txn);
    
    end
  endtask
  //----------------------------------------------------------------------------


endclass:rom_monitor

