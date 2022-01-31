# Filename:         assembler.py
# Author:           DTW
# Date:             1/30/2022
# Description:      This module takes a text file input, parses it, and outputs 
#                   the 32b machine codes for each instruction.

#=========================================================================================

# Variable Definitions
registers = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2', 't3', 't4', 't5', 't6', 't7', 's0','s1', 's2', 's3', 's4', 's5', 's6', 's7', 't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']
hex_code = ['00000', '00001', '00010', '00011', '00100', '00101', '00110', '00111', '01000', '01001', '01010', '01011', '01100', '01101', '01110', '01111', '10000', '10001', '10010', '10011', '10100', '10101', '10110', '10111', '11000', '11001', '11010', '11011', '11100', '11101', '11110', '11111']
r_inst = ['add', 'sub', 'and', 'or', 'nor', 'sll', 'srl', 'slt', 'slty']
r_hex_code = ['100000', '100010', '100100', '100101', '100111', '000000', '000010', '101010', '101011']
i_inst = ['lw', 'sw', 'addi', 'andi', 'ori', 'beq', 'bne', 'slti', 'sltiu']
i_hex_code = ['100011', '101011', '001000', '001100', '001101', '000100', '000101', '001010', '001011']


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
        print("R Instruction")
        opcode = '000000'
        rd = hex_code[registers.index(inst[1])]
        rs = hex_code[registers.index(inst[2])]
        funct = r_hex_code[r_inst.index(inst[0])]

        if inst[0] == 'sll' or inst[0] == 'srl':
            shamt = inst[3]
            rt = hex_code[0]
        else:
            rt = hex_code[registers.index(inst[3])]
            shamt = hex_code[0]
    

        # Write 32b to output file
        file_w.write(opcode + rs + rt + rd + shamt + funct + '\n')
        mem_count = mem_count + 1
        

    
    # I Instructions
    elif inst[0] == 'lw' or inst[0] == 'sw' or inst[0] == 'addi' or inst[0] == 'andi' or inst[0] == 'ori' or inst[0] == 'beq' or inst[0] == 'bne' or inst[0] == 'slti' or inst[0] == 'sltiu':
        print("I Instruction")

        opcode = i_hex_code[i_inst.index(inst[0])]
        rt = hex_code[registers.index(inst[1])]
        
        if inst[0] == 'lw' or inst[0] == 'sw':
            rs = hex_code[registers.index(inst[3])]
            immediate = inst[2]
        else:
            rs = hex_code[registers.index(inst[2])]
            immediate = inst[3]
        
        file_w.write(opcode + rs + rt + immediate + '\n')
        mem_count = mem_count + 1


    # J Instructions    
    elif inst[0] == 'j' or inst[0] == 'jal':
        address = inst[1]

        if inst[0] == 'j':
            opcode = '000010'
        else:
            opcode = '000011'

        file_w.write(opcode + address + '\n')
        mem_count = mem_count + 1
    

    # Default
    else:
        print("INSTRUCTION ERROR")
        print(inst)