%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
extern int p=0;
#include "y.tab.h"
extern int j=0;
extern int linea;
extern int ubi=0;
 int yylex();
 int errcont=0;
extern char *yytext;
extern int yylineno;
extern FILE *yyin;
void yyerror(char *s);
void para();
char s;
typedef char matriz[50];
matriz variables[50];
matriz tiposdatos[50];
matriz valor[50];



%}

%start sigma
%token SIMPLECOMILLA
%token PARIZQ
%token TOKPARA
%token PARDER
%token MENORIGUAL
%token MAYORIGUAL
%token MENOR
%token MAYOR
%token IGUAL
%token TOKFINSI
%token COMA
%token DISTINTO
%token TOKDOSPUNTOS
%token TOKMAS
%token TOKENTONCES
%token TOKMULTIPLICAR
%token TOKASIGNACION
%token TOKENSINO
%token TOKENPROCESO
%token TOKMENOS
%token TOKDIV
%token TOKMOD
%token TOKDIVENTERA
%token TOKPOTENCIA
%token TOKREPETIR
%token TOKENTERO
%token CARACTER
%token ALFANUMERICO
%token TOKNUM
%token ENTERO
%token TOKENLEER
%token TOKENESCRIBIR
%token TOKENACCION
%token TOKMIENTRAS
%token TOKES
%token PCOMA
%token TOKSI
%token TOKOR
%token REAL
%token ALF
%token TOKENHACER
%token LETRA
%token GBAJO
%token TOKNOT
%token TOKAND
%token TOKENHASTA
%token TOKENFINMIENTRAS
%token TOKENFINPARA
%token TOKFINACCION
%token TOKHASTAQUE
%token TOKREAL
%token TOKCOMENTARIO
%token IDENTIF
%token TOKAMBIENTE
%token CADENA

%%

sigma: TOKENACCION IDENTIF TOKES TOKAMBIENTE comentarios var TOKENPROCESO comentarios sent TOKFINACCION  PCOMA comentarios
;

var: 
   | xx TOKDOSPUNTOS tipo var
;

xx: IDENTIF {controlarVariable();}
;

tipo: ENTERO | REAL | ALF
;

sent: 
    | TOKSI not condicion TOKENTONCES sent TOKFINSI  PCOMA sent
    | TOKSI not condicion TOKENTONCES sent TOKENSINO sent TOKFINSI  PCOMA sent
    | TOKMIENTRAS condicion TOKENHACER sent TOKENFINMIENTRAS  PCOMA sent
    | TOKREPETIR sent TOKHASTAQUE condicion  PCOMA sent
    | TOKPARA PARIZQ IDENTIF TOKASIGNACION TOKENTERO PARDER TOKENHASTA TOKENTERO inc TOKENHACER sent TOKENFINPARA  PCOMA sent
    | TOKPARA PARIZQ IDENTIF TOKASIGNACION TOKENTERO PARDER TOKENHASTA IDENTIF inc TOKENHACER sent TOKENFINPARA  PCOMA sent
    | TOKENESCRIBIR PARIZQ CADENA PARDER PCOMA sent
    | TOKENESCRIBIR PARIZQ SIMPLECOMILLA cad TOKDOSPUNTOS SIMPLECOMILLA dd PARDER PCOMA sent
    | TOKENESCRIBIR PARIZQ SIMPLECOMILLA cad  SIMPLECOMILLA dd PARDER  PCOMA sent
    | TOKENESCRIBIR PARIZQ operacion a PARDER  PCOMA sent
    | TOKENESCRIBIR PARIZQ hh PARDER  PCOMA sent
    | TOKENESCRIBIR PARIZQ CADENA COMA IDENTIF a PARDER  PCOMA sent
    | TOKENLEER PARIZQ IDENTIF a PARDER  PCOMA sent
    | IDENTIF TOKMAS TOKMAS sent
    | IDENTIF TOKMENOS TOKMENOS sent
    | IDENTIF TOKASIGNACION PARIZQ operacion PARDER  PCOMA sent
    | IDENTIF TOKASIGNACION kk  PCOMA sent
    | IDENTIF TOKASIGNACION bb  PCOMA sent    
;

comentarios: 
                | TOKCOMENTARIO PCOMA;

dd:
  | COMA IDENTIF
  | IDENTIF
;


hh: TOKENTERO aritmetico TOKENTERO
  | TOKENTERO aritmetico IDENTIF
  | IDENTIF aritmetico TOKENTERO
  | IDENTIF aritmetico IDENTIF
;
kk: PARIZQ bb aritmetico bb PARDER
  | bb aritmetico bb

;
bb: IDENTIF
  | TOKENTERO
  | TOKREAL
;
inc:
    | COMA TOKENTERO;

oplog: TOKAND
     | TOKOR
;
cad:
    | IDENTIF cad 
;

a:
    | COMA operacion a
;

not:
   | TOKNOT
;

operador: MAYORIGUAL | MENORIGUAL | IGUAL| MAYOR | MENOR |  DISTINTO 
;
aritmetico: TOKMAS | TOKMENOS | TOKMULTIPLICAR | TOKDIV | TOKMOD | TOKDIVENTERA | TOKPOTENCIA
;
arit2:
     | TOKMAS IDENTIF
     | TOKMENOS IDENTIF
     | TOKMULTIPLICAR IDENTIF
;
condicion: operacionlogica  
          | operacionlogica oplog condicion 
          | PARIZQ term operador term PARDER
          | PARIZQ term aritmetico term operador TOKENTERO PARDER
;

operacion: 
             PARIZQ term PARDER
            | PARIZQ term aritmetico operacion PARDER
            | PARIZQ term aritmetico term PARDER arit2
            | PARIZQ term aritmetico term IGUAL term PARDER
            | PARIZQ term PARDER aritmetico term PARDER
            | PARIZQ term operador term oplog term operador term PARDER 

;


operacionlogica:  PARIZQ operacion oplog operacion PARDER
;

term: TOKENTERO | TOKREAL | CADENA | not IDENTIF 
;

%%
void yyerror(char *s)

 {

printf ("\t\tError sintactico: en linea %i: %s", yylineno, yytext);
	errcont++;


}

void controlarVariable()
{
  int n = 0;
  int m = 0;
  while(n<=50)
  {
    if(strcmp(variables[n],yytext)==0)
    {
      m++;
    }
    n++;
  }
  if(m>0)
  {
    printf("                 ERRORES SEMANTICOS:\n                  ");
    printf("         En la linea %i",linea                 );
    printf("         La variable %s",yytext               );
    printf("         Ya fue declarada\n\n"                  );

  }
  else
  {
    strcpy(variables[p],yytext);
    p++;
  }
}


int main (int argc, char *argv[])
{
    if (argc == 2)
    {
    	yyin = fopen (argv[1], "rt");
    	if (yyin == NULL)
    	{
    		printf ("El archivo %s no se puede abrir\n", argv[1]);
    		exit (-1);
    	}
    }
    else
    {
        printf("\t\t\t\t ******************************************\n");
        printf("\t\t\t\t *                                        *\n");
        printf("\t\t\t\t *               BIENVENIDO               *\n");
        printf("\t\t\t\t *         -ANALIZADOR SINTACTICO-        *\n");
        printf("\t\t\t\t *                                        *\n");
        printf(" \t\t\t\t ******************************************\n\n\n\n\n");
        printf("\t\t\t\tIndique el modo para realizar analisis:\n");
        printf("\t\t\t\t1)    Manual\n");
        printf("\t\t\t\t2)    Apartir de un archivo\n");
        printf("Su respuesta:   \n");
        char rta;
        scanf ("%c",&rta);
        switch (rta){
            case '1':
            {
                printf("\n\t\tIngrese codigo a analizar por favor:\n");
                yyin=stdin;
                break;
            }
            case '2':
            {
                 printf("\n\t\tIngrese el nombre/ruta del archivo que desea analizar por favor: ");
                 char string[200];
                 scanf ("%s", string);
                 yyin=fopen(string,"rt");
                 if (yyin == NULL)
             	{
             		printf ("\n\t\tEl archivo %s no se puede abrir\n", string);
             		exit (-1);
             	}
                break;
            }
            default: return 0;
        }
    }
    yyparse();
    printf("\n\t\tEl analisis sintactico finalizo con %i error(es).\n",errcont);

return 0;



}