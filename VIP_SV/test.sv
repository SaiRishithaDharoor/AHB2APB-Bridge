class test;
  environment env;  // creates handle
  virtual ahb_apb_bfm_if i;

  function new(virtual ahb_apb_bfm_if i);
    env = new(i); 
    this.i = i;
  endfunction : new
  
  task run();
    
    $display("in test");   
    env.create();  
  @(posedge i.clk);
    repeat(5) begin 
      
      $display($time, " in test repeat");

       env.env_write_single_halfword_nonseq_single_Htransfer_okay();
       env.env_read_single_byte_nonseq_single_Htransfer_okay();


       env.env_read_single_word_nonseq_single_Htransfer_okay();
       env.env_write_single_byte_nonseq_single_Htransfer_error();
       env.env_read_incr_halfword_nonseq_incr_Hburst_okay();
       env.env_write_incr_word_nonseq_incr_Hburst_okay();
       env.env_read_wrap4_byte_nonseq_wrap4_Hburst_okay();
       env.env_write_wrap4_halfword_nonseq_wrap4_Hburst_okay();
       env.env_read_wrap4_word_nonseq_wrap4_Hburst_okay();
       env.env_write_incr4_byte_nonseq_incr4_Hburst_okay();
       env.env_read_incr4_halfword_nonseq_incr4_Hburst_okay();
       env.env_write_incr4_word_nonseq_incr4_Hburst_okay();
       env.env_read_wrap8_byte_nonseq_wrap8_Hburst_okay();
       env.env_write_wrap8_halfword_nonseq_wrap8_Hburst_okay();
       env.env_read_wrap8_word_nonseq_wrap8_Hburst_okay();
       env.env_write_incr8_byte_nonseq_incr8_Hburst_okay();
       env.env_read_incr8_halfword_nonseq_incr8_Hburst_okay();
       env.env_write_incr8_word_nonseq_incr8_Hburst_okay();
       env.env_read_single_byte_seq_single_Htransfer_okay();
       env.env_write_single_halfword_seq_single_Htransfer_okay();
       env.env_read_single_word_seq_single_Htransfer_okay();
       env.env_write_single_byte_seq_single_Htransfer_error();
       env.env_read_incr_halfword_seq_incr_Hburst_okay();
       env.env_write_incr_word_seq_incr_Hburst_okay();
       env.env_read_wrap4_byte_seq_wrap4_Hburst_okay();
       env.env_write_wrap4_halfword_seq_wrap4_Hburst_okay();
       env.env_read_wrap4_word_seq_wrap4_Hburst_okay();
       env.env_write_incr4_byte_seq_incr4_Hburst_okay();
       env.env_read_incr4_halfword_seq_incr4_Hburst_okay();
       env.env_write_incr4_word_seq_incr4_Hburst_okay();
       env.env_read_single_byte_nonseq_single_Htransfer_reset();
       env.env_write_single_halfword_nonseq_single_Htransfer_reset();
       env.env_read_single_word_nonseq_single_Htransfer_reset();
       env.env_write_incr_byte_nonseq_incr_Hburst_reset();
       env.env_read_incr_halfword_nonseq_incr_Hburst_reset();
       env.env_write_incr_word_nonseq_incr_Hburst_reset();
       env.env_read_wrap4_byte_nonseq_wrap4_Hburst_reset();
       env.env_write_wrap4_halfword_nonseq_wrap4_Hburst_reset();
       env.env_read_wrap4_word_nonseq_wrap4_Hburst_reset();
       env.env_write_incr4_byte_nonseq_incr4_Hburst_reset();
       env.env_read_incr4_halfword_nonseq_incr4_Hburst_reset();
       env.env_write_incr4_word_nonseq_incr4_Hburst_reset();
       env.env_write_incr4_word_idle_incr4_Hburst_reset();
       env.env_write_incr4_word_busy_incr4_Hburst_reset();
       env.env_write_single_byte_idle_single_Htransfer_error();
    
    end
     endtask
    

endclass
