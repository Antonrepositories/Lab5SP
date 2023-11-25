%{



#include <stdio.h>

#include "y.tab.h"

int c;

%}

%%

" "       ;

[0-9]     {

            c = yytext[0];

            yylval.a = c - '0';

            return(DIG);

          }

          ;

[a-z]     {

            c = yytext[0];

            yylval.a = c - 'a';

            return(LET);

          }

          ;

[^a-z0-9\b]    {

                 c = yytext[0];

                 return(c);

              }

%%
