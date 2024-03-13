%{
#include <stdio.h>
#include "chusco.h"

int num_lineas = 0;
%}

%x COM
%x CADENA

SP             [ \t]
IDENTIFICADOR  [A-Za-z_][A-Za-z_0-9]*

%%

{IDENTIFICADOR}                    fprintf(yyout, "linea: %d identificador: %s \n", num_lineas, yytext);
\"[^"]*\"                          fprintf(yyout, "linea: %d cadena: %s \n", num_lineas, yytext); /* [^"]* hace que coja cualquier carácter a excepción de una comilla. */

{SP}*"#{"                          BEGIN COM;
<COM>.|\n                          ;
<COM>"#{"({SP}*\n)*                BEGIN 0;

^{SP}*"##".*\n                     ;
{SP}*"##".*                        ;

\n                                 ++num_lineas;
.                                  ;

%%

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  if (argc < 2) {
    printf("Uso: ./chusco NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    yyout = fopen(argv[2], "w");
    while (yylex());

    fclose(yyin);
    fclose(yyout);
    }
  }
