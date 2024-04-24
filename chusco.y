 
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


programa : definicion_programa                                                   {printf("programa -> definicion_programa\n");}
      | definicion_libreria                                                      {printf("programa -> definicion_libreria\n");}
      ;

definicion_programa
      : PROGRAMA IDENTIFICADOR ';' codigo_programa                               {printf("definicion_programa -> PROGRAMA ID; codigo_programa\n");}
      ;

libreriaM : libreria libreriaM                                                   {printf("libreriaM -> libreria libreriaM\n");}
      | libreria                                                                 {printf("libreriaM -> libreria\n");}
      ;

codigo_programa 
      : libreriaM cuerpo_subprograma                                             {printf("codigo_programa -> libreriaM cuerpo_subprograma\n");}
      | cuerpo_subprograma                                                       {printf("codigo_programa -> cuerpo_subprograma\n");}
      ;


identificadorCM : IDENTIFICADOR ',' identificadorCM                              {printf("identificadorCM -> ID, identificadorCM\n");}
      | IDENTIFICADOR                                                            {printf("identificadorCM -> ID\n");}
      ;

libreria 
      : IMPORTAR LIBRERIA nombre COMO IDENTIFICADOR ';'                          {printf("libreria -> IMPORTAR LIBRERIA nombre COMO ID;\n");}
      | IMPORTAR LIBRERIA nombre ';'                                             {printf("libreria -> IMPORTAR LIBRERIA nombre;\n");}
      | DE LIBRERIA nombre IMPORTAR identificadorCM ';'                          {printf("libreria -> DE LIBRERIA nombre IMPORTAR identificadorCM;\n");}
      ;


nombre : IDENTIFICADOR                                                           {printf("nombre -> ID\n");}
       | nombre CUATRO_PUNTOS IDENTIFICADOR                                      {printf("nombre -> nombre :: ID\n");}
       ;

definicion_libreria 
      : LIBRERIA IDENTIFICADOR ';' codigo_libreria                               {printf("definicion_libreria -> LIBRERIA ID; codigo_libreria\n");}
      ;

declaracionM : declaracion declaracionM                                          {printf("declaracionM -> declaracion declaracionM\n");}
      | declaracion                                                              {printf("declaracionM -> declaracion\n");}
      ;

codigo_libreria 
      : libreriaM exportaciones declaracionM                                     {printf("codigo_libreria -> libreriaM exportaciones declaracionM\n");}
      |libreriaM declaracionM                                                    {printf("codigo_libreria -> libreriaM declaracionM\n");}
      |exportaciones declaracionM                                                {printf("codigo_libreria -> exportaciones declaracionM\n");}
      |declaracionM                                                              {printf("codigo_libreria -> declaracionM\n");}
      ;

exportaciones : EXPORTAR nombreCM ';'                                            {printf("exportaciones -> EXPORTAR nombreCM;\n");}
      ;

nombreCM : nombre ',' nombreCM                                                   {printf("nombreCM -> nombre, nombreCM\n");}
      | nombre                                                                   {printf("nombreCM -> nombre\n");}
      ;

declaracion : declaracion_objeto                                                 {printf("declaracion -> declaracion_objeto\n");}           
      | declaracion_tipo                                                         {printf("declaracion -> declaracion_tipo\n");} 
      | declaracion_subprograma                                                  {printf("declaracion -> declaracion_subprograma\n");}
      ;


/**************************/
/* declaracion de objetos */
/**************************/


declaracion_objeto 
      :identificadorCM ':' CONSTANTE especificacion_tipo ASIGNACION expresion ';'
      |identificadorCM ':' especificacion_tipo ASIGNACION expresion ';'
      |identificadorCM ':' especificacion_tipo ';' ;

especificacion_tipo : nombre 
      | tipo_no_estructurado;


/************************/
/* declaracion de tipos */
/************************/


declaracion_tipo 
      : TIPO IDENTIFICADOR ES tipo_no_estructurado ';'
      | TIPO IDENTIFICADOR ES tipo_estructurado
      ;


tipo_no_estructurado : tipo_escalar 
      | tipo_tabla 
      | tipo_diccionario
      ;

tipo_escalar 
      : SIGNO tipo_basico longitud RANGO rango
      | SIGNO tipo_basico longitud
      | SIGNO tipo_basico RANGO rango
      | tipo_basico longitud RANGO rango
      | SIGNO tipo_basico
      | tipo_basico longitud
      | tipo_basico RANGO rango
      | tipo_basico
      ;


longitud : CORTO 
      | LARGO
      ;

tipo_basico : BOOLEANO 
      | CARACTER 
      | ENTERO 
      | REAL
      ;

rango 
      : expresion DOS_PUNTOS expresion DOS_PUNTOS expresion
      | expresion DOS_PUNTOS expresion
      ;

tipo_tabla 
      : TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo
      | LISTA DE especificacion_tipo
      ;

tipo_diccionario : DICCIONARIO DE especificacion_tipo
;

tipo_estructurado : tipo_registro 
      | tipo_enumerado 
      | clase
      ;

tipo_registro : REGISTRO campoM FIN REGISTRO
      ;

campoM : campo campoM
      | campo
      ;

campo : identificadorCM ':' especificacion_tipo ASIGNACION expresion ';'
      | identificadorCM ':' especificacion_tipo ';'
      ;

tipo_enumerado 
      : ENUMERACION DE tipo_escalar elemento_enumeracionCM FIN ENUMERACION;
      |ENUMERACION elemento_enumeracionCM FIN ENUMERACION
      ;

elemento_enumeracionCM 
      : elemento_enumeracion ',' elemento_enumeracionCM
      | elemento_enumeracion
      ;

elemento_enumeracion 
      : IDENTIFICADOR ASIGNACION expresion
      | IDENTIFICADOR
      ;

/*************************/
/* declaracion de clases */
/*************************/

clase : CLASE ULTIMA superclases declaracion_componenteM FIN CLASE
      |CLASE ULTIMA declaracion_componenteM FIN CLASE
      |CLASE superclases declaracion_componenteM FIN CLASE
      |CLASE declaracion_componenteM FIN CLASE
      ;

declaracion_componenteM 
      : declaracion_componente declaracion_componenteM
      | declaracion_componente
      ;

superclases : '(' nombreCM ')'
      ;

declaracion_componente 
      : visibilidad componente
      | componente
      ;

visibilidad : PUBLICO 
      | PROTEGIDO 
      | PRIVADO
      ;

componente 
      : declaracion_tipo
      | declaracion_objeto
      | modificadorCM declaracion_subprograma
      | declaracion_subprograma
      ;

modificadorCM : modificador ',' modificadorCM
              | modificador
              ;

modificador : CONSTRUCTOR 
      | DESTRUCTOR 
      | GENERICO 
      | ABSTRACTO 
      | ESPECIFICO 
      | FINAL
      ;

/*******************************/
/* declaracion de subprogramas */
/*******************************/

declaracion_subprograma 
      : SUBPROGRAMA cabecera_subprograma cuerpo_subprograma SUBPROGRAMA
      ;

cabecera_subprograma 
      : IDENTIFICADOR parametrizacion tipo_resultado
      |IDENTIFICADOR parametrizacion
      |IDENTIFICADOR tipo_resultado 
      |IDENTIFICADOR
      ;

parametrizacion : '(' declaracion_parametrosPCM ')'
      ;

declaracion_parametrosPCM 
      : declaracion_parametros ';' declaracion_parametrosPCM
      | declaracion_parametros
      ;

declaracion_parametros 
      : identificadorCM ':' modo especificacion_tipo ASIGNACION expresion
      |identificadorCM ':' modo especificacion_tipo
      |identificadorCM ':' especificacion_tipo ASIGNACION expresion
      |identificadorCM ':' especificacion_tipo
      ;

modo : VALOR 
      | REFERENCIA
      ;

tipo_resultado : DEVOLVER especificacion_tipo
      ;

cuerpo_subprograma 
      : declaracionM PRINCIPIO instruccionM FIN
      |PRINCIPIO instruccionM FIN
      ;



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
            | ';'
            ;

instruccion_asignacion : objeto op_asignacion expresion ';'
      ;

op_asignacion : ASIGNACION 
      | ASIG_SUMA 
      | ASIG_RESTA 
      | ASIG_MULT 
      | ASIG_DIV 
      | ASIG_RESTO 
      | ASIG_POT 
      | ASIG_DESPI 
      | ASIG_DESPD;

instruccion_devolver 
      : DEVOLVER expresion ';'
      | DEVOLVER ';'
      ;

instruccion_llamada : llamada_subprograma ';'
      ;

llamada_subprograma : nombre '(' definicion_parametroCM ')'
                    |nombre '(' ')'
                    ;

definicion_parametroCM : definicion_parametro ',' definicion_parametroCM
                      | definicion_parametro
                      ;

definicion_parametro 
      : IDENTIFICADOR ASIGNACION expresion
      | expresion
      ;

instruccion_si 
      : SI expresion ENTONCES instruccionM SINO instruccionM FIN SI
      | SI expresion ENTONCES instruccionM FIN SI
      ;

instruccion_casos : CASOS expresion ES casoM FIN CASOS
      ;

casoM : caso casoM
      | caso
      ;

caso : CUANDO entradas FLECHA instruccionM
      ;

entradas : entradaM entrada
      ;

entradaM : entrada ':' entradaM
      |
      ;

entrada : expresion DOS_PUNTOS expresion 
          | expresion
          | OTRO
          ;

instruccion_bucle 
      : IDENTIFICADOR ':' clausula_iteracion instruccionM FIN BUCLE
      |clausula_iteracion instruccionM FIN BUCLE
      ;

clausula_iteracion 
      : PARA IDENTIFICADOR ':' especificacion_tipo  EN expresion
      | PARA IDENTIFICADOR EN expresion
      | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO DESCENDENTE
      | REPETIR IDENTIFICADOR EN RANGO DESCENDENTE
      | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO
      | REPETIR IDENTIFICADOR EN RANGO 
      | MIENTRAS expresion
      ;

instruccion_interrupcion : SIGUIENTE cuando ';'
      | SIGUIENTE ';'
      | SALIR DE IDENTIFICADOR cuando ';'
      | SALIR DE IDENTIFICADOR ';'
      | SALIR cuando ';'
      | SALIR ';'
      ;

cuando : CUANDO expresion;

instruccion_lanzamiento_excepcion : LANZA nombre ';'
      ;

instruccion_captura_excepcion 
      : PRUEBA instruccionM clausulas FIN PRUEBA
      ;

clausulas : clausulas_excepcion clausula_finalmente
      | clausulas_excepcion
      | clausula_finalmente
      ;

clausulas_excepcion 
      : clausula_excepcion_especificaM clausula_excepcion_general
      | clausula_excepcion_general
      ;

/* Le dimos la vuelta a la primera porque provocaba un conflicto */
clausula_excepcion_especificaM 
      : clausula_excepcion_especificaM clausula_excepcion_especifica
      | clausula_excepcion_especifica
      ;

clausula_excepcion_especifica : EXCEPCION '(' nombre ')' instruccionM
      ;

clausula_excepcion_general : EXCEPCION instruccionM
      ;

instruccionM : instruccion instruccionM
      | instruccion
      ;

clausula_finalmente : FINALMENTE instruccionM
      ;


/***************/
/* expresiones */
/***************/

/* Esto lo pusimos nosotros */
/* Hay que revisar que sea correcto */
expresion: expresion_OR
      ;

expresion_OR: expresion_OR OR expresion_AND
      | expresion_AND
      ;

expresion_AND: expresion_AND AND expresion_negacion
      | expresion_negacion
      ;

expresion_negacion: '~' expresion_relacionales
      | expresion_relacionales
      ;

expresion_relacionales: expresion_relacionales '<' expresion_desplazamiento
      | expresion_relacionales '>' expresion_desplazamiento
      | expresion_relacionales LEQ expresion_desplazamiento
      | expresion_relacionales GEQ expresion_desplazamiento
      | expresion_relacionales '=' expresion_desplazamiento
      | expresion_relacionales NEQ expresion_desplazamiento
      | expresion_desplazamiento
      ;

expresion_desplazamiento: expresion_desplazamiento DESPI expresion_relacionales
      | expresion_desplazamiento DESPD expresion_relacionales
      | expresion_relacionales
      ;

expresion_aritmetica1: expresion_aritmetica1 '+' expresion_desplazamiento
      | expresion_aritmetica1 '-' expresion_desplazamiento
      | expresion_desplazamiento
      ;

expresion_aritmetica2 : expresion_aritmetica2 '*' expresion_aritmetica1
      | expresion_aritmetica2 '/' expresion_aritmetica1
      | expresion_aritmetica2 '\\' expresion_aritmetica1
      | expresion_aritmetica1
      ;

expresion_potencia : expresion_posfija '^' expresion_potencia 
      | expresion_posfija
      ;

expresion_posfija : expresion_unaria operador_posfijo 
      | expresion_unaria
      ;

operador_posfijo : INC 
      | DEC
      ;

expresion_unaria : primario
      | '-' primario
      ;


primario : literal
      | objeto
      | OBJETO llamada_subprograma
      | llamada_subprograma
      | enumeraciones
      | '(' expresion ')'
      ;



literal : VERDADERO 
      | FALSO 
      | CTC_ENTERA 
      | CTC_REAL 
      | CTC_CARACTER 
      | CTC_CADENA
      ;

objeto: nombre
      | objeto '.' IDENTIFICADOR
      | objeto '[' expresion ']'
      | objeto '{' CTC_CADENA '}'
      ;


clausula_iteracionM : clausula_iteracion clausula_iteracionM
      | clausula_iteracion
      ;

expresionCM : expresion ',' expresionCM
      | expresion
      ;


clave_valorCM : clave_valor ',' clave_valorCM
      | clave_valor
      ;

campo_valorCM : campo_valor ',' campo_valorCM
      | campo_valor
      ;


enumeraciones : '[' expresion_condicional clausula_iteracionM ']'
      | '[' expresionCM ']'
      | '{' clave_valorCM '}'
      | '{' campo_valorCM '}'
      ;


expresion_condicional : expresion
      | SI expresion ENTONCES expresion 
      | SI expresion ENTONCES expresion SINO expresion
      ;

clave_valor : CTC_CADENA FLECHA expresion
      ;

campo_valor : IDENTIFICADOR FLECHA expresion
      ;
/*
A continuacion se implementar ́an los operadores de manera similar a como hemos hecho con los operandos, teniendo
en cuenta sus precedencias y asociatividades. De mayor a menor precedencia:
’-’ unario.
’++’ y ’--’ (posincremento y posdecremento)
’^’ (potencia)
’*’, ’/’ y ’\’
’+’ y ’-’.
’<-’ y ’->’ (operadores de desplazamiento)
’<’, ’>’, ’<=’, ’>=’, ’=’ y ’~=’
’~’ (negacion logica)
’/\’ (and logico)
’\/’ (or logico)
Todos los operadores anteriores son binarios, excepto ’-’ unario, ’++’, ’--’ y ’~’, que son unarios. Respecto a la
asociatividad, ’^’ es asociativo por la derecha, mientras que ’-’ unario, ’++’, ’--’, ’~’, ’~’ ’<’, ’>’, ’<=’, ’>=’, ’=’ y ’~=’
no son asociativos. El resto son asociativos por la izquierda.
ESTO ESTABA EN EL ENUNCIADO DE LA PRACTICA


%left AND OR
%nonassoc '~' 
%nonassoc '<' '>' LEQ GEQ '=' NEQ
%left DESPI DESPD
%left '+' '-'
%left '*' '/'  ’\'
%right '^'
%nonassoc INC DEC
%nonassoc '-'       ESTE ENTIENDO QUE NO SIRVE DE NADA



*/
%%

int yyerror(char *s) {
  fflush(stdout);
  printf("***************** %s\n",s);
  }

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  yydebug = 0; /*En 1 printea más información sobre la ejecución del programa, camo cambios de estados */

  if (argc < 2) {
    printf("Uso: ./chusco NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    yyparse();
    }
  }
