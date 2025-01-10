module Data_Mem(
    A,
    WE,
    WD,
    RD,
    clk
);
  input WE, clk;

  input [31:0] A, WD;
  output [31:0] RD;
  reg [31:0] Data_MEM[1023:0];  

  assign RD = (WE) ? 32'h00000000 : Data_MEM[A];
  always @(posedge clk) begin
    if (WE) Data_MEM[A] <= WD;
  end
initial
begin
  Data_MEM[28] = 32'h00000020;
  
end









endmodule
