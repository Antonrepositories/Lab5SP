%{

#include<stdio.h>

#include<stdbool.h>





int registers[26];

int base;

%}



%start lst



%union { int a; }





%token DIG LET



%left '+' '-'

%left '*' '/' '%'

%left UMINUS  



%%                   



lst:                       

         |

        lst statement '\n'

         |

        lst error '\n'

         {

           yyerrok;

         }

         ;

statement:    E

         {

         

           printf("Result: %d\n",$1);

           //printf("Enter your expression: \n");

         }

         |

         LET '=' E

         {

           registers[$1.a] = $3.a;

         }



         ;



E:    '(' E ')'

         {

           $$ = $2;

         }

         |

         E '+' E

         {

           $$.a = $1.a + $3.a;

         }

         |

         E '-' E

         {

           $$.a = $1.a - $3.a;

         }

         |

         E '*' E

         {



           $$.a = $1.a * $3.a;

         }

         |

         E '/' E

         {

          if($3.a==0){

	   yyerror("divide by zero error");

	   }

	  else

           $$.a = $1.a / $3.a;

         }

         |

         E '%' E

         {

           $$.a = $1.a % $3.a;

         }

         |



        '-' E %prec UMINUS

         {

           $$.a = -$2.a;

         }

         |

         LET

         {

           $$.a = registers[$1.a];

         }



         |

         num

         ;



num: 	 DIG

	 {

	  $$ = $1;

	  base = 10;

	 } |

         num DIG

         {

           $$.a = base * $1.a + $2.a;

         }

         ;



%%

main()

{

 printf("This calculator works only with data of type int\n");

 return(yyparse());

}



yyerror(s)

char *s;

{

  

  fprintf(stderr, "%s, result is not correct!\n",s);

}



yywrap()

{

  return(1);

}
