class coverage_collector;

    Transaction tx;     // Transaction object
    mailbox #(Transaction) driv2cor;   // Mailbox for Generator to Driver
    virtual ahb_apb_bfm_if vif;
    // Coverage groups
    covergroup cov_cg;
        trans_type_cp: coverpoint tx.trans_type {
            bins read  = {Transaction::AHB_READ};
            bins write = {Transaction::AHB_WRITE};
        }
        Htrans_cp: coverpoint tx.Htrans {
            bins non_seq = {2'b00};
            bins idle    = {2'b01};
            bins seq     = {2'b10};
            bins busy    = {2'b11};
        }
        Hsize_cp: coverpoint tx.Hsize {
            bins size_byte     = {3'b000};
            bins size_halfword = {3'b001};
            bins size_word     = {3'b010};
        }
        Hburst_cp: coverpoint tx.Hburst {
            bins single = {3'b000};
            bins incr   = {3'b001};
            bins wrap4  = {3'b010};
            bins incr4  = {3'b011};
        }
        // Cross coverage
        trans_x_htrans: cross trans_type_cp, Htrans_cp;
        trans_x_hsize: cross trans_type_cp, Hsize_cp;
        trans_x_hburst: cross trans_type_cp, Hburst_cp;
    endgroup

    // cov_cg ahb_cg;
    function new(mailbox #(Transaction) driv2cor, virtual ahb_apb_bfm_if vif);
        this.driv2cor = driv2cor;
       cov_cg = new;
        this.vif = vif;
    endfunction

    // Function to sample the coverage
    /* function void sample_coverage();
        cov_cg.sample();
    endfunction

    // Function to print the coverage report
    function void print_coverage();
        $display("Coverage: %0d%%", cov_cg.get_coverage() * 100);
    endfunction */

    // Task to get Transaction from mailbox and sample coverage
    task execute();
        forever begin
            driv2cor.get(tx);
           // sample_coverage();
           $display("tx got", tx);
        end
    endtask
endclass
