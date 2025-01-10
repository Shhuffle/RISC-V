//ALU Contorl 
/*

ALUControl                  Instruction
000 (add)                   lw, sw
001 (subtract)              beq
000 (add)                   add
001 (subtract)              sub
101 (set less than)         slt
011 (or)                    or
010 (and)                   and

*/



module alu(A,B,Result,ALUControl,Z,N,V,C);
//Inputs 
input [31:0] A,B;
input [2:0] ALUControl;
output [31:0] Result;
output Z,N,V,C;
 
//declaring wires

wire[31:0] a_or_b;
wire[31:0] a_and_b;
wire[31:0] b_not;
wire[31:0] b_multiplex;
wire[31:0] sum;
wire cout;
wire [31:0] slt;


//Logic design
assign a_and_b = A & B;
assign a_or_b = A | B;
assign b_not = ~B;
assign b_multiplex = (ALUControl[0] == 1'b0) ? B: b_not ; //selects B for addition and b_not for subtration depending on the value of ALUControl[0] bit.
assign {cout,sum} = b_multiplex + A + ALUControl[0];               //adjusted for 2'complement substraction 
assign slt = {31'b0000000000000000000000000000000,sum[31]};  //contatination fo the set less then to match the 32 bit result



//Multiplexing the result based on the upcode of the ALUControl
assign Result = (ALUControl[2-0] == 3'b000 || ALUControl[2-0] == 3'b001) ? sum : 
                (ALUControl[2-0] == 3'b010) ? a_and_b: 
                (ALUControl[2-0] == 3'b011) ? a_or_b: 
                (ALUControl[2-0] == 3'b101 ) ? slt : 32'h00000000;  


//Flags
assign Z = &(~Result); 
assign N = Result[31];
assign C = cout & ~(ALUControl[1]);
assign V = (~(ALUControl[0] ^ A[31] ^ B[31])) & (A[31] ^ sum[31]) & (~ALUControl[1]);



endmodule

// module tb();

// reg[31:0] A,B;
// reg[2:0] ALUControl;
// wire[31:0] Result;
// alu a(A,B,Result,ALUControl,Z,N,V,C);


// initial begin
//     A = 32'hFFFFFFFF;
//     B = 32'hFE000001;
//     ALUControl = 3'b000;
//     $monitor("%b is the result and the Overflow flag %b  carry flag %b" , a.Result,a.V,a.C);
// end
// endmodule