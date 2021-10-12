/* analizador lexico */

%{
						/*SECTOR DE LIBRERIAS DE C*/

#include <stdio.h>
#include <stdlib.h>
int linea = 1;
#include "y.tab.h"
extern YYSTYPE yylval;
extern char *yytext;
extern int yylineno;
extern int errcont;
#define TOKERROR -1
#define OK 0

%}
						/*comandos*/

%option noyywrap
%option yylineno
%option caseless




						/*TOKEN OPERADORES RELACIONALES*/
menorque				<
mayorque				>
menorigual				<=
mayorigual				>=
igual					=
distinto				<>
dosptos					:
parentesis				"("|")"

						/*TOKEN OPERADORES ARITMETICOS*/
MAS						"+"
POR						"*"
ASIGNACION				":="
MENOS					"-"
DIV						"_div"
MODULO					"_mod"
DIVENTERO				"/"
POT 					"**" 

						
						/*TOKEN OPERADORES LOGICOS*/
Y						"_y"
O						"_O"
Negacion				"_no"

						/*TOKEN CARACTERES*/
espacio           		[ \t]+
caract      			[a-zA-Z]+
COMILLAS     			\"
cadena      			\".*\"
comentario     			"#"{espacio}+*\n+*{espacio}+*{caract}+{espacio}+*\n+*{espacio}+*\n+*"#"|"@"{espacio}*{caract}+ 
Id     					[a-zA-Z]+[0-9]*|[a-zA-Z]+"_"{digito}+|[a-zA-Z]+"_"{digito}+"_"{caract}+|[a-zA-Z]+"_"{caract}+
findesentencia 			";"
Id2                     [a-zA-Z]([a-zA-Z0-9]|[a-zA-Z0-9])*



						/*TOKEN NUMEROS*/
digito					[0-9]			
numREAL       			[0-9]+"."([0-9])*
%%
						/*REGLAS*/
"'"                   	{return SIMPLECOMILLA;}
"("                     {return PARIZQ;}
")"                     {return PARDER;}
">="              		{return MAYORIGUAL;}
"<="             		{return MENORIGUAL;}
"="                  	{return IGUAL;}
">"                		{return MAYOR;}
"<"                		{return MENOR;}
"<>"                	{return DISTINTO;}
","               		{return COMA;}
":"						{return TOKDOSPUNTOS;}
"+"    	 				{return TOKMAS;}
"entonces"              {return TOKENTONCES;}
"*"   					{return TOKMULTIPLICAR;}
":="    				{return TOKASIGNACION;}
"-"    					{return TOKMENOS;}
"_div"    				{return TOKDIV;}
"_mod"   				{return TOKMOD;}
"/"    					{return TOKDIVENTERA;}
"**"   					{return TOKPOTENCIA;}
"real"					{return REAL;}
"entero"                {return ENTERO;}
"alfanumerico"			{return ALF;}
"_"                     {return GBAJO;}
"caracter"              {return CARACTER;}
[0-9]+   	  			{return TOKENTERO;}
"Mientras"    			{return TOKMIENTRAS;}
"Si"   					{return TOKSI;}
"Para"    				{return TOKPARA;}
"repetir"    			{return TOKREPETIR;}
"ambiente"    			{return TOKAMBIENTE;}
"_es"					{return TOKES;}
"_y"   					{return TOKAND;}
"_o"  					{return TOKOR;}
{cadena}                {return CADENA;}
"_no"   				{return TOKNOT;}
"accion"    			{return TOKENACCION;}
"escribir"    			{return TOKENESCRIBIR;}
"leer"   				{return TOKENLEER;}
"proceso"    			{return TOKENPROCESO;}
"fin_si"				{return TOKFINSI;}
"sino"					{return TOKENSINO;}
"hacer"					{return TOKENHACER;}
"fin_mientras"			{return TOKENFINMIENTRAS;}
"hasta"					{return TOKENHASTA;}
"fin_para"				{return TOKENFINPARA;}
"fin_accion"			{return TOKFINACCION;}
"hasta_que"				{return TOKHASTAQUE;}
{digito}+"."{digito}+   {return TOKREAL;}
{Id}  					{return IDENTIF;}
{comentario} 			{return TOKCOMENTARIO;}
";" 		            {return PCOMA;}
{espacio}				{}
\n                      {linea++;}
.						{printf("Error lexico: '%s', linea numero %i\n", yytext, yylineno); errcont++;}
%%
