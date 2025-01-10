module Reg_File(clk,RD1,RD2,WD3,WE3,rst, A1,A2,A3);

input [4:0] A1,A2,A3;
input [31:0] WD3;
input WE3,clk,rst;
output[31:0] RD1,RD2;





reg[31:0] Reg_file[31:0];


assign RD1 = (rst) ? 32'h00000000 : Reg_file[A1];
assign RD2 = (rst) ? 32'h00000000 : Reg_file[A2];


initial begin
    Reg_file[5] = 32'h00000020;
    Reg_file[6] = 32'h000000A0;


end


always @(posedge clk)
begin
  

    if(WE3)
        Reg_file[A3] <= WD3;
end


endmodule