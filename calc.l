%{
#include <stdio.h>
#include "y.tab.h" // Yacc/Bison-generated header file
%}

%%
[0-9]+          { yylval.num = atoi(yytext); return NUM; }
[-+*/()]        { return *yytext; }
[ \t\n]         ;
.               { printf("Invalid character: %s\n", yytext); }
%%
