 
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
      :identificadorCM ':' CONSTANTE especificacion_tipo ASIGNACION expresion ';' {printf("declaracion_objeto -> identificadorCM : CONSTANTE especificacion_tipo = expresion;\n");}
      |identificadorCM ':' especificacion_tipo ASIGNACION expresion ';'           {printf("declaracion_objeto -> identificadorCM : especificacion_tipo = expresion;\n");}
      |identificadorCM ':' especificacion_tipo ';'                                {printf("declaracion_objeto -> identificadorCM : especificacion_tipo;\n");}
      ;

especificacion_tipo : nombre                                                      {printf("especificacion_tipo -> nombre\n");}
      | tipo_no_estructurado                                                     {printf("especificacion_tipo -> tipo_no_estructurado\n");}
      ;

/************************/
/* declaracion de tipos */
/************************/


declaracion_tipo 
      : TIPO IDENTIFICADOR ES tipo_no_estructurado ';'                           {printf("declaracion_tipo -> TIPO ID ES tipo_no_estructurado;\n");}
      | TIPO IDENTIFICADOR ES tipo_estructurado                                  {printf("declaracion_tipo -> TIPO ID ES tipo_estructurado;\n");}
      ;


tipo_no_estructurado : tipo_escalar                                              {printf("tipo_no_estructurado -> tipo_escalar\n");}
      | tipo_tabla                                                               {printf("tipo_no_estructurado -> tipo_tabla\n");}
      | tipo_diccionario                                                         {printf("tipo_no_estructurado -> tipo_diccionario\n");}
      ;

tipo_escalar 
      : SIGNO tipo_basico longitud RANGO rango                                  {printf("tipo_escalar -> SIGNO tipo_basico longitud RANGO rango\n");}
      | SIGNO tipo_basico longitud                                              {printf("tipo_escalar -> SIGNO tipo_basico longitud\n");}
      | SIGNO tipo_basico RANGO rango                                           {printf("tipo_escalar -> SIGNO tipo_basico RANGO rango\n");}
      | tipo_basico longitud RANGO rango                                        {printf("tipo_escalar -> tipo_basico longitud RANGO rango\n");}
      | SIGNO tipo_basico                                                       {printf("tipo_escalar -> SIGNO tipo_basico\n");}
      | tipo_basico longitud                                                    {printf("tipo_escalar -> tipo_basico longitud\n");}
      | tipo_basico RANGO rango                                                 {printf("tipo_escalar -> tipo_basico RANGO rango\n");}
      | tipo_basico                                                             {printf("tipo_escalar -> tipo_basico\n");}
      ;


longitud : CORTO                                                                {printf("longitud -> CORTO\n");}
      | LARGO                                                                   {printf("longitud -> LARGO\n");}
      ;

tipo_basico : BOOLEANO                                                          {printf("tipo_basico -> BOOLEANO\n");}
      | CARACTER                                                                {printf("tipo_basico -> CARACTER\n");}
      | ENTERO                                                                  {printf("tipo_basico -> ENTERO\n");}
      | REAL                                                                    {printf("tipo_basico -> REAL\n");}
      ;

rango 
      : expresion DOS_PUNTOS expresion DOS_PUNTOS expresion                     {printf("rango -> expresion : expresion : expresion\n");}
      | expresion DOS_PUNTOS expresion                                          {printf("rango -> expresion : expresion\n");}
      ;

tipo_tabla 
      : TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo     {printf("tipo_tabla -> TABLA ( expresion : expresion ) DE especificacion_tipo\n");}
      | LISTA DE especificacion_tipo                                            {printf("tipo_tabla -> LISTA DE especificacion_tipo\n");}
      ;

tipo_diccionario : DICCIONARIO DE especificacion_tipo                           {printf("tipo_diccionario -> DICCIONARIO DE especificacion_tipo\n");}
      ;

tipo_estructurado : tipo_registro                                               {printf("tipo_estructurado -> tipo_registro\n");}
      | tipo_enumerado                                                          {printf("tipo_estructurado -> tipo_enumerado\n");}
      | clase                                                                   {printf("tipo_estructurado -> clase\n");}
      ;

tipo_registro : REGISTRO campoM FIN REGISTRO                                    {printf("tipo_registro -> REGISTRO campoM FIN REGISTRO\n");}
      ;

campoM : campo campoM                                                           {printf("campoM -> campo campoM\n");}
      | campo                                                                   {printf("campoM -> campo\n");}
      ;

campo : identificadorCM ':' especificacion_tipo ASIGNACION expresion ';'        {printf("campo -> identificadorCM : especificacion_tipo := expresion;\n");}
      | identificadorCM ':' especificacion_tipo ';'                             {printf("campo -> identificadorCM : especificacion_tipo;\n");}
      ;

tipo_enumerado 
      : ENUMERACION DE tipo_escalar elemento_enumeracionCM FIN ENUMERACION      {printf("tipo_enumerado -> ENUMERACION DE tipo_escalar elemento_enumeracionCM FIN ENUMERACION\n");}
      | ENUMERACION elemento_enumeracionCM FIN ENUMERACION                      {printf("tipo_enumerado -> ENUMERACION elemento_enumeracionCM FIN ENUMERACION\n");}
      ;

elemento_enumeracionCM 
      : elemento_enumeracion ',' elemento_enumeracionCM                         {printf("elemento_enumeracionCM -> elemento_enumeracion , elemento_enumeracionCM\n");}
      | elemento_enumeracion                                                    {printf("elemento_enumeracionCM -> elemento_enumeracion\n");}
      ;

elemento_enumeracion 
      : IDENTIFICADOR ASIGNACION expresion                                      {printf("elemento_enumeracion -> ID := expresion\n");}
      | IDENTIFICADOR                                                           {printf("elemento_enumeracion -> ID\n");}
      ;

/*************************/
/* declaracion de clases */
/*************************/

clase : CLASE ULTIMA superclases declaracion_componenteM FIN CLASE              {printf("clase -> CLASE ULTIMA superclases declaracion_componenteM FIN CLASE\n");}
      |CLASE ULTIMA declaracion_componenteM FIN CLASE                           {printf("clase -> CLASE ULTIMA declaracion_componenteM FIN CLASE\n");}
      |CLASE superclases declaracion_componenteM FIN CLASE                      {printf("clase -> CLASE superclases declaracion_componenteM FIN CLASE\n");}
      |CLASE declaracion_componenteM FIN CLASE                                  {printf("clase -> CLASE declaracion_componenteM FIN CLASE\n");}
      ;

declaracion_componenteM 
      : declaracion_componente declaracion_componenteM                          {printf("declaracion_componenteM -> declaracion_componente declaracion_componenteM\n");}
      | declaracion_componente                                                  {printf("declaracion_componenteM -> declaracion_componente\n");}
      ;

superclases : '(' nombreCM ')'                                                  {printf("superclases -> ( nombreCM )\n");}
      ;

declaracion_componente 
      : visibilidad componente                                                  {printf("declaracion_componente -> visibilidad componente\n");}
      | componente                                                              {printf("declaracion_componente -> componente\n");}
      ;

visibilidad : PUBLICO                                                           {printf("visibilidad -> PUBLICO\n");}
      | PROTEGIDO                                                               {printf("visibilidad -> PROTEGIDO\n");}
      | PRIVADO                                                                 {printf("visibilidad -> PRIVADO\n");}
      ;

componente 
      : declaracion_tipo                                                        {printf("componente -> declaracion_tipo\n");}
      | declaracion_objeto                                                      {printf("componente -> declaracion_objeto\n");}
      | modificadorCM declaracion_subprograma                                   {printf("componente -> modificadorCM declaracion_subprograma\n");}
      | declaracion_subprograma                                                 {printf("componente -> declaracion_subprograma\n");}
      ;

modificadorCM : modificador ',' modificadorCM                                   {printf("modificadorCM -> modificador , modificadorCM\n");}
              | modificador                                                     {printf("modificadorCM -> modificador\n");}
              ;

modificador : CONSTRUCTOR                                                       {printf("modificador -> CONSTRUCTOR\n");}
      | DESTRUCTOR                                                              {printf("modificador -> DESTRUCTOR\n");}
      | GENERICO                                                                {printf("modificador -> GENERICO\n");}
      | ABSTRACTO                                                               {printf("modificador -> ABSTRACTO\n");}
      | ESPECIFICO                                                              {printf("modificador -> ESPECIFICO\n");}
      | FINAL                                                                   {printf("modificador -> FINAL\n");}
      ;

/*******************************/
/* declaracion de subprogramas */
/*******************************/

declaracion_subprograma 
      : SUBPROGRAMA cabecera_subprograma cuerpo_subprograma SUBPROGRAMA         {printf("declaracion_subprograma -> SUBPROGRAMA cabecera_subprograma cuerpo_subprograma SUBPROGRAMA\n");}
      ;

cabecera_subprograma 
      : IDENTIFICADOR parametrizacion tipo_resultado                            {printf("cabecera_subprograma -> ID parametrizacion tipo_resultado\n");}
      | IDENTIFICADOR parametrizacion                                           {printf("cabecera_subprograma -> ID parametrizacion\n");}
      | IDENTIFICADOR tipo_resultado                                            {printf("cabecera_subprograma -> ID tipo_resultado\n");}
      | IDENTIFICADOR                                                           {printf("cabecera_subprograma -> ID\n");}
      ;

parametrizacion : '(' declaracion_parametrosPCM ')'                             {printf("parametrizacion -> ( declaracion_parametrosPCM )\n");}
      ;

declaracion_parametrosPCM 
      : declaracion_parametros ';' declaracion_parametrosPCM                    {printf("declaracion_parametrosPCM -> declaracion_parametros ; declaracion_parametrosPCM\n");}
      | declaracion_parametros                                                  {printf("declaracion_parametrosPCM -> declaracion_parametros\n");}
      ;

declaracion_parametros 
      : identificadorCM ':' modo especificacion_tipo ASIGNACION expresion       {printf("declaracion_parametros -> identificadorCM : modo especificacion_tipo := expresion\n");}
      | identificadorCM ':' modo especificacion_tipo                            {printf("declaracion_parametros -> identificadorCM : modo especificacion_tipo\n");}
      | identificadorCM ':' especificacion_tipo ASIGNACION expresion            {printf("declaracion_parametros -> identificadorCM : especificacion_tipo := expresion\n");}
      | identificadorCM ':' especificacion_tipo                                 {printf("declaracion_parametros -> identificadorCM : especificacion_tipo\n");}
      ;

modo 
      : VALOR                                                                   {printf("modo -> VALOR\n");}
      | REFERENCIA                                                              {printf("modo -> REFERENCIA\n");}
      ;

tipo_resultado : DEVOLVER especificacion_tipo                                   {printf("tipo_resultado -> DEVOLVER especificacion_tipo\n");}
      ;

cuerpo_subprograma 
      : declaracionM PRINCIPIO instruccionM FIN                                 {printf("cuerpo_subprograma -> declaracionM PRINCIPIO instruccionM FIN\n");}
      | PRINCIPIO instruccionM FIN                                              {printf("cuerpo_subprograma -> PRINCIPIO instruccionM FIN\n");}
      ;


/*****************/
/* instrucciones */
/*****************/

instruccion : instruccion_asignacion                                            {printf("instruccion -> instruccion_asignacion\n");}
            | instruccion_devolver                                              {printf("instruccion -> instruccion_devolver\n");}
            | instruccion_llamada                                               {printf("instruccion -> instruccion_llamada\n");}
            | instruccion_si                                                    {printf("instruccion -> instruccion_si\n");}
            | instruccion_casos                                                 {printf("instruccion -> instruccion_casos\n");}
            | instruccion_bucle                                                 {printf("instruccion -> instruccion_bucle\n");}
            | instruccion_interrupcion                                          {printf("instruccion -> instruccion_interrupcion\n");}
            | instruccion_lanzamiento_excepcion                                 {printf("instruccion -> instruccion_lanzamiento_excepcion\n");}
            | instruccion_captura_excepcion                                     {printf("instruccion -> instruccion_captura_excepcion\n");}
            | ';'                                                               {printf("instruccion -> ;\n");}
            ;

instruccion_asignacion : objeto op_asignacion expresion ';'                     {printf("instruccion_asignacion -> objeto op_asignacion expresion ;\n");}
      ;

op_asignacion : ASIGNACION                                                      {printf("op_asignacion -> ASIGNACION\n");}
      | ASIG_SUMA                                                               {printf("op_asignacion -> ASIG_SUMA\n");}
      | ASIG_RESTA                                                              {printf("op_asignacion -> ASIG_RESTA\n");}
      | ASIG_MULT                                                               {printf("op_asignacion -> ASIG_MULT\n");}
      | ASIG_DIV                                                                {printf("op_asignacion -> ASIG_DIV\n");}
      | ASIG_RESTO                                                              {printf("op_asignacion -> ASIG_RESTO\n");}
      | ASIG_POT                                                                {printf("op_asignacion -> ASIG_POT\n");}
      | ASIG_DESPI                                                              {printf("op_asignacion -> ASIG_DESPI\n");}
      | ASIG_DESPD                                                              {printf("op_asignacion -> ASIG_DESPD\n");}
      ; 

instruccion_devolver 
      : DEVOLVER expresion ';'                                                  {printf("instruccion_devolver -> DEVOLVER expresion ;\n");}
      | DEVOLVER ';'                                                            {printf("instruccion_devolver -> DEVOLVER ;\n");}
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
