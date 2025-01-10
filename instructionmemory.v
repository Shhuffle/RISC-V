





module Instr_Mem(A,rst,RD);
input[31:0] A; //address of the instruction 
input rst;

output[31:0] RD; //output read value form the memory 
reg[31:0] mem[1023:0]; //memory bank 

assign RD = rst ? 32'h00000000 : mem[A[31:2]];
initial begin
    //mem[0] = 32'hFFC4A303;
    mem[0] = 32'h0062E223;
end

endmodule