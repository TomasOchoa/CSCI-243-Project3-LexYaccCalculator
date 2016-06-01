%{
 #include <stdio.h>
 extern int hex;
 %}
 

 %union {int a_number;}
 %start line
 %token <a_number> number
 %type <a_number> exp term factor

 %%

 line   : exp ';'          {if(!hex)
								printf("Result: %d\n", $1);
							else
								printf("Result: %x\n", $1);
							}
		| line exp ';' 		{if(!hex)
								printf("Result: %d\n", $2);
							else
								printf("Result: %x\n", $2);
							}					
        ;
 exp    : term             {$$ = $1;}
        | exp '+' term     {$$ = $1 + $3;}
        | exp '-' term     {$$ = $1 - $3;}
        ;
 term   : factor           {$$ = $1;}
        | term '*' factor  {$$ = $1 * $3;}
        | term '/' factor  {$$ = $1 / $3;}
        ;
 factor : number           {$$ = $1;}
        | '(' exp ')'      {$$ = $2;}
        ;
 %%

 int main (void) {return yyparse ( );}

 void yyerror (char *s) {fprintf (stderr, "%s\n", s);}
