module sign_Extend(Instr_Rd,ImmExt,ImmSrc);
input[31:0] Instr_Rd;
input[1:0] ImmSrc;
output[31:0] ImmExt;

assign ImmExt = (Instr_Rd[31] == 1'b1 && ImmSrc == 2'b00) ?  {{20{1'b1}},Instr_Rd[31:20]}  : 
                (Instr_Rd[31] == 1'b0 && ImmSrc == 2'b00) ?  {{20{1'b0}},Instr_Rd[31:20]}  :
                (Instr_Rd[11] == 1'b1 && ImmSrc == 2'b01) ?  {{20{1'b1}},Instr_Rd[31:25],Instr_Rd[11:7]}   :     {{20{1'b0}},Instr_Rd[31:25],Instr_Rd[11:7]};
endmodule