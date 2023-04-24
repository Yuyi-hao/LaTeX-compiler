%{
#include "parser.tab.h"
#include <stdio.h>
#include <string.h>
/* YYSTYPE yylval; */
%}
 
%%


[a-zA-Z]		{
				printf("%s ", yytext);
				yylval.arr = strdup(yytext); 
				return(LETTERS);
			}

[a-zA-Z0-9_]+ 		{
				printf("%s ", yytext);
				yylval.arr=strdup(yytext);
				return (WORD);
			}


(\.|\,|\!|\?|\:|\;|\') {
				printf("%s ", yytext);
				yylval.arr=strdup(yytext);
				return (WORD);		

			}
\+			{
				printf("%s ", yytext);
				yylval.arr=strdup(yytext);
				return (WORD);	
			}
\-			{
				printf("%s ", yytext);
				yylval.arr=strdup(yytext);
				return (WORD);	
			}
\*			{
				printf("%s ", yytext);
				yylval.arr=strdup(yytext);
				return (WORD);	
			}
\/			{
				printf("%s ", yytext);
				yylval.arr=strdup(yytext);
				return (WORD);	
			}

\{			{
				printf("%s ", yytext);
				return(LCURLYB);
			}

\}			{	printf("%s ", yytext);
				return(RCURLYB);
			}
\[			{
				printf("%s ", yytext);
				return(LBRACKET);
			}

\]			{	printf("%s ", yytext);
				return(RBRACKET);
			}
\|			{
				printf("%s ",yytext);
				return(PIPE);
			}


\\documentclass\{article\} 	{
				printf("%s ", yytext);
				 return(DOCUMENTCLASS);
			}
\\begin\{document\} 	{
				printf("%s ", yytext);
				 return(BEGINDOC);
			}

\\title		{
				printf("%s ",yytext);
				return(TITLE);
			}
\\maketitle		{
				printf("%s ",yytext);
				return(MAKETITLE);
			}

\\paragraph		{	printf("%s ",yytext);
				return(PARAGRAPH);
			}
\\begin\{enumerate\}    {
				printf("%s ", yytext);
				 return(BEGINENUM);
			}

\\item                {
				printf("%s ", yytext);
				return(ITEM);
			}

\\end\{enumerate\}      {	
				printf("%s ", yytext);
				return(ENDENUM);
			}

\\begin\{table\}	{

				printf("%s ",yytext);
				return(BEGINTABLE);			
			}

\\begin\{tabular\}\{l|c|r\}	{
				printf("%s ",yytext);
				return(BEGINTABULAR);
			}

\\hline		{
				printf("%s ",yytext);
				return(HLINE);
			}

\&			{		
				printf("%s ",yytext);
				return(AMPERSAND);
			}
	
\\\\			{
				printf("%s ",yytext);
				return(NEWLINE);
			}

\\end\{table\}		{
				printf("%s ",yytext);
				return(ENDTABLE);
			}

\\end\{tabular\}	{
				printf("%s ",yytext);
				return(ENDTABULAR);
			}			

\\end\{document\}    	{	printf(" %s ", yytext);
				return(ENDDOC);
			}
\\caption		{	printf("%s ",yytext);
				return(CAPTION);
			}


%%

int  yywrap(void){
    return 1;
}
