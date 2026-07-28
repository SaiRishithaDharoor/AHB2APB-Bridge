module AHB_slave_interface_sva(

  input wire Hclk,
  input wire Hresetn,
  input wire Hwrite,
  input wire Hreadyin,
  input wire [1:0] Htrans,
  input wire [31:0] Haddr,
  input wire [31:0] Hwdata,
  input wire [31:0] Prdata,
  input wire valid,
  input wire [31:0] Haddr1,
  input wire [31:0] Haddr2,
  input wire [31:0] Hwdata1,
  input wire [31:0] Hwdata2,
  input wire [31:0] Hrdata,
  input wire Hwritereg,
  input wire [2:0] tempselx,
  input wire [1:0] Hresp
);

// VALID GENERATION
property p_valid_generation;
@(posedge Hclk)
disable iff(!Hresetn)
(Hreadyin &&
(Htrans inside {2'b10,2'b11}) &&
(Haddr>=32'h8000_0000) &&
(Haddr<32'h8C00_0000))
|-> valid;
endproperty
assert property(p_valid_generation);

// INVALID ADDRESS
property p_invalid_address;
@(posedge Hclk)
disable iff(!Hresetn)
(Haddr<32'h8000_0000 ||
 Haddr>=32'h8C00_0000)
|-> !valid;
endproperty
assert property(p_invalid_address);

// INVALID HTRANS
property p_invalid_htrans;
@(posedge Hclk)
disable iff(!Hresetn)
!(Htrans inside {2'b10,2'b11})
|-> !valid;
endproperty
assert property(p_invalid_htrans);

// HADDR1 PIPELINE
property p_haddr1_capture;
@(posedge Hclk)
disable iff(!Hresetn)
Haddr1==$past(Haddr);
endproperty
assert property(p_haddr1_capture);

// HADDR2 PIPELINE
property p_haddr2_capture;
@(posedge Hclk)
disable iff(!Hresetn)
Haddr2==$past(Haddr1);
endproperty
assert property(p_haddr2_capture);

// HWDATA1 PIPELINE
property p_hwdata1_capture;
@(posedge Hclk)
disable iff(!Hresetn)
Hwdata1==$past(Hwdata);
endproperty
assert property(p_hwdata1_capture);

// HWDATA2 PIPELINE
property p_hwdata2_capture;
@(posedge Hclk)
disable iff(!Hresetn)
Hwdata2==$past(Hwdata1);
endproperty
assert property(p_hwdata2_capture);

// HWRITE REGISTER
property p_hwritereg;
@(posedge Hclk)
disable iff(!Hresetn)
Hwritereg==$past(Hwrite);
endproperty
assert property(p_hwritereg);

// HRESP
property p_hresp_okay;
@(posedge Hclk)
Hresp==2'b00;
endproperty
assert property(p_hresp_okay);

// HRDATA
property p_hrdata;
@(posedge Hclk)
Hrdata==Prdata;
endproperty
assert property(p_hrdata);

// ADDRESS DECODER : SLAVE0
property p_slave0;
@(posedge Hclk)
disable iff(!Hresetn)
(Haddr>=32'h8000_0000 &&
 Haddr<32'h8400_0000)
|-> tempselx==3'b001;
endproperty
assert property(p_slave0);

// ADDRESS DECODER : SLAVE1
property p_slave1;
@(posedge Hclk)
disable iff(!Hresetn)
(Haddr>=32'h8400_0000 &&
 Haddr<32'h8800_0000)
|-> tempselx==3'b010;
endproperty
assert property(p_slave1);

// ADDRESS DECODER : SLAVE2
property p_slave2;
@(posedge Hclk)
disable iff(!Hresetn)
(Haddr>=32'h8800_0000 &&
 Haddr<32'h8C00_0000)
|-> tempselx==3'b100;
endproperty
assert property(p_slave2);

// OUT OF RANGE
property p_no_slave;
@(posedge Hclk)
disable iff(!Hresetn)
(Haddr<32'h8000_0000 ||
 Haddr>=32'h8C00_0000)
|-> tempselx==3'b000;
endproperty
assert property(p_no_slave);

// COVER PROPERTIES
cover property(@(posedge Hclk)valid);
cover property(@(posedge Hclk) tempselx==3'b001);
cover property( @(posedge Hclk)tempselx==3'b010);
cover property(@(posedge Hclk)tempselx==3'b100);
endmodule


bind AHB_slave_interface AHB_slave_interface_sva chk_ahb_slave_interface(.*);
