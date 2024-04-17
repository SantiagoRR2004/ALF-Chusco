 
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


programa : definicion_programa | definicion_libreria;

definicion_programa : PROGRAMA IDENTIFICADOR ';' codigo_programa;

libreriaM : libreria libreriaM
          | libreria ;

codigo_programa : libreriaM cuerpo_subprograma
          | cuerpo_subprograma ;


identificadorCM : IDENTIFICADOR ',' identificadorCM
          | IDENTIFICADOR;

libreria : IMPORTAR LIBRERIA nombre COMO IDENTIFICADOR ';'
          | IMPORTAR LIBRERIA nombre ';'
          | DE LIBRERIA nombre IMPORTAR identificadorCM ';' ;

nombre : IDENTIFICADOR | nombre CUATRO_PUNTOS IDENTIFICADOR;

/*
definicion_libreria : LIBRERIA IDENTIFICADOR ';' codigo_libreria ;

declaracionM : declaracion declaracionM
        | declaracion;

codigo_libreria : [ libreria ]* [ exportaciones ]? declaracionM ;

exportaciones : ’exportar’ ( nombre )+ ';' ;

declaracion : declaracion_objeto | declaracion_tipo | declaracion_subprograma ;

*/

/**************************/
/* declaracion de objetos */
/**************************/

/*
declaracion_objeto : ( IDENTIFICADOR )+ ':' ’constante’ especificacion_tipo ASIGNACION expresion ';'
| ( IDENTIFICADOR )+ ':' especificacion_tipo [ ASIGNACION expresion ]? ';' */

especificacion_tipo : nombre | tipo_no_estructurado;


/************************/
/* declaracion de tipos */
/************************/

/*
declaracion_tipo : ’tipo’ IDENTIFICADOR ES tipo_no_estructurado ';'
| ’tipo’ IDENTIFICADOR ES tipo_estructurado */


tipo_no_estructurado : tipo_escalar | tipo_tabla | tipo_diccionario;

tipo_escalar : SIGNO tipo_basico longitud RANGO rango
              | SIGNO tipo_basico longitud
              | SIGNO tipo_basico RANGO rango
              | tipo_basico longitud RANGO rango
              | SIGNO tipo_basico
              | tipo_basico longitud
              | tipo_basico RANGO rango
              | tipo_basico;



longitud : CORTO | LARGO;

tipo_basico : BOOLEANO | CARACTER | ENTERO | REAL;

rango : expresion DOS_PUNTOS expresion DOS_PUNTOS expresion
            | expresion DOS_PUNTOS expresion;

tipo_tabla : TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo
| LISTA DE especificacion_tipo;

tipo_diccionario : DICCIONARIO DE especificacion_tipo;

/*
tipo_estructurado : tipo_registro | tipo_enumerado | clase;
*/

/*
tipo_registro : REGISTRO campoM FIN REGISTRO;

campoM : campo campoM
      | campo;

campo : ( IDENTIFICADOR )+ ':' especificacion_tipo
[ ASIGNACION expresion ]? ';';

tipo_enumerado : ENUMERACION [ DE tipo_escalar ]? ( elemento_enumeracion )+ FIN ENUMERACION;

elemento_enumeracion : IDENTIFICADOR [ ASIGNACION expresion ]?;
*/


/*************************/
/* declaracion de clases */
/*************************/

/*
clase : ’clase’ [ ’ultima’ ]? [ superclases ]? [ declaracion_componente ]+ FIN ’clase’
superclases : '(' ( nombre )+ ')'
declaracion_componente : [ visibilidad ]? componente
visibilidad : ’publico’ | ’protegido’ | ’privado’
componente : declaracion_tipo
| declaracion_objeto
| ( modificador )* declaracion_subprograma
modificador : ’constructor’ | ’destructor’ | ’generico’ | ABSTRACTO | ’especifico’ | ’final’
*/

/*******************************/
/* declaracion de subprogramas */
/*******************************/

/*
declaracion_subprograma : ’subprograma’ cabecera_subprograma cuerpo_subprograma ’subprograma’
cabecera_subprograma : IDENTIFICADOR [ parametrizacion ]? [ tipo_resultado ]?
parametrizacion : '(' [ declaracion_parametros ';' ]* declaracion_parametros ')'
declaracion_parametros : ( IDENTIFICADOR )+ ':' [ modo ]? especificacion_tipo [ ASIGNACION expresion ]?
modo : ’valor’ | ’referencia’
tipo_resultado : DEVOLVER especificacion_tipo

cuerpo_subprograma : [ declaracion ]* PRINCIPIO instruccionM FIN
*/

/*****************/
/* instrucciones */
/*****************/


instruccion : instruccion_asignacion
            | instruccion_devolver
            | instruccion_llamada
            | instruccion_si
            | instruccion_casos
            | instruccion_bucle
            | instruccion_interrupcion
            | instruccion_lanzamiento_excepcion
            | instruccion_captura_excepcion
            | ';';

instruccion_asignacion : objeto op_asignacion expresion ';';

op_asignacion : ASIGNACION | ASIG_SUMA | ASIG_RESTA | ASIG_MULT | ASIG_DIV | ASIG_RESTO | ASIG_POT | ASIG_DESPI | ASIG_DESPD;

instruccion_devolver : DEVOLVER expresion ';'
          | DEVOLVER ';';

instruccion_llamada : llamada_subprograma ';';

llamada_subprograma : nombre '(' definicion_parametroCM ')'
                    |nombre '(' ')';

definicion_parametroCM : definicion_parametro ',' definicion_parametroCM
                      | definicion_parametro;

definicion_parametro : IDENTIFICADOR ASIGNACION expresion
            | expresion;

instruccion_si : SI expresion ENTONCES instruccionM SINO instruccionM FIN SI
      | SI expresion ENTONCES instruccionM FIN SI;

instruccion_casos : CASOS expresion ES casoM FIN CASOS;

casoM : caso casoM
      | caso;

caso : CUANDO entradas FLECHA instruccionM;

entradas : entradaM entrada;

entradaM : entrada ':' entradaM
          |;

entrada : expresion DOS_PUNTOS expresion 
          | expresion
          | OTRO;

instruccion_bucle : IDENTIFICADOR ':' clausula_iteracion instruccionM FIN BUCLE
          |clausula_iteracion instruccionM FIN BUCLE;


clausula_iteracion : PARA IDENTIFICADOR ':' especificacion_tipo  EN expresion
              | PARA IDENTIFICADOR EN expresion
              | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO DESCENDENTE
              | REPETIR IDENTIFICADOR EN RANGO DESCENDENTE
              | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO
              | REPETIR IDENTIFICADOR EN RANGO 
              | MIENTRAS expresion;



instruccion_interrupcion : SIGUIENTE cuando ';'
          | SIGUIENTE ';'
          | SALIR DE IDENTIFICADOR cuando ';'
          | SALIR DE IDENTIFICADOR ';'
          | SALIR cuando ';'
          | SALIR ';';


cuando : CUANDO expresion;

instruccion_lanzamiento_excepcion : LANZA nombre ';';

instruccion_captura_excepcion : PRUEBA instruccionM clausulas FIN PRUEBA;

clausulas : clausulas_excepcion clausula_finalmente
              | clausulas_excepcion
              | clausula_finalmente;

clausulas_excepcion : clausula_excepcion_especificaM clausula_excepcion_general;

clausula_excepcion_especificaM : clausula_excepcion_especifica clausula_excepcion_especificaM
              | ;

clausula_excepcion_especifica : EXCEPCION '(' nombre ')' instruccionM;

clausula_excepcion_general : EXCEPCION instruccionM;

instruccionM : instruccion instruccionM
            | instruccion;

clausula_finalmente : FINALMENTE instruccionM;


/***************/
/* expresiones */
/***************/

/* Esto lo pusimos nosotros */
/* Hay que revisar que sea correcto */
expresion: expresion_condicional;


expresion_potencia : expresion_posfija '^' expresion_potencia 
                | expresion_posfija;

expresion_posfija : expresion_unaria operador_posfijo | expresion_unaria;

operador_posfijo : INC | DEC;


expresion_unaria : primario
          | '-' primario;


primario : literal
          | objeto
          | OBJETO llamada_subprograma
          | llamada_subprograma
          | enumeraciones
          | '(' expresion ')';



literal : VERDADERO | FALSO | CTC_ENTERA | CTC_REAL | CTC_CARACTER | CTC_CADENA;

objeto: nombre
      | objeto '.' IDENTIFICADOR
      | objeto '[' expresion ']'
      | objeto '{' CTC_CADENA '}';


clausula_iteracionM : clausula_iteracion clausula_iteracionM
                    | clausula_iteracion;

expresionCM : expresion ',' expresionCM
            | expresion;


clave_valorCM : clave_valor ',' clave_valorCM
              | clave_valor;

campo_valorCM : campo_valor ',' campo_valorCM
              | campo_valor;


enumeraciones : '[' expresion_condicional clausula_iteracionM ']'
              | '[' expresionCM ']'
              | '{' clave_valorCM '}'
              | '{' campo_valorCM '}';


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
