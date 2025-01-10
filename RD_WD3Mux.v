module RD_WD3Mux(RD,ALUResult,ResultSrc,WD3);
input[31:0] RD,ALUResult;
input ResultSrc;
output[31:0] WD3;

assign WD3 = (ResultSrc) ? RD : ALUResult;

endmodule