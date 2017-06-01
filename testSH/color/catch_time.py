# -*-coding:utf-8-*-
from pyexcelerate import Workbook


def main():
    f = open('color20_to.log','r')
    out = open('format.txt', 'w')
    claspDsave = {}
    dlvSave = {}
    isClaspD = True
    vtxNum = 0
    testNum = 0
    for line in f.readlines():                          #依次读取每行
        line = line.strip()
        time = 0
        if not len(line) or line.startswith('#'):       #判断是否是空行或注释行
            continue                                    #是的话，跳过不处理
        if "colorfactclaspD" in line  :
            vtxNum, testNum = map(lambda x : int(x) ,((((line.split('.lp')[0]).split('D'))[1]).split('_')))
            print vtxNum, testNum
        if  "ClaspD cost" in line:
            time = float(line.split(" ")[2])
            print time
            if isClaspD:
                if not claspDsave.has_key(vtxNum):
                    claspDsave[vtxNum] = []
                claspDsave[vtxNum].append(time)
            else:
                if not dlvSave.has_key(vtxNum):
                    dlvSave[vtxNum] = []
                dlvSave[vtxNum].append(time)
            isClaspD = False
        if "colorfactDLV" in line :
            vtxNum, testNum = map(lambda x : int(x) ,((((line.split('.lp')[0]).split('V'))[1]).split('_')))
            print vtxNum, testNum
        if  "DLV cost" in line:
            time = float(line.split(" ")[2])
            print time
            if isClaspD:
                if not claspDsave.has_key(vtxNum):
                    claspDsave[vtxNum] = []
                claspDsave[vtxNum].append(time)
            else:
                if not dlvSave.has_key(vtxNum):
                    dlvSave[vtxNum] = []
                dlvSave[vtxNum].append(time)
            isClaspD = True
    print claspDsave
    print dlvSave
    wb = Workbook()
    ws = wb.new_sheet("result")
    ws.range("B1", "B2").merge()
    ws.range("C1", "D1").merge()
    ws.range("E1", "F1").merge()
    ws.range("G1", "H1").merge()
    ws.range("I1", "J1").merge()
    ws.range("K1", "L1").merge()
    ws[1][2].value = "n"
    ws[1][3].value = "实例一"
    ws[1][3].value = "实例二"
    ws[1][5].value = "实例三"
    ws[1][7].value = "实例四"
    ws[1][9].value = "实例五"
    ws[1][11].value = "实例六"
    ws[2][3].value = "t2lp+claspD"
    ws[2][4].value = "t2lp+dlv"
    ws[2][5].value = "t2lp+claspD"
    ws[2][6].value = "t2lp+dlv"
    ws[2][7].value = "t2lp+claspD"
    ws[2][8].value = "t2lp+dlv"
    ws[2][9].value = "t2lp+claspD"
    ws[2][10].value = "t2lp+dlv"
    ws[2][11].value = "t2lp+claspD"
    ws[2][12].value = "t2lp+dlv"



    out.writelines('n ||     实例１       ||     实例２       ||    实例３        ||  实例４          ||  实例５          ||\n')
    out.writelines('n ||claspD        dlv||claspD        dlv||claspD        dlv||claspD        dlv||claspD        dlv||\n')

    ws_line = 3
    for (k,v) in  claspDsave.items():
        out.write(str(k) + '|')
        ws[ws_line][2].value = k
        i = 0
        i2 = 0
        for v_ in v:
            out.write('|' + str(v_) + ' ' + str(dlvSave[k][i]) + '|')
            ws[ws_line][3+i2].value = v_
            ws[ws_line][4+i2].value = dlvSave[k][i]
            i = i + 1
            i2 = i2 + 2
        out.write('|\n')
        ws_line = ws_line + 1
    wb.save("outputcolor.xlsx")
    f.close()
    out.close()

if __name__ == '__main__':
    main()
