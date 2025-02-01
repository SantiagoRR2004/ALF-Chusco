chusco:	chusco.tab.c chusco.lex.c
	gcc -o chusco chusco.tab.c lex.yy.c -lm
chusco.tab.c:	chusco.y
	bison -dv chusco.y
chusco.lex.c:	chusco.l
	flex chusco.l
clean:
	rm  chusco.tab.c chusco.tab.h chusco.output lex.yy.c chusco
test: chusco
	./chusco ChuscoPrograms/prueba.chu
test2: chusco
	./chusco ChuscoPrograms/prueba2.chu
test3: chusco
	./chusco ChuscoPrograms/prueba3.chu