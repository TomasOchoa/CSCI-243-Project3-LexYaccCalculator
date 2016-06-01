%{
#include <stdio.h>
#include "y.tab.h"
int hex;
%}

%%

[Hh]				  {if(hex)
					   {
							hex = 0;
							printf("Calculator in dec format...\n");		
					   }
					   else
					   {
						   hex = 1;
						   printf("Calculator now in hex mode...\n");
					   }
					  }

[0-9a-fA-F]+          {if(hex)
							yylval.a_number = htoi(yytext);
					   else
							yylval.a_number = atoi(yytext);
					   return number;
					  }
[ \t\n]               ;
[-+*/();]             {return yytext[0];}
.                     {ECHO; yyerror ("Unexpected character!");}

%%

int yywrap (void) {return 1;}

int htoi(char data[])
{
	// Necessary variable declarations
	int value = 0;
	int i = 0; 
	
	//While the data in element i doesnt equal EOF (end of file)
	while(data[i]!= '\0')
	{
		if(data[i] >= '0' && data[i] <= '9')
		{
			value = value * 16 + data [i] - '0';
		}
		else if(data[i] >= 'A' && data[i] <= 'F')
		{
			value = value * 16 + data[i] - 'A' + 10;
		}
		else if(data[i] >= 'a' && data[i] <= 'f')
		{
			value = value * 16 + data[i] - 'a' + 10;
		}
		else
		{
			printf(yyerror);
		}
	}
	return value;
}