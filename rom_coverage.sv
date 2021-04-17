
class rom_coverage extends uvm_subscriber #(rom_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(rom_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  rom_sequence_item txn;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup dut_cov;
    option.per_instance=1;
    ADDR   :coverpoint txn.addr;
    RD     :coverpoint txn.rd;
    ADDRXRD:cross ADDR,RD;
  endgroup:dut_cov

  //----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  function void write(rom_sequence_item t);
    txn=t;
    dut_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:rom_coverage

