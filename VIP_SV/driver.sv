class driver;

    Transaction tx; // Handle for transactions       

    mailbox #(Transaction) gen2driv; // Generator to Driver mailbox
    mailbox #(Transaction) driv2sb;  // Driver to Scoreboard mailbox
    mailbox #(Transaction) driv2cor; // Driver to DUV (Device Under Verification) mailbox
    virtual ahb_apb_bfm_if.master vif;                 // Virtual interface to DUV

    // Constructor
    function new(mailbox #(Transaction)gen2driv, mailbox #(Transaction)driv2sb, mailbox #(Transaction)driv2cor, virtual ahb_apb_bfm_if.master vif);
        this.gen2driv = gen2driv; // assigning gen2driv 
        this.driv2sb = driv2sb;   // assigning driv2sb
        this.driv2cor = driv2cor; // assigning driv2cor
        this.vif = vif;           // assigning virtual interface
    endfunction

// Task to get packets from generator and drive them into interface
task drive; 
    gen2driv.get(tx);   
    driv2sb.put(tx);   
    driv2cor.put(tx);
    $display("driver tx", tx);
    // Driving the values to the DUV via the virtual interface
    vif.drv_cb.Hwrite <= tx.Hwrite;     
    vif.drv_cb.Htrans <= tx.Htrans;
    vif.drv_cb.Hwdata <= tx.Hwdata;     
    vif.drv_cb.Haddr <= tx.Haddr;
   @(posedge vif.clk);  // wait for 10 time units
    // vif.drv_cb.Hsize <= tx.Hsize;      
    // vif.drv_cb.Hburst <= tx.Hburst;    
endtask
endclass
