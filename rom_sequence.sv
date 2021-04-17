
/***************************************************
** class name  : rom_sequence
** description : read randomly from rom,
                 addr is random and rd==1 
***************************************************/
class rom_sequence extends uvm_sequence#(rom_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(rom_sequence)            
  //----------------------------------------------------------------------------

  rom_sequence_item txn;
  int unsigned loop_count=40;

  //----------------------------------------------------------------------------
  function new(string name="rom_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    for(int i=0;i<loop_count;i++)
      begin
        txn=rom_sequence_item::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{txn.rd==1;});
        txn.rst=0;
        finish_item(txn);
      end
  endtask:body
  //----------------------------------------------------------------------------
endclass:rom_sequence

/***************************************************
** class name  : read_in_order
** description : read from ROM from location 0 to 31
                 one by one, starting with addr=0
                 to addr=31 , rd==1
***************************************************/
class read_in_order extends rom_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(read_in_order)      
  //----------------------------------------------------------------------------
  
  rom_sequence_item txn;
  int unsigned loop_count=32;
  //----------------------------------------------------------------------------
  function new(string name="read_in_order");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(2)
      begin
        for(int i=0;i<loop_count;i++)
          begin
            txn=rom_sequence_item::type_id::create("txn");
            start_item(txn);
            assert(txn.randomize()with{txn.addr==i; txn.rd==1;});
            txn.rst=0;
            finish_item(txn);
          end
      end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : read_can_be_zero
** description : here rd signal may or may not be 1,
                 it can be 1 or 0, address is random
***************************************************/
class read_can_be_zero extends rom_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(read_can_be_zero)      
  //----------------------------------------------------------------------------
  
  rom_sequence_item txn;
  int unsigned loop_count=32;
  
  //----------------------------------------------------------------------------
  function new(string name="read_can_be_zero");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i=0;i<loop_count;i++)
      begin
        txn=rom_sequence_item::type_id::create("txn");
        start_item(txn);
        txn.randomize();
        txn.rst=0;
        finish_item(txn);
      end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

class reset extends rom_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(reset)      
  //----------------------------------------------------------------------------
  
  rom_sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="reset");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
        txn=rom_sequence_item::type_id::create("txn");
		start_item(txn);
        txn.rst=1;
    	txn.addr=0;
    	txn.rd=0;
        finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

