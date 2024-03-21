/* ====================================================================================================================== */
/* Sección de declaraciones  */

/* ============================================================================================= */
/*  Código en C  */
%{
#include <stdio.h>
#include "chusco.h"

extern int yylineno;

void nl() {
  /* Imprime el número de línea */
    fprintf(yyout, "linea: %d ", yylineno);
}

%}
/* ============================================================================================= */
/*  Macros  */

IDENTIFICADOR  [A-Za-z_][A-Za-z_0-9]*

NDECIMAL        [0-9]
NOCTAL          [0-7]
NHEXADECIMAL    [0-9a-fA-F]

DECIMAL        {NDECIMAL}+
OCTAL          %(o|O){NOCTAL}+
HEXADECIMAL    %(x|X){NHEXADECIMAL}+

SP             [ \t]

/* ============================================================================================= */
/*  Condiciones de arranque  */

%x COM
%x CADENA

/* ============================================================================================= */
/*  Opciones  */

%option yylineno

%%  /* ====================================================================================================================== */
  /*  Sección de reglas y acciones  */

  /* ============================================================================================= */
  /*  Palabras reservadas  */

(?i:"abstracto")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ABSTRACTO;}
(?i:"booleano")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return BOOLEANO;}
(?i:"bucle")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return BUCLE;}
(?i:"caracter")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CARACTER;}
(?i:"casos")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CASOS;}
(?i:"clase")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CLASE;}
(?i:"como")                   {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return COMO;}
(?i:"constante")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CONSTANTE;}
(?i:"constructor")            {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CONSTRUCTOR;}
(?i:"corto")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CORTO;}
(?i:"cuando")                 {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return CUANDO;}
(?i:"de")                     {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return DE;}
(?i:"descendente")            {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return DESCENDENTE;}
(?i:"destructor")             {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return DESTRUCTOR;}
(?i:"devolver")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return DEVOLVER;}
(?i:"diccionario")            {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return DICCIONARIO;}
(?i:"en")                     {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return EN;}
(?i:"entero")                 {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ENTERO;}
(?i:"entonces")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ENTONCES;}
(?i:"enumeracion")            {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ENUMERACION;}
(?i:"es")                     {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ES;}
(?i:"especifico")             {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ESPECIFICO;}
(?i:"excepcion")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return EXCEPCION;}
(?i:"exportar")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return EXPORTAR;}
(?i:"falso")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return FALSO;}
(?i:"fin")                    {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return FIN;}
(?i:"final")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return FINAL;}
(?i:"finalmente")             {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return FINALMENTE;}
(?i:"generico")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return GENERICO;}
(?i:"importar")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return IMPORTAR;}
(?i:"largo")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return LARGO;}
(?i:"lanza")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return LANZA;}
(?i:"libreria")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return LIBRERIA;}
(?i:"lista")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return LISTA;}
(?i:"mientras")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return MIENTRAS;}
(?i:"objeto")                 {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return OBJETO;}
(?i:"otro")                   {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return OTRO;}
(?i:"para")                   {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PARA;}
(?i:"principio")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PRINCIPIO;}
(?i:"privado")                {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PRIVADO;}
(?i:"programa")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PROGRAMA;}
(?i:"protegido")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PROTEGIDO;}
(?i:"prueba")                 {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PRUEBA;}
(?i:"publico")                {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return PUBLICO;}
(?i:"rango")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return RANGO;}
(?i:"real")                   {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return REAL;}
(?i:"referencia")             {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return REFERENCIA;}
(?i:"registro")               {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return REGISTRO;}
(?i:"repetir")                {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return REPETIR;}
(?i:"salir")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return SALIR;}
(?i:"si")                     {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return SI;}
(?i:"signo")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return SIGNO;}
(?i:"siguiente")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return SIGUIENTE;}
(?i:"sino")                   {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return SINO;}
(?i:"subprograma")            {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return SUBPROGRAMA;}
(?i:"tabla")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return TABLA;}
(?i:"tipo")                   {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return TIPO;}
(?i:"ultima")                 {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return ULTIMA;}
(?i:"valor")                  {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return VALOR;}
(?i:"verdadero")              {nl(); fprintf(yyout, "palabra reservada: %s \n", yytext); return VERDADERO;}

  /* ============================================================================================= */
  /*  Identificadores  */

{IDENTIFICADOR}                   {nl(); fprintf(yyout, "identificador: %s \n", yytext); return IDENTIFICADOR;}

  /* ============================================================================================= */
  /*  Constantes  */

  /* =========================================================================== */
  /*  Constantes enteras  */

{DECIMAL}|{OCTAL}{HEXADECIMAL}     {nl(); fprintf(yyout, "ctc entera: %s \n", yytext); return CTC_ENTERA;}

  /* =========================================================================== */
  /*  Constantes reales  */

{DECIMAL}?"."{DECIMAL}          {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}
%(o|O)({NOCTAL}+)?"."{NOCTAL}+          {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}
%(x|X)({NHEXADECIMAL})?"."{NHEXADECIMAL}+          {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}

{DECIMAL}"^"("+"|"-")?{DECIMAL}                       {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}
{DECIMAL}?"."{DECIMAL}"^"("+"|"-")?{DECIMAL}          {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}

{OCTAL}"^"("+"|"-")?{NOCTAL}+                       {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}
%(o|O)({NOCTAL}+)?"."{NOCTAL}+"^"("+"|"-")?{NOCTAL}+          {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}

{HEXADECIMAL}"^"("+"|"-")?{NHEXADECIMAL}+                       {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}
%(x|X)({NHEXADECIMAL}+)?"."{NHEXADECIMAL}+"^"("+"|"-")?{NHEXADECIMAL}+          {nl(); fprintf(yyout, "ctc real: %s \n", yytext); return CTC_REAL;}

  /* =========================================================================== */
  /*  Caracteres  */

  /* =========================================================================== */
  /*  Cadenas  */

\"[^"]*\"                          {nl(); fprintf(yyout, "cadena: %s \n", yytext);}
  /* [^"]* hace que coja cualquier carácter a excepción de una comilla. */


  /* ============================================================================================= */
  /*  Delimitadores  */

"("             {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return (int)yytext[0];}
")"             {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return (int)yytext[0];}
":"             {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return (int)yytext[0];}
";"             {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return (int)yytext[0];}
","             {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return (int)yytext[0];}
".."            {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return DOS_PUNTOS;}
"|"             {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return (int)yytext[0];}
"=>"            {nl(); fprintf(yyout, "delimitador: %s \n", yytext); return FLECHA;}

  /* ============================================================================================= */
  /*  Operadores  */

  /* ============================================================================================= */
  /*  Comentarios  */

{SP}*"#{"                          BEGIN COM;
<COM>.|\n                          ;
<COM>"#{"({SP}*\n)*                BEGIN 0;

^{SP}*"##".*\n                     ;
{SP}*"##".*                        ;

  /* ============================================================================================= */
  /*  Errores  */

\n                                 ;
.                                  ;


%%  /* ====================================================================================================================== */
/*  Sección de rutinas de usuario  */

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  if (argc < 2) {
    printf("Uso: ./chusco NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    if (argc>2){
    	yyout=fopen(argv[2],"w");
    }
    while (yylex());

    fclose(yyin);
    if (argc>2){
      fclose(yyout);
    }
    }
  }
