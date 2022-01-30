# Filename:         assembler.py
# Author:           DTW
# Date:             1/30/2022
# Description:      This module takes a text file input, parses it, and outputs 
#                   the 32b machine codes for each instruction.

#=========================================================================================

# Variable Definitions
zero = '00000'
at = '00001'
v0 = '00010'; v1 = '00011'
a0 = '00100'; a1 = '00101'; a2 = '00110'; a3 = '00111'
t0 = '01000'; t1 = '01001'; t2 = '01010'; t3 = '01011'; t4 = '01100'; t5 = '01101'; t6 = '01110'; t7 = '01111'; t8 = '11000'; t9 = '11001'
s0 = '10000'; s1 = '10001'; s2 = '10010'; s3 = '10011'; s4 = '10100'; s5 = '10101'; s6 = '10110'; s7 = '10111'
k0 = '11010'; k1 = '11011'
gp = '11100'
sp = '11101'
fp = '11110'
ra = '11111'




# Read in assembly 
file_r = open("test.txt", "r")
content = file_r.readlines()
print(content)

# Open new File to write
file_w = open('output.txt', 'w')
file_w.write("Machine Code Output\n")
file_w.write("DTW\n\n")


# Split up assembly into individual instructions 
instructions = []

for line in content:
    instructions.append(line.split())

print(instructions)


# Determine how to parse based on instruction 
mem_count = 0
opcode = ''
funct = ''
rs = ''
rt = ''
rd = ''
shamt = ''
immediate = ''
address = ''

for inst in instructions:

    # Print SV code for memory initialization 
    file_w.write("instruction_mem[")
    file_w.write(str(mem_count*4))
    file_w.write("] = 32'b")

  
      
    # R Instructions
    if inst[0] == 'add' or inst[0] == 'sub' or inst[0] == 'and'  or inst[0] == 'or' or inst[0] == 'nor' or inst[0] == 'sll' or inst[0] == 'srl' or inst[0] == 'slt' or inst[0] == 'sltu':
        print('a')

    
    # I Instructions
    elif inst[0] == 'lw' or inst[0] == 'sw' or inst[0] == 'addi' or inst[0] == 'andi' or inst[0] == 'ori' or inst[0] == 'beq' or inst[0] == 'bne' or inst[0] == 'slti' or inst[0] == 'sltiu':
        print ('b')


    # J Instructions    
    elif inst[0] == 'j' or inst[0] == 'jal':
        print('c')
        mem_count = mem_count + 1
    

    # Default
    else:
        print("INSTRUCTION ERROR")
        print(inst)