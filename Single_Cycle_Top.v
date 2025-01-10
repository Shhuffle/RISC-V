`include "programcounter.v"
`include "datamem.v"
`include "Regfile.v"
`include "instructionmemory.v"
`include "Extender.v"
`include "ALU.v"
`include "contorl_top.v"
`include "PC_adder.v"
`include "Imm_RegMux.v"
`include "RD_WD3Mux.v"

module Single_Cycle_Top(clk,rst);


input clk,rst;
wire[31:0] RDMux,PC_Top,Instr,RD1_Top,Imm_top,ALUResult_Top,ReadData,PCNEXT,RD2_top,SrcB;
wire [2:0] ALUControl_Top; 
wire[1:0] ImmSrc;
wire MemWrite,ALUSrc_Top,ResultSrcTop; 
wire N,Z,V,C; //flags of the alu
wire RegWrite;

//      Instr                   - it stores the instruciton opcode
//      RD1_Top                 - it stores the data of the first read value for the two port readable register file
//      Imm_top                 - 32 bit sign extended immediate value
//      ALUResult_Top           - stores the result of the ALU
//      ALUControl_Top          - generates the alu control signal , ouput form the control_top
//      ReadData                - stores the result form the data memory         
//      PCNEXT                  - stores the next program counter value
//      ImmSrc                  - control signal form the top control unit which is 1 for store type and 0 for load type instruction
//      MemWrite                - control signal form the top control unit model 
//      ALUSrc_Top              - generates a control signal for R type and I type instruction 
//module P_C(PC_NEXT,clk,rstn,PC);
P_C pc(.PC_NEXT(PCNEXT),.clk(clk),.rstn(rst),.PC(PC_Top));

//module PC_adder(a,b,c);
PC_adder PA(.a(PC_Top),.b(32'h00000004),.c(PCNEXT));



//module Instr_Mem(A,rst,RD)
Instr_Mem Im(.A(PC_Top),.rst(rst),.RD(Instr));


//module Reg_File(clk,RD1,RD2,WD3,WE3,rst, A1,A2,A3);
Reg_File rf(.clk(clk),
            .RD1(RD1_Top),
            .RD2(RD2_top),
            .WD3(RDMux),
            .WE3(RegWrite),
            .rst(rst),
            .A1(Instr[19:15]), //upcode 19-15 bits contains the memory location to read from
            .A2(Instr[24:20]),
            .A3(Instr[11:7])     //destinaiton of the register file to store the data           
                    
                    
                    );


//module sign_Extend(Instr_Rd,ImmExt,ImmSrc);
sign_Extend sE(.Instr_Rd(Instr) , 
                .ImmExt(Imm_top),
                .ImmSrc(ImmSrc));



//module alu(A,B,Result,ALUControl,Z,N,V,C);

alu a(.A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult_Top),
        .ALUControl(ALUControl_Top),
        .Z(Z),
        .N(N),
        .V(V),
        .C(C)
        );



// module control_top(Op,funct3,funct7,RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,ImmSrc,ALUControl);
control_top cTop(.Op(Instr[6:0]),
                .funct3(Instr[14:12]),
                .funct7(),
                .RegWrite(RegWrite),
                .ALUSrc(ALUSrc_Top),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrcTop),
                .Branch(),
                .ImmSrc(ImmSrc),
                .ALUControl(ALUControl_Top)  //takes the control signal form the module


);


//datamem - module Data_Mem (   A,    WE,    WD,    RD,    clk);
Data_Mem d(.A(ALUResult_Top),
        .WE(MemWrite),
        .WD(RD2_top),
        .RD(ReadData),
        .clk(clk)

);


//module Imm_RegMux(RD2,ImmExt,SrcB,ALUSrc)
Imm_RegMux imm(.RD2(RD2_top),.ImmExt(Imm_top),.SrcB(SrcB),.ALUSrc(ALUSrc_Top));



//module RD_WD3Mux(RD,ALUResult,ResultSrc,WD3)
RD_WD3Mux rd(.RD(ReadData),.ALUResult(ALUResult_Top),.ResultSrc(ResultSrcTop),.WD3(RDMux));

endmodule