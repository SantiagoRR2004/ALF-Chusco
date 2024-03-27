chusco:	chusco.lex.c
	gcc -o chusco lex.yy.c
chusco.lex.c:	chusco.l
	flex chusco.l
clean:
	rm  lex.yy.c chusco
test: chusco
	./chusco prueba.chu
test2: chusco
	./chusco prueba2.chu
test3: chusco
	./chusco prueba3.chu