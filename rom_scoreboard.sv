
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class rom_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(rom_scoreboard)
  
  uvm_analysis_imp_drv #(rom_sequence_item, rom_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(rom_sequence_item, rom_scoreboard) aport_mon;
  
  uvm_tlm_fifo #(rom_sequence_item) expfifo;
  uvm_tlm_fifo #(rom_sequence_item) outfifo;
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  bit[7:0] rom_compare[32];
  
  logic [7:0] queue[$];
  int count=0;
  
  reg [7:0] t_out;
  reg [4:0] t_addr;
  logic     t_rd;
  logic     t_rst;
  // more efficient way is to writ function for it.

  function new(string name="rom_scoreboard",uvm_component parent);
    super.new(name,parent);
      rom_compare[0]  =8'h45;
      rom_compare[1]  =8'h60;
      rom_compare[2]  =8'h23;
      rom_compare[3]  =8'h79;
      rom_compare[4]  =8'h12;
      rom_compare[5]  =8'hab;
      rom_compare[6]  =8'hcf;
      rom_compare[7]  =8'h9a;
      rom_compare[8]  =8'hb2;
      rom_compare[9]  =8'hc4;
      rom_compare[10] =8'h8d;
      rom_compare[11] =8'h1d;
      rom_compare[12] =8'h34;
      rom_compare[13] =8'he4;
      rom_compare[14] =8'ha6;
      rom_compare[15] =8'h9d;
      rom_compare[16] =8'h87;
      rom_compare[17] =8'h21;
      rom_compare[18] =8'h3a;
      rom_compare[19] =8'h0a;
      rom_compare[20] =8'ha0;
      rom_compare[21] =8'hbc;
      rom_compare[22] =8'hcd;
      rom_compare[23] =8'h67;
      rom_compare[24] =8'h39;
      rom_compare[25] =8'hda;
      rom_compare[26] =8'hd4;
      rom_compare[27] =8'h9b;
      rom_compare[28] =8'h5b;
      rom_compare[29] =8'h6a;
      rom_compare[30] =8'h7c;
      rom_compare[31] =8'hc3;
  endfunction
    
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	  aport_drv = new("aport_drv", this);
	  aport_mon = new("aport_mon", this);
	  expfifo   = new("expfifo",this);
	  outfifo   = new("outfifo",this);
  endfunction


  function void write_drv(rom_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    t_rd	= tr.rd;
    t_addr  = tr.addr;
    t_rst   = tr.rst;
    
    if(t_rst==1)
      begin
        t_out=0;
        count=0;
      end
    else if(t_rd==1)
      begin
		t_out = rom_compare[t_addr];
        queue.push_back(t_out);
      end
    else if(t_rd==0)
	  begin
        t_out = 8'bx;
        queue.push_back(t_out);
	  end
    // tr.out =(count<2)?t_out:(queue.push_front());
    
    if(count<=1) tr.out=0;
    else tr.out=queue.pop_front();
    
    count=count+1;
    void'(expfifo.try_put(tr));
  endfunction

  function void write_mon(rom_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  
  task run_phase(uvm_phase phase);
	rom_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
        if (out_tr.out===exp_tr.out) begin
            PASS();
           `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      	else begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
    end
  endtask

  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf(" *** TEST PASSED - %0d vectors ran, %0d vectors passed***",VECT_CNT, PASS_CNT), UVM_LOW)
        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed,%0d vectors failed ***",VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

endclass

