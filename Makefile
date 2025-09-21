run.exe: ask_1.l ask_1.y
	bison -d ask.y
	flex ask_1.l
	gcc lex.yy.c ask_1.tab.c -o myParser
