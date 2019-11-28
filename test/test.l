%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h> 
    #include "test.tab.h"
%}

numbers [0-9]+
alpha [a-z]*

%%

{numbers} { yylval = atoi(yytext);
            return INTEGER; }

[-+*/] {return *yytext; }

"(" { return *yytext; }
")" { return *yytext; }
\n {return *yytext; }

%%
