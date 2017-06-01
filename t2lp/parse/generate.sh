#!/bin/bash
lexFile="sm_lex.l"
parseFile="sm_parse.y"
# 生成cpp文件
lex -o ../src/lex.cpp $lexFile
yacc --defines=../include/parse.h -o ../src/parse.cpp $parseFile
exit 0
