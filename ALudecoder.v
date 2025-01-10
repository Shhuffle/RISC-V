module alu_decoder (
    ALUOp,
    funct3,
    funct7,
    ALUControl,
    op5
);
  input [1:0] ALUOp;
  input [2:0] funct3;
  input funct7, op5;
  output [2:0] ALUControl;


  wire [1:0] interim;



  assign ALUControl = 
                    (ALUOp == 2'b00) ? 3'b000 : 
                    (ALUOp == 2'b01) ? 3'b001 : 
                     
                    ((ALUOp == 2'b10) & ({op5,funct7} != 2'b11) & (funct3 == 3'b000)) ? 3'b000 : 
                    ((ALUOp == 2'b10) & ({op5,funct7} == 2'b11) & (funct3 == 3'b000)) ? 3'b001:
                    ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :
                    ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :
                    ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 3'b111;



endmodule
