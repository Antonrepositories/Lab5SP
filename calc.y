%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token NUM

%%
calculation: expr { printf("Result: %d\n", $1); }
           ;

expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | '(' expr ')'  { $$ = $2; }
    | NUM           { $$ = $1; }
    ;
%%

void yyerror(const char *s) {
    printf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
