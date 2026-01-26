class ahb_apb_monitor;

    Transaction tx;      // Transaction handle            
    mailbox #(Transaction) mail2sb;  // Mailbox to the scoreboard

    // Virtual interface reference
    virtual ahb_apb_bfm_if.slave vif;            
    
    function new(mailbox #(Transaction) mail2sb, virtual ahb_apb_bfm_if.slave vif);
        this.mail2sb = mail2sb;
        this.vif = vif;
    endfunction

    // Watch and send transactions to the scoreboard
    task watch;
        tx = new();
        
        // Loop to monitor transactions
        forever begin
            @(vif.mon_cb) begin  // Use the clocking block to sample the interface signals
                wait(vif.mon_cb.Htrans !== 2'b00); // Wait for any transaction to start
                //tx.trans_type = vif.mon_cb.Hwrite ? Transaction.AHB_WRITE : Transaction.AHB_READ;
                tx.Haddr      = vif.mon_cb.Haddr;
                tx.Hwdata     = vif.mon_cb.Hwdata;
                tx.Hwrite     = vif.mon_cb.Hwrite;
                tx.Htrans     = vif.mon_cb.Htrans;
                tx.Paddr      = vif.mon_cb.Paddr;
                tx.Pwdata     = vif.mon_cb.Pwdata;
                tx.Pwrite     = vif.mon_cb.Pwrite;
                tx.Pselx      = vif.mon_cb.Pselx;
                
                mail2sb.put(tx); // Send the transaction to the scoreboard
                $display($time, " monitor tx=%p", tx);
            end
        end
    endtask

endclass
