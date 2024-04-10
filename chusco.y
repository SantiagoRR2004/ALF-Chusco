 
%{

  #include <stdio.h>
  extern FILE *yyin;
  extern int yylex();

  #define YYDEBUG 1

%}

%token ABSTRACTO BOOLEANO BUCLE CARACTER CASOS CLASE COMO CONSTANTE CONSTRUCTOR CORTO
%token CUANDO DE DESCENDENTE DESTRUCTOR DEVOLVER DICCIONARIO EN ENTERO ENTONCES 
%token ENUMERACION ES ESPECIFICO EXCEPCION EXPORTAR FALSO FIN FINAL FINALMENTE GENERICO
%token IMPORTAR LARGO LANZA LIBRERIA LISTA MIENTRAS OBJETO OTRO PARA PRINCIPIO PRIVADO
%token PROGRAMA PROTEGIDO PRUEBA PUBLICO RANGO REAL REFERENCIA REGISTRO REPETIR SALIR
%token SI SIGNO SIGUIENTE SINO SUBPROGRAMA TABLA TIPO ULTIMA VALOR VERDADERO CTC_CARACTER
%token CTC_CADENA IDENTIFICADOR CTC_ENTERA CTC_REAL DOS_PUNTOS CUATRO_PUNTOS
%token ASIGNACION FLECHA INC DEC DESPI DESPD LEQ GEQ NEQ AND OR ASIG_SUMA ASIG_RESTA
%token ASIG_MULT ASIG_DIV ASIG_RESTO ASIG_POT ASIG_DESPI ASIG_DESPD


%left OR
%left AND
%nonassoc '~'
%nonassoc '<' '>' LEQ GEQ '=' NEQ
%left DESPI DESPD
%left '+' '-'
%left '*' '/' '%'
%right '^'
%nonassoc INC DEC
/* %nonassoc '-' */
/* Todavía no lo ponemos porque hay que crear un nuevo token */



%%

/************/
/* programa */
/************/

/*
programa :: = definicion_programa | definicion_libreria
definicion_programa ::= ’programa’ IDENTIFICADOR ’;’ codigo_programa
codigo_programa ::= [ libreria ]* cuerpo_subprograma
libreria ::= ’importar’ ’libreria’ nombre [ ’como’ IDENTIFICADOR ]? ’;’
| ’de’ ’libreria’ nombre ’importar’ ( IDENTIFICADOR )+ ’;’
*/

nombre : IDENTIFICADOR | nombre CUATRO_PUNTOS IDENTIFICADOR;

/*
definicion_libreria ::= ’libreria’ IDENTIFICADOR ’;’ codigo_libreria
codigo_libreria ::= [ libreria ]* [ exportaciones ]? [ declaracion ]+
exportaciones ::= ’exportar’ ( nombre )+ ’;’
declaracion ::= declaracion_objeto | declaracion_tipo | declaracion_subprograma
*/

/**************************/
/* declaracion de objetos */
/**************************/

/*
declaracion_objeto ::= ( IDENTIFICADOR )+ ’:’ ’constante’ especificacion_tipo ’:=’ expresion ’;’
| ( IDENTIFICADOR )+ ’:’ especificacion_tipo [ ’:=’ expresion ]? ’;’
especificacion_tipo ::= nombre | tipo_no_estructurado
*/

/************************/
/* declaracion de tipos */
/************************/

/*
declaracion_tipo ::= ’tipo’ IDENTIFICADOR ’es’ tipo_no_estructurado ’;’
| ’tipo’ IDENTIFICADOR ’es’ tipo_estructurado
tipo_no_estructurado ::= tipo_escalar | tipo_tabla | tipo_diccionario
tipo_escalar ::= [ ’signo’ ]? tipo_basico [ longitud ]? [ ’rango’ rango ]?
longitud ::= ’corto’ | ’largo’
tipo_basico ::= ’booleano’ | ’caracter’ | ’entero’ | ’real’
rango ::= expresion ’..’ expresion [ ’..’ expresion ]?
tipo_tabla ::= ’tabla’ ’(’ expresion ’..’ expresion ’)’ ’de’ especificacion_tipo
| ’lista’ ’de’ especificacion_tipo
tipo_diccionario ::= ’diccionario’ ’de’ especificacion_tipo
tipo_estructurado ::= tipo_registro | tipo_enumerado | clase
tipo_registro ::= ’registro’ [ campo ]+ ’fin’ ’registro’
campo ::= ( IDENTIFICADOR )+ ’:’ especificacion_tipo
[ ’:= expresion ]? ’;’
tipo_enumerado ::= ’enumeracion’ [ ’de’ tipo_escalar ]? ( elemento_enumeracion )+
’fin’ ’enumeracion’
elemento_enumeracion ::= IDENTIFICADOR [ ’:=’ expresion ]?
*/

/*************************/
/* declaracion de clases */
/*************************/

/*
clase ::= ’clase’ [ ’ultima’ ]? [ superclases ]? [ declaracion_componente ]+ ’fin’ ’clase’
superclases ::= ’(’ ( nombre )+ ’)’
declaracion_componente ::= [ visibilidad ]? componente
visibilidad ::= ’publico’ | ’protegido’ | ’privado’
componente ::= declaracion_tipo
| declaracion_objeto
| ( modificador )* declaracion_subprograma
modificador ::= ’constructor’ | ’destructor’ | ’generico’ | ’abstracto’ | ’especifico’ | ’final’
*/

/*******************************/
/* declaracion de subprogramas */
/*******************************/

/*
declaracion_subprograma ::= ’subprograma’ cabecera_subprograma cuerpo_subprograma ’subprograma’
cabecera_subprograma ::= IDENTIFICADOR [ parametrizacion ]? [ tipo_resultado ]?
parametrizacion ::= ’(’ [ declaracion_parametros ’;’ ]* declaracion_parametros ’)’
declaracion_parametros ::= ( IDENTIFICADOR )+ ’:’ [ modo ]? especificacion_tipo [ ’:=’ expresion ]?
modo ::= ’valor’ | ’referencia’
tipo_resultado ::= ’devolver’ especificacion_tipo
cuerpo_subprograma ::= [ declaracion ]* ’principio’ [ instruccion ]+ ’fin’
*/

/*****************/
/* instrucciones */
/*****************/

/*
instruccion ::= instruccion_asignacion
| instruccion_devolver
| instruccion_llamada
| instruccion_si
| instruccion_casos
| instruccion_bucle
| instruccion_interrupcion
| instruccion_lanzamiento_excepcion
| instruccion_captura_excepcion
| ’;’
instruccion_asignacion ::= objeto op_asignacion expresion ’;’
op_asignacion ::= ’:=’ | ’:+’ | ’:-’ | ’:*’ | ’:/’ | ’:\’ | ’:^’ | ’:<’ | ’:>’
instruccion_devolver ::= ’devolver’ [ expresion ]? ’;’
18instruccion_llamada ::= llamada_subprograma ’;’
llamada_subprograma ::= nombre ’(’ ( definicion_parametro )* ’)’
definicion_parametro ::= [ IDENTIFICADOR ’:=’ ]? expresion
instruccion_si ::= ’si’ expresion ’entonces’ [ instruccion ]+
[ ’sino’ [ instruccion ]+ ]? ’fin’ ’si’
instruccion_casos ::= ’casos’ expresion ’es’ [ caso ]+ ’fin’ ’casos’
caso ::= ’cuando’ entradas ’=>’ [ instruccion ]+
entradas ::= [ entrada ’:’ ]* entrada
entrada ::= expresion [ ’..’ expresion ]? | ’otro’
instruccion_bucle ::= [ IDENTIFICADOR ’:’ ]? clausula_iteracion [ instruccion ]+ ’fin’ ’bucle’
clausula_iteracion ::= ’para’ IDENTIFICADOR [ ’:’ especificacion_tipo ]? ’en’ expresion
| ’repetir’ IDENTIFICADOR [ ’:’ especificacion_tipo ]?
’en’ rango [ ’descendente’ ]?
| ’mientras’ expresion
instruccion_interrupcion ::= ’siguiente’ [ cuando ]? ’;’
| ’salir’ [ ’de’ IDENTIFICADOR ]? [ cuando ]? ’;’
cuando ::= ’cuando’ expresion
instruccion_lanzamiento_excepcion ::= ’lanza’ nombre ’;’
instruccion_captura_excepcion ::= ’prueba’ [ instruccion ]+ clausulas ’fin’ ’prueba’
clausulas ::= clausulas_excepcion [ clausula_finalmente ]?
| clausula_finalmente
clausulas_excepcion ::= [ clausula_excepcion_especifica ]* clausula_excepcion_general
clausula_excepcion_especifica ::= ’excepcion’ ’(’ nombre ’)’ [ instruccion ]+
clausula_excepcion_general ::= ’excepcion’ [ instruccion ]+
clausula_finalmente ::= ’finalmente’ [ instruccion ]+
*/

/***************/
/* expresiones */
/***************/

/* Esto lo pusimos nosotros */
/* Hay que revisar que sea correcto */
expresion: expresion_condicional;

/*
expresion_potencia ::= expresion_posfija [ ’^’ expresion_potencia ]? */

/*
expresion_posfija ::= expresion_unaria [ operador_posfijo ]? */

operador_posfijo : INC | DEC;

/*
expresion_unaria ::= [ ’-’ ]? primario */

/*
primario ::= literal
| objeto
| [ ’objeto’ ]? llamada_subprograma
| enumeraciones
| ’(’ expresion ’)’
*/


literal : VERDADERO | FALSO | CTC_ENTERA | CTC_REAL | CTC_CARACTER | CTC_CADENA;

objeto: nombre
      | objeto '.' IDENTIFICADOR
      | objeto '[' expresion ']'
      | objeto '{' CTC_CADENA '}';


/*
enumeraciones ::= ’[’ expresion_condicional [ clausula_iteracion ]+ ’]’
| ’[’ ( expresion )+ ’]’
| ’{’ ( clave_valor )+ ’}’
| ’{’ ( campo_valor )+ ’}’  */ 


expresion_condicional : expresion
                       | SI expresion ENTONCES expresion 
                       | SI expresion ENTONCES expresion SINO expresion;

clave_valor : CTC_CADENA FLECHA expresion;

campo_valor : IDENTIFICADOR FLECHA expresion;


%%

int yyerror(char *s) {
  fflush(stdout);
  printf("***************** %s\n",s);
  }

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  yydebug = 0;

  if (argc < 2) {
    printf("Uso: ./chusco NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    yyparse();
    }
  }
