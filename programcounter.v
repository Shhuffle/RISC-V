module P_C(PC_NEXT,clk,rstn,PC);
input[31:0] PC_NEXT;
input clk,rstn;


output reg[31:0] PC;


always @(posedge clk) begin
    if(rstn == 1'b0)
    PC <= 32'h00000000;
    else
    PC <= PC_NEXT;
end



endmodule