/*



R-Type Instruction Format:

| 31:25  | 24:20 | 19:15 | 14:12  | 11:7  | 6:0  |
|--------|-------|-------|--------|-------|------|
| funct7 |  rs2  |  rs1  | funct3 |  rd   |  op  |
|  7 bits | 5 bits | 5 bits | 3 bits | 5 bits | 7 bits |

I-Type Instruction Format:

| 31:20   | 19:15 | 14:12  | 11:7  | 6:0  |
|---------|-------|--------|-------|------|
| imm[11:0] |  rs1  | funct3 |  rd   |  op  |
|  12 bits  | 5 bits |  3 bits | 5 bits | 7 bits |

S-Type Instruction Format:

| 31:25  | 24:20 | 19:15 | 14:12  | 11:7  | 6:0  |
|--------|-------|-------|--------|-------|------|
| imm[11:5] |  rs2  |  rs1  | funct3 |  imm[4:0]   |  op  |
|  7 bits | 5 bits | 5 bits | 3 bits | 5 bits | 7 bits |







    | Instruction | Op      | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp |
|------------     |--------|----------|--------|--------|----------|-----------|--------|-------|
| lw              | 0000011 | 1        | 00     | 0      | 0        | 1         | 0      | 00    |
| sw              | 0100011 | 0        | 01     | 0      | 1        | 0         | 0      | 00    |
| R-type          | 0110011 | 1        | xx     | 1      | 0        | 0         | 0      | 10    |
| beq             | 1100011 | 0        | 10      | 0      | 0        | -         | 1      | 01    |
*/

module control (
    op,
    zero,
    RegWrite,
    MemWrite,
    ResultSrc,
    ALUSrc,
    ImmSrc,
    ALUOp,
    PCSrc
);
  //Inputs / Outputs declaration 
  input zero;
  input [6:0] op;
  output RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc;
  output [1:0] ImmSrc, ALUOp;
  wire branch;
  assign ALUSrc = ((op == 7'b0110011)) ? 1 : 0;


  assign RegWrite = (op[4] == op[5]) ? 1'b1 : 1'b0;

  assign MemWrite = (op == 7'b0100011) ? 1'b1 : 1'b0;

  assign ResultSrc = (op == 7'b0000011) ? 1'b1 : 1'b0;


  assign branch = (op == 7'b1100011) ? 1'b1 : 1'b0;

  assign PCSrc = branch & zero;

  assign ImmSrc = (op == 7'b0100011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 : 2'b00;

  assign ALUOp = (op == 7'b0110011) ? 2'b10 : ((op == 7'b1100011) ? 2'b01 : 2'b00);



endmodule
