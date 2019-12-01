%option noyywrap
%option yylineno

%{
  
    #include <stdio.h>
    #include <string.h>
    #include "parser.tab.h"

%}

Integer [0-9]+
ID [a-zA-Z](([a-zA-Z])|([0-9]))*
Float [-+]?[0-9]*\.[0-9]+

%%

"mainprog" {return k_mainprog;}
"function"  {return k_function;}
"procedure" {return k_procedeure;}
"begin" {return k_begin;}
"end" {return k_end;}
"if" {return k_if;}
"in" {return k_in;}
"for" {return k_for;}
"then" {return k_then;}
"else" {return k_else;}
"elif" {return k_elif;}
"nop" {return k_nop;}
"while" {return k_while;}
"return" {return k_return;}
"print" {return k_print;}

"+" {return o_plus;}
"-" {return o_minus;}
"*" {return o_mul;}
"/" {return o_div;}
"<" {return o_small;}
"<=" {return o_small_equal;}
">=" {return o_bigger_equal;}
">" {return o_bigger;}
"==" {return o_equal;}
"!=" {return o_not_equal;}
"!" {return o_not;}

";" {return d_semicolon;}
"." {return d_dot;}
"," {return d_rest;}
"=" {return d_substitute;}
"(" {return d_open_bracket;}
")" {return d_close_bracket;}
"[" {return d_open_square_bracket;}
"]" {return d_close_square_bracket;}
":" {return d_colon;}

"int" {return int_prim;}
"float" {return float_prim;}

" " ;
[ \t] ;
\n ;
"//".* ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] ;
{Integer} {return Integer;}
{ID} {sscanf(yytext, "%s", yylval.str); return ID;}
{Float} {return Float;}


%%
