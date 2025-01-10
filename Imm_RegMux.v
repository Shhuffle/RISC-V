module Imm_RegMux(RD2,ImmExt,SrcB,ALUSrc);
input [31:0] RD2,ImmExt;
input ALUSrc;
output [31:0] SrcB;
assign SrcB = (ALUSrc) ? ImmExt : RD2;
endmodule