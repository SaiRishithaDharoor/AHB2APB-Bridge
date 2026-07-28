module bridge_assumptions(

input logic Hclk,
input logic Hresetn,

input logic Hwrite,
input logic Hreadyin,

input logic [31:0] Haddr,
input logic [31:0] Hwdata,
input logic [1:0] Htrans

);

// reset eventually deasserts
assume_reset:

assume property(
@(posedge Hclk)

$initstate |-> !Hresetn
);

// HTRANS legal values

assume_htrans:

assume property(
@(posedge Hclk)

Htrans inside {2'b00,2'b10,2'b11}
);

// address aligned

assume_addr_align:

assume property(
@(posedge Hclk)

Haddr[1:0]==2'b00
);

// stable while stalled

assume_stable:

assume property(
@(posedge Hclk)

!Hreadyin |=> $stable(Haddr)
);

// write data stable

assume_data:

assume property(
@(posedge Hclk)

!Hreadyin |=> $stable(Hwdata)
);

endmodule

bind Bridge_Top bridge_assumptions assumptions(.*);