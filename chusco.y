 
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
/* No lo ponemos porque ya lo solucionamos con una no ambigua */



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
      | tipo_no_estructurado                                                      {printf("especificacion_tipo -> tipo_no_estructurado\n");}
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

instruccion_llamada : llamada_subprograma ';'                                   {printf("instruccion_llamada -> llamada_subprograma ;\n");}
      ;

llamada_subprograma : nombre '(' definicion_parametroCM ')'                     {printf("llamada_subprograma -> nombre ( definicion_parametroCM )\n");}
                    | nombre '(' ')'                                            {printf("llamada_subprograma -> nombre ( )\n");}
                    ;

definicion_parametroCM : definicion_parametro ',' definicion_parametroCM        {printf("definicion_parametroCM -> definicion_parametro , definicion_parametroCM\n");}
                      | definicion_parametro                                    {printf("definicion_parametroCM -> definicion_parametro\n");}
                      ;

definicion_parametro 
      : IDENTIFICADOR ASIGNACION expresion                                      {printf("definicion_parametro -> ID := expresion\n");}
      | expresion                                                               {printf("definicion_parametro -> expresion\n");}
      ;

instruccion_si 
      : SI expresion ENTONCES instruccionM SINO instruccionM FIN SI             {printf("instruccion_si -> SI expresion ENTONCES instruccionM SINO instruccionM FIN SI\n");}
      | SI expresion ENTONCES instruccionM FIN SI                               {printf("instruccion_si -> SI expresion ENTONCES instruccionM FIN SI\n");}
      ;

instruccion_casos : CASOS expresion ES casoM FIN CASOS                          {printf("instruccion_casos -> CASOS expresion ES casoM FIN CASOS\n");}
      ;

casoM : caso casoM                                                              {printf("casoM -> caso casoM\n");}
      | caso                                                                    {printf("casoM -> caso\n");}
      ;

caso : CUANDO entradas FLECHA instruccionM                                      {printf("caso -> CUANDO entradas => instruccionM\n");}
      ;

entradas : entradaM entrada                                                     {printf("entradas -> entradaM entrada\n");}
      ;

entradaM : entrada ':' entradaM                                                 {printf("entradaM -> entrada : entradaM\n");}
      |                                                                         {printf("entradaM -> ε\n");}
      ;

entrada : expresion DOS_PUNTOS expresion                                        {printf("entrada -> expresion .. expresion\n");}
          | expresion                                                           {printf("entrada -> expresion\n");}
          | OTRO                                                                {printf("entrada -> OTRO\n");}
          ;

instruccion_bucle 
      : IDENTIFICADOR ':' clausula_iteracion instruccionM FIN BUCLE             {printf("instruccion_bucle -> ID : clausula_iteracion instruccionM FIN BUCLE\n");}
      |clausula_iteracion instruccionM FIN BUCLE                                {printf("instruccion_bucle -> clausula_iteracion instruccionM FIN BUCLE\n");}
      ;

clausula_iteracion 
      : PARA IDENTIFICADOR ':' especificacion_tipo  EN expresion                {printf("clausula_iteracion -> PARA ID : especificacion_tipo EN expresion\n");}
      | PARA IDENTIFICADOR EN expresion                                         {printf("clausula_iteracion -> PARA ID EN expresion\n");}
      | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO DESCENDENTE      {printf("clausula_iteracion -> REPETIR ID : especificacion_tipo EN RANGO DESCENDENTE\n");}
      | REPETIR IDENTIFICADOR EN RANGO DESCENDENTE                              {printf("clausula_iteracion -> REPETIR ID EN RANGO DESCENDENTE\n");}
      | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO                  {printf("clausula_iteracion -> REPETIR ID : especificacion_tipo EN RANGO\n");}
      | REPETIR IDENTIFICADOR EN RANGO                                          {printf("clausula_iteracion -> REPETIR ID EN RANGO\n");}
      | MIENTRAS expresion                                                      {printf("clausula_iteracion -> MIENTRAS expresion\n");}
      ;

instruccion_interrupcion : SIGUIENTE cuando ';'                                 {printf("instruccion_interrupcion -> SIGUIENTE cuando ;\n");}
      | SIGUIENTE ';'                                                           {printf("instruccion_interrupcion -> SIGUIENTE ;\n");}
      | SALIR DE IDENTIFICADOR cuando ';'                                       {printf("instruccion_interrupcion -> SALIR DE ID cuando ;\n");}
      | SALIR DE IDENTIFICADOR ';'                                              {printf("instruccion_interrupcion -> SALIR DE ID ;\n");}
      | SALIR cuando ';'                                                        {printf("instruccion_interrupcion -> SALIR cuando ;\n");}
      | SALIR ';'                                                               {printf("instruccion_interrupcion -> SALIR ;\n");}
      ;

cuando : CUANDO expresion                                                       {printf("cuando -> CUANDO expresion\n");}
      ;

instruccion_lanzamiento_excepcion : LANZA nombre ';'                            {printf("instruccion_lanzamiento_excepcion -> LANZA nombre ;\n");}
      ;

instruccion_captura_excepcion 
      : PRUEBA instruccionM clausulas FIN PRUEBA                                {printf("instruccion_captura_excepcion -> PRUEBA instruccionM clausulas FIN PRUEBA\n");}
      ;

clausulas : clausulas_excepcion clausula_finalmente                             {printf("clausulas -> clausulas_excepcion clausula_finalmente\n");}
      | clausulas_excepcion                                                     {printf("clausulas -> clausulas_excepcion\n");}
      | clausula_finalmente                                                     {printf("clausulas -> clausula_finalmente\n");}
      ;

clausulas_excepcion 
      : clausula_excepcion_especificaM clausula_excepcion_general               {printf("clausulas_excepcion -> clausula_excepcion_especificaM clausula_excepcion_general\n");}
      | clausula_excepcion_general                                              {printf("clausulas_excepcion -> clausula_excepcion_general\n");}
      ;

/* Le dimos la vuelta a la primera porque provocaba un conflicto */
clausula_excepcion_especificaM 
      : clausula_excepcion_especificaM clausula_excepcion_especifica            {printf("clausula_excepcion_especificaM -> clausula_excepcion_especificaM clausula_excepcion_especifica\n");}
      | clausula_excepcion_especifica                                           {printf("clausula_excepcion_especificaM -> clausula_excepcion_especifica\n");}
      ;

clausula_excepcion_especifica : EXCEPCION '(' nombre ')' instruccionM           {printf("clausula_excepcion_especifica -> EXCEPCION ( nombre ) instruccionM\n");}
      ;

clausula_excepcion_general : EXCEPCION instruccionM                             {printf("clausula_excepcion_general -> EXCEPCION instruccionM\n");}
      ;

instruccionM : instruccion instruccionM                                         {printf("instruccionM -> instruccion instruccionM\n");}
      | instruccion                                                             {printf("instruccionM -> instruccion\n");}
      ;

clausula_finalmente : FINALMENTE instruccionM                                   {printf("clausula_finalmente -> FINALMENTE instruccionM\n");}
      ;


/***************/
/* expresiones */
/***************/

/* Esto lo pusimos nosotros */
/* Hay que revisar que sea correcto */
expresion: expresion_OR                                                         {printf("expresion -> expresion_OR\n");}
      ;

expresion_OR: expresion_OR OR expresion_AND                                     {printf("expresion_OR -> expresion_OR \/ expresion_AND\n");}
      | expresion_AND                                                           {printf("expresion_OR -> expresion_AND\n");}
      ;

expresion_AND: expresion_AND AND expresion_negacion                             {printf("expresion_AND -> expresion_AND /\ expresion_negacion\n");}
      | expresion_negacion                                                      {printf("expresion_AND -> expresion_negacion\n");}
      ;

expresion_negacion: '~' expresion_relacionales                                  {printf("expresion_negacion -> ~ expresion_relacionales\n");}
      | expresion_relacionales                                                  {printf("expresion_negacion -> expresion_relacionales\n");}
      ;

expresion_relacionales: expresion_relacionales '<' expresion_desplazamiento     {printf("expresion_relacionales -> expresion_relacionales < expresion_desplazamiento\n");}
      | expresion_relacionales '>' expresion_desplazamiento                     {printf("expresion_relacionales -> expresion_relacionales > expresion_desplazamiento\n");}
      | expresion_relacionales LEQ expresion_desplazamiento                     {printf("expresion_relacionales -> expresion_relacionales <= expresion_desplazamiento\n");}
      | expresion_relacionales GEQ expresion_desplazamiento                     {printf("expresion_relacionales -> expresion_relacionales >= expresion_desplazamiento\n");}
      | expresion_relacionales '=' expresion_desplazamiento                     {printf("expresion_relacionales -> expresion_relacionales = expresion_desplazamiento\n");}
      | expresion_relacionales NEQ expresion_desplazamiento                     {printf("expresion_relacionales -> expresion_relacionales ~= expresion_desplazamiento\n");}
      | expresion_desplazamiento                                                {printf("expresion_relacionales -> expresion_desplazamiento\n");}
      ;

expresion_desplazamiento: expresion_desplazamiento DESPI expresion_relacionales {printf("expresion_desplazamiento -> expresion_desplazamiento <- expresion_relacionales\n");}
      | expresion_desplazamiento DESPD expresion_relacionales                   {printf("expresion_desplazamiento -> expresion_desplazamiento -> expresion_relacionales\n");}
      | expresion_relacionales                                                  {printf("expresion_desplazamiento -> expresion_relacionales\n");}
      ;

expresion_aritmetica1: expresion_aritmetica1 '+' expresion_desplazamiento       {printf("expresion_aritmetica1 -> expresion_aritmetica1 + expresion_desplazamiento\n");}
      | expresion_aritmetica1 '-' expresion_desplazamiento                      {printf("expresion_aritmetica1 -> expresion_aritmetica1 - expresion_desplazamiento\n");}
      | expresion_desplazamiento                                                {printf("expresion_aritmetica1 -> expresion_desplazamiento\n");}
      ;

expresion_aritmetica2 : expresion_aritmetica2 '*' expresion_aritmetica1         {printf("expresion_aritmetica2 -> expresion_aritmetica2 * expresion_aritmetica1\n");}
      | expresion_aritmetica2 '/' expresion_aritmetica1                         {printf("expresion_aritmetica2 -> expresion_aritmetica2 / expresion_aritmetica1\n");}
      | expresion_aritmetica2 '\\' expresion_aritmetica1                        {printf("expresion_aritmetica2 -> expresion_aritmetica2 \ expresion_aritmetica1\n");}
      | expresion_aritmetica1                                                   {printf("expresion_aritmetica2 -> expresion_aritmetica1\n");}
      ;

expresion_potencia : expresion_posfija '^' expresion_potencia                   {printf("expresion_potencia -> expresion_posfija ^ expresion_potencia\n");}
      | expresion_posfija                                                       {printf("expresion_potencia -> expresion_posfija\n");}
      ;

expresion_posfija : expresion_unaria operador_posfijo                           {printf("expresion_posfija -> expresion_unaria operador_posfijo\n");}
      | expresion_unaria                                                        {printf("expresion_posfija -> expresion_unaria\n");}
      ;

operador_posfijo : INC                                                          {printf("operador_posfijo -> ++\n");}
      | DEC                                                                     {printf("operador_posfijo -> --\n");}
      ;

expresion_unaria : primario                                                     {printf("expresion_unaria -> primario\n");}
      | '-' primario                                                            {printf("expresion_unaria -> - primario\n");}
      ;


primario : literal                                                              {printf("primario -> literal\n");}
      | objeto                                                                  {printf("primario -> objeto\n");}
      | OBJETO llamada_subprograma                                              {printf("primario -> OBJETO llamada_subprograma\n");}
      | llamada_subprograma                                                     {printf("primario -> llamada_subprograma\n");}
      | enumeraciones                                                           {printf("primario -> enumeraciones\n");}
      | '(' expresion ')'                                                       {printf("primario -> ( expresion )\n");}
      ;



literal 
      : VERDADERO                                                               {printf("literal -> VERDADERO\n");}
      | FALSO                                                                   {printf("literal -> FALSO\n");}
      | CTC_ENTERA                                                              {printf("literal -> CTC_ENTERA\n");}
      | CTC_REAL                                                                {printf("literal -> CTC_REAL\n");}
      | CTC_CARACTER                                                            {printf("literal -> CTC_CARACTER\n");}
      | CTC_CADENA                                                              {printf("literal -> CTC_CADENA\n");}
      ;

objeto
      : nombre                                                                  {printf("objeto -> nombre\n");}
      | objeto '.' IDENTIFICADOR                                                {printf("objeto -> objeto . ID\n");}
      | objeto '[' expresion ']'                                                {printf("objeto -> objeto [ expresion ]\n");}
      | objeto '{' CTC_CADENA '}'                                               {printf("objeto -> objeto { CTC_CADENA }\n");}
      ;


clausula_iteracionM : clausula_iteracion clausula_iteracionM                    {printf("clausula_iteracionM -> clausula_iteracion clausula_iteracionM\n");}
      | clausula_iteracion                                                      {printf("clausula_iteracionM -> clausula_iteracion\n");}
      ;

expresionCM : expresion ',' expresionCM                                         {printf("expresionCM -> expresion , expresionCM\n");}
      | expresion                                                               {printf("expresionCM -> expresion\n");}
      ;


clave_valorCM : clave_valor ',' clave_valorCM                                   {printf("clave_valorCM -> clave_valor , clave_valorCM\n");}
      | clave_valor                                                             {printf("clave_valorCM -> clave_valor\n");}
      ;

campo_valorCM : campo_valor ',' campo_valorCM                                   {printf("campo_valorCM -> campo_valor , campo_valorCM\n");}
      | campo_valor                                                             {printf("campo_valorCM -> campo_valor\n");}
      ;


enumeraciones : '[' expresion_condicional clausula_iteracionM ']'               {printf("enumeraciones -> [ expresion_condicional clausula_iteracionM ]\n");}
      | '[' expresionCM ']'                                                     {printf("enumeraciones -> [ expresionCM ]\n");}
      | '{' clave_valorCM '}'                                                   {printf("enumeraciones -> { clave_valorCM }\n");}
      | '{' campo_valorCM '}'                                                   {printf("enumeraciones -> { campo_valorCM }\n");}
      ;


expresion_condicional : expresion                                               {printf("expresion_condicional -> expresion\n");}
      | SI expresion ENTONCES expresion                                         {printf("expresion_condicional -> SI expresion ENTONCES expresion\n");}
      | SI expresion ENTONCES expresion SINO expresion                          {printf("expresion_condicional -> SI expresion ENTONCES expresion SINO expresion\n");}
      ;

clave_valor 
      : CTC_CADENA FLECHA expresion                                             {printf("clave_valor -> CTC_CADENA -> expresion\n");}
      ;

campo_valor
      : IDENTIFICADOR FLECHA expresion                                          {printf("campo_valor -> ID -> expresion\n");}
      ;


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
