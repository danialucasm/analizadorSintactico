@echo off
flex lexico.l && bison -d parser.y -v && gcc lex.yy.c parser.tab.c -o ejecutable.exe  && ejecutable.exe ej.txt
PAUSE