onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate /tb_MIPS/DUT/clk
add wave -noupdate /tb_MIPS/DUT/resetN
add wave -noupdate -divider PC
add wave -noupdate /tb_MIPS/DUT/PC
add wave -noupdate /tb_MIPS/DUT/PC_4
add wave -noupdate /tb_MIPS/DUT/PC_4_branch
add wave -noupdate /tb_MIPS/DUT/PC_branch
add wave -noupdate /tb_MIPS/DUT/b_and_z
add wave -noupdate /tb_MIPS/DUT/PC_jump
add wave -noupdate /tb_MIPS/DUT/PC_next
add wave -noupdate -divider Instruction
add wave -noupdate /tb_MIPS/DUT/instruction
add wave -noupdate /tb_MIPS/DUT/imdtVal
add wave -noupdate -divider Registers
add wave -noupdate /tb_MIPS/DUT/rdReg1
add wave -noupdate /tb_MIPS/DUT/rdReg2
add wave -noupdate /tb_MIPS/DUT/wrReg
add wave -noupdate /tb_MIPS/DUT/regData1
add wave -noupdate /tb_MIPS/DUT/regData2
add wave -noupdate /tb_MIPS/DUT/regWriteData
add wave -noupdate -divider ALU
add wave -noupdate /tb_MIPS/DUT/ALUCtl
add wave -noupdate /tb_MIPS/DUT/funct
add wave -noupdate /tb_MIPS/DUT/operand_A
add wave -noupdate /tb_MIPS/DUT/operand_B
add wave -noupdate /tb_MIPS/DUT/ALU_Out
add wave -noupdate /tb_MIPS/DUT/zero
add wave -noupdate -divider Control
add wave -noupdate /tb_MIPS/DUT/opCode
add wave -noupdate /tb_MIPS/DUT/RegDst
add wave -noupdate /tb_MIPS/DUT/Jump
add wave -noupdate /tb_MIPS/DUT/Branch
add wave -noupdate /tb_MIPS/DUT/MemRead
add wave -noupdate /tb_MIPS/DUT/MemtoReg
add wave -noupdate /tb_MIPS/DUT/ALUOp
add wave -noupdate /tb_MIPS/DUT/MemWrite
add wave -noupdate /tb_MIPS/DUT/ALUSrc
add wave -noupdate /tb_MIPS/DUT/RegWrite
add wave -noupdate -divider {Data Memory}
add wave -noupdate /tb_MIPS/DUT/dMem_addr
add wave -noupdate /tb_MIPS/DUT/dMem_wrData
add wave -noupdate /tb_MIPS/DUT/dMem_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {36 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 331
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {156 ns}
