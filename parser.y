%{ 
    #include <stdio.h>
    #include <stdlib.h>
    
    int yylex();
    void yyerror(char* s);

    FILE *yyin, *yyout;
%}

%token Integer 
%token int_prim
%token ID
%token Float 
%token float_prim
%token k_mainprog 
%token k_function 
%token k_procedeure 
%token k_begin 
%token k_end 
%token k_if 
%token k_then 
%token k_else 
%token k_nop 
%token k_while 
%token k_return 
%token k_print 
%token k_elif
%token k_for
%token k_in 
%token o_plus 
%token o_minus 
%token o_mul 
%token o_div 
%token o_small 
%token o_small_equal 
%token o_bigger_equal 
%token o_bigger 
%token o_equal 
%token o_not_equal 
%token o_not
%token d_semicolon 
%token d_dot 
%token d_rest 
%token d_substitute 
%token d_open_bracket 
%token d_close_bracket 
%token d_open_square_bracket 
%token d_close_square_bracket 
%token d_colon

%% 

program: k_mainprog ID d_semicolon declaration subprogram_declarations compound_statement { fprintf(yyout, "program started\n"); }
        ;


declaration: type identifier_list d_semicolon declaration {fprintf(yyout, "declaration\n");}
            | /* epsilon */ 
            ;

identifier_list: ID 
                | ID d_rest identifier_list
                ;

type: standard_type 
    | standard_type d_open_square_bracket Integer d_close_square_bracket
    ;

standard_type: int_prim | float_prim;

subprogram_declarations: subprogram_declaration subprogram_declarations {fprintf(yyout, "subprogram_declarations\n");}
                        | /* epsilon */
                        ;
                        
subprogram_declaration: subprogram_head declaration compound_statement;

subprogram_head: k_function ID arguments d_colon standard_type d_semicolon
                | k_procedeure ID arguments d_semicolon
                ;

arguments: d_open_bracket parameter_list d_close_bracket
        | /* epsilon */
        ;

parameter_list: identifier_list d_colon type 
                | identifier_list d_colon type d_semicolon parameter_list
                ;

compound_statement: k_begin statement_list k_end;

statement_list: statement 
                | statement d_semicolon statement_list
                ; 
statement: variable d_substitute expression
        | print_statement
        | procedure_statement
        | compound_statement
        | if_statement
        | while_statement
        | for_statement
        | k_return expression
        | k_nop
        ;

print_statement: k_print 
                | k_print d_open_bracket expression d_close_bracket {fprintf(yyout, "print\n");}
                ;

variable: ID {fprintf(yyout, "variable\n");}
        | ID d_open_square_bracket expression d_close_square_bracket
        ;

procedure_statement: ID d_open_bracket actual_parameter_expression d_close_bracket;

for_statement: k_for expression k_in expression d_colon statement else_statement {fprintf(yyout, "for statement\n");};

if_statement: k_if expression d_colon statement elif_statement else_statement {fprintf(yyout, "if statement\n");};

elif_statement: /* epsilon */  
              | k_elif expression d_colon statement elif_statement {fprintf(yyout, "elif statement\n");}
              ;

else_statement: /* epsilon */ {fprintf(yyout, "else statement\n");}
              | k_else d_colon statement {fprintf(yyout, "else statement\n");}
              ;

while_statement:  k_while expression d_colon statement else_statement {fprintf(yyout, "while statement\n");};

actual_parameter_expression:
                            | /* epsilon */
                            expression_list
                            ;

expression_list: expression {fprintf(yyout, "expression\n");}
                | expression d_rest expression_list
                ;
    
expression: simple_expression 
            | simple_expression relop simple_expression
            ;

simple_expression: term 
                | term addop simple_expression 
                ;

term: factor
    | factor multop term
    ;

factor: Integer 
      | Float
      | variable
      | procedure_statement
      | o_not factor
      | sign factor
      ;

sign: o_plus | o_minus;

relop: o_bigger 
     | o_bigger_equal 
     | o_small 
     | o_small_equal 
     | o_equal 
     | o_not_equal 
     | k_in
     ;

addop: o_plus | o_minus;

multop: o_mul | o_div;


%%

int main(int argc, char **argv) {

    yyout = fopen("result.txt", "w+");
    if (argc > 1) {
        yyin = fopen(argv[1], "r+");
        if(!yyin) {
            fprintf(stderr, "could not open %s", argv[1]);
            exit(1);
        }
        yyparse();
    }
}

void yyerror(char* s) {
    exit(1);
}
