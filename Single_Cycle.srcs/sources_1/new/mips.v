`timescale 1ns/1ns
module mips(clk,rst);
    input clk;//clock
    input rst;//reset
    
    wire [31:0] instr;
    
    //controller messages
    wire RegDst;
    wire ExtOp;
    wire ALUSrc;
    wire ALUctr;
    wire RegWr;
    wire DMWr;
    wire GPRSrc;
    wire [1:0] NPCSel;
    
    //instructions
    wire [5:0] op;
    wire [5:0] funct;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] imm_16;
    wire [25:0] imm_26;
    
    //gpr
    wire [4:0] dst;
    wire [31:0] in_data;
    wire [31:0] out_rs;
    wire [31:0] out_rt;
    
    //pc and npc
    wire [31:0] pcin;
    wire [31:0] pcout;
    
    //mux
        //wire [31:0] out_rt;
        //wire [31:0] ext_out;
        //wire ALUSrc;
    wire [31:0] mux_out_alu;
    wire [31:0] mux_out_gpr;
    
    //alu
        //wire [31:0] out_rs;
        //wire [31:0] mux_out;
        //wire ALUctr;
    wire [31:0] alu_out;
    wire beqout;
        
    //ext
        //wire ExtOp;
        //wire [15:0] imm_16;
    wire [31:0] ext_out;
    
    //dm_4k
    wire [31:0] dm_out;
    
    assign op=instr[31:26];
    assign rs=instr[25:21];
    assign rt=instr[20:16];
    assign rd=instr[15:11];
    assign funct=instr[5:0];
    assign imm_16=instr[15:0];
    assign imm_26=instr[25:0];
    
    im_4k U_im_4k(pcout[11:2],instr);
    
    dm_4k U_dm_4k(alu_out[9:0],out_rt,DMWr,clk,dm_out);
    
    gpr U_gpr(clk,rs,rt,rd,dst,RegWr,RegDst,mux_out_gpr,out_rs,out_rt);
    
    controller U_controller(op,funct,beqout,RegDst,ExtOp,ALUSrc,ALUctr,RegWr,DMWr,GPRSrc,NPCSel);
    
    pc U_pc(clk,rst,pcin,pcout);
    
    npc U_npc(imm_16,imm_26,pcout,pcin,NPCSel);
    
    mux U_mux_alu(out_rt,ext_out,ALUSrc,mux_out_alu);
    
    mux U_mux_gpr(dm_out,alu_out,GPRSrc,mux_out_gpr);
    
    alu U_alu(out_rs,mux_out_alu,ALUctr,alu_out,beqout);
    
    ext U_ext(ExtOp,imm_16,ext_out);
    
    
    //module im_4k(addr,dout);
    
    //module dm_4k(addr,din,we,clk,dout);
    
    //module gpr(clk,rs,rt,rd,dst,RegWr,RegDst,in_data,out_rs,out_rt);
    
    //module controller(op,funct,RegDst,ExtOp,ALUSrc,ALUctr,RegWr,DMWr,GPRSrc);
    
    //module pc(clk,rst,npc,pc);
    
    //module npc(pc,npc);
    
    //module mux(in1,in2,mux_sel,out);
    
    //module alu(in_data1,in_data2,ALUctr,out_data);
    
    //module ext(ExtOp,in_data,out_data);
endmodule