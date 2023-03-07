import os
import sys
import glob

#/commit/을 쭉 search하면서 번호 찾는다.
#번호에 따라서 시점 출력

input_filename= sys.argv[1]
output_filename= sys.argv[2]
f=open(input_filename, "r")
sys.stdout=open(output_filename, 'w')
commit_ins=[] #commit된 instruction들의 번호를 모아놓은 배열.
while True:
    line=f.readline()
    if not line : break
    if "/commit" in line:
        checker=0
        start=0
        end=0
        for i in range(len(line)):
            if line[i]=="/" and checker==0:
                start=i+1
                checker=1
            elif line[i]=="/" and checker==1:
                end=i
        commit_ins.append(line[start:end])
f.close()

result=[['' for col in range(8)] for row in range(len(commit_ins))]
for i in range(len(result)):
    result[i][0]=commit_ins[i] #sequence number
    f=open(input_filename, "r")
    restart=0
    while True:
        line=f.readline()
        if not line : break
        checker=0 #checker은 처음인지 체크하기 위한 인자임. start_i는 i번째 요소에 대한 시작위치임.
        start_3=0
        end_3=0
        start_4=0
        end_4=0
        start_5=0
        end_5=0
        start_6=0
        end_6=0
        start_7=0
        end_7=0
        if ("/"+result[i][0]+"/fetch/") in line:
            start=0
            end=0
            start_1=0
            end_1=0
            start_2=0
            end_2=0
            
            for j in range(len(line)):
                if line[j]!=" " and checker==0:
                    start_2=j
                    checker=1
                elif line[j]==":" :
                    end_2=j
                    break
            result[i][2]=line[start_2:end_2] #fetch 시점
            
            checker=0        
            for j in range(len(line)):
                if line[j]=="/" and checker==0:
                    start=j+1
                    checker=1
                elif line[j]=="/" and checker==1:
                    end=j
                    break
            start_1=end+9 #/ 이후 fetch/  ~까지가 9개임.
            end_1=0
            for j in range(len(line)-start_1-1):
                if line[start_1+j]==" ":
                    end_1=start_1+j
                    break
            result[i][1]=line[start_1:end_1] #operation 종류

        elif ("/"+result[i][0]+"/decode") in line:
            checker=0
            for j in range(len(line)):
                if line[j]!=" " and checker==0:
                    start_3=j
                    checker=1
                elif line[j]==":":
                    end_3=j
                    break
            result[i][3]=line[start_3:end_3] #decode 시점

        elif ("/"+result[i][0]+"/issue") in line:
            checker=0
            for j in range(len(line)):
                if line[j]!=" " and checker==0:
                    start_4=j
                    checker=1
                elif line[j]==":":
                    end_4=j
                    break
            result[i][4]=line[start_4:end_4] #issue 시점

        elif ("/"+result[i][0]+"/execute(start)") in line:
            checker=0
            for j in range(len(line)):
                if line[j]!=" " and checker==0:
                    start_5=j
                    checker=1
                elif line[j]==":":
                    end_5=j
                    break
            result[i][5]=line[start_5:end_5] #execute(start) 시점

        elif ("/"+result[i][0]+"/writeback") in line:
            checker=0
            for j in range(len(line)):
                if line[j]!=" " and checker==0:
                    start_6=j
                    checker=1
                elif line[j]==":":
                    end_6=j
                    break
            result[i][6]=line[start_6:end_6] #writeback 시점

        elif ("/"+result[i][0]+"/commit") in line:
            checker=0
            for j in range(len(line)):
                if line[j]!=" " and checker==0:
                    start_7=j
                    checker=1
                elif line[j]==":":
                    end_7=j
                    break
            result[i][7]=line[start_7:end_7] #commit 시점
            restart=1
            
        elif restart==1:
            break
            
    f.close()

for i in range(len(result)):
    print(result[i][0]+'\t'+result[i][1]+'\t'+result[i][2]+'\t'+result[i][3]+'\t'+result[i][4]+'\t'+result[i][5]+'\t'+result[i][6]+'\t'+result[i][7])
sys.stdout.close()
