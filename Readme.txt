2018年12月1日完成
仿照学长单周期示例完成两条指令：add,ori
还未仿真

2018年12月2日修改
增加仿真testbench.v模块，加入ori测试用指令code.txt，部分完成ori指令的测试
1、遇到问题：没有指令来源	解决方案：加入im例化模块解决
2、疑问：课本上介绍的补码存储方式在电路设计当中没有体现，是否的综合的过程中自动生成或者有待后续电路设计实现

2018年12月10日修改
增加cal_data寄存器初始化值模块，增加测试文档记录本次测试经过。确认ori指令已经实现。

2019年2月10日修改
测试add指令，确认add指令已经实现。发现RTL仿真方法中可以显示顶层架构图。

2019年2月24日修改
加入lw与sw两条指令，测试lw指令。

2019年2月25日修改
尝试加入j与beq两条指令，已修改alu与controller模块与其余模块部分代码。

2019年2月26日修改
加入j与beq两条指令，完成j指令的测试，由于时间问题，不再测试beq指令。现阶段代码完成，开始准备流水线的设计。
