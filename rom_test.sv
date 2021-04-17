
class rom_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(rom_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="",uvm_component parent);
	    super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    rom_env env_h;
    int file_h;
  
    reset rseq;
    reset rseq1;
    rom_sequence seq;

    read_in_order seq1;
    read_in_order seq2;
    
    read_can_be_zero seq3;
    read_can_be_zero seq4;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = rom_env::type_id::create("env_h",this);

      rseq = reset::type_id::create("rseq");
      rseq1 = reset::type_id::create("rseq1");
      seq  = rom_sequence::type_id::create("seq");
      seq1 = read_in_order::type_id::create("seq1");
      seq2 = read_in_order::type_id::create("seq2");
      seq3 = read_can_be_zero::type_id::create("seq3");
      seq4 = read_can_be_zero::type_id::create("seq4");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //print();  // PRINT TOPOLOGY
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env_h.set_report_verbosity_level_hier(UVM_MEDIUM);
      print(); //PRINTS TOPOLOGY
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
	      phase.raise_objection(this);
     		rseq.start(env_h.agent_h.sequencer_h);
      		rseq1.start(env_h.agent_h.sequencer_h);
            seq.start(env_h.agent_h.sequencer_h);
            seq1.start(env_h.agent_h.sequencer_h);
            seq2.start(env_h.agent_h.sequencer_h);
            seq3.start(env_h.agent_h.sequencer_h);
            seq4.start(env_h.agent_h.sequencer_h);
            #10;
	      phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:rom_test