from __future__ import print_function
import os
import sys
import glob

        ########################################
        #####    method for print list    ######
        ########################################
def print_parsed_list(parsed_list):
    i = 0
    while i < 8:
        print(parsed_list[i], end='\t')
        i+=1
    print()

        ########################################
        #####   input file, output file   ######
        ########################################
input_filename= sys.argv[1]
output_filename= sys.argv[2]
# print("reading #", input_filename, "and writing #", output_filename)
f=open(input_filename, "r")
sys.stdout=open(output_filename, 'w')

        ########################################
        #####    declare data structure   ######
        ########################################
output_2d_list = [[0] * 1] #max_size = 100100
d = {'fetch':2, 'decode':3, 'issue':4, 'execute(start)':5, 'writeback':6, 'commit':7}


        ########################################
        #####       debug file read       ######
        ########################################

for line in f:
    line = line.rstrip('\n')
    splited_line = line.split('/')

    # line
    # 84000: system.cpu.fetch: 84000/1/fetch/ mov   fp, #0
    # spl[0]                        [1] [2]   [3]
    # spl[0] -> information including time
    # spl[1] -> sequence
    # spl[2] -> stage
    # spl[4] -> instruction
    
    seq = int(splited_line[1])
    # extend 2d_list if need
    if (seq >= len(output_2d_list)):
        output_2d_list.append([0] * 8)
    stage_index_in_2d = d[splited_line[2]]
    # 1. seq to 2d_list
    output_2d_list[seq][0] = seq

    # 2. tick to 2d_list
    # get tick time
    # info_spl = 84000: system.cpu.fetch: 84000
    #            [0]    [1]               [2]
    info_spl = splited_line[0].split(':')
    tick = int(info_spl[0])
    output_2d_list[seq][stage_index_in_2d] = tick

    # 3. instuction to 2d_list
    if len(splited_line) > 3:
        temp_inst = splited_line[3].split(' ')
        inst = temp_inst[2]
        output_2d_list[seq][1] = inst


        ########################################
        ###   check commit inst & print      ###
        ########################################

for index_row, row in enumerate(output_2d_list):
    for index_col, col in enumerate(row):
        if col == 0:
            break;
        if index_col == len(row) - 1:
            print_parsed_list(row)
            
