`include "main_decoder1.v"
`include "Aludecoder.v"








module control_top(Op,funct3,funct7,RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,ImmSrc,ALUControl);
input [6:0]Op;
input funct7;
input [2:0]funct3;
output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
output [1:0]ImmSrc;
output [2:0]ALUControl;


wire[1:0] ALUOp;



//module control (    op,    zero,    RegWrite,    MemWrite,    ResultSrc,    ALUSrc,    ImmSrc,    ALUOp,    PCSrc);
control C(.op(Op),
        .zero(),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ALUOp(ALUOp)
        );



//module alu_decoder (    ALUOp,    funct3,    funct7,    ALUControl,    op5);


alu_decoder ad(
                .ALUOp(ALUOp),
                .funct3(funct3),
                .funct7(funct7),
                .ALUControl(ALUControl),
                .op5(Op[5])
);





endmodule