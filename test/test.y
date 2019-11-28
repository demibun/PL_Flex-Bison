%{ 
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

     
%}

%token INTEGER

%%

testProgram: 
            line testProgram
            | line 
            ;

line: 
    expr '\n' {printf("%d\n", $1); }
    | '\n'
    ;

expr: 
    expr '+' mulex {$$ = $1 + $3;}
    | expr '-' mulex {$$ = $1 - $3;}
    | mulex {$$ = $1;}
    ;

mulex:
    mulex '*' mulex {$$ = $1 * $3;}
    | mulex '/' mulex {$$ = $1 / $3;}
    | term {$$ = $1;}
    ;

term:
    '(' expr ')' {$$ = $2;}
    | INTEGER {$$ = $1;}
 
%%

int main(int argc, char **argv) {
    yyparse();
}

yyerror(char *s)
{
    printf("%s\n", s);
    exit(1);
}
