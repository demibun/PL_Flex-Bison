// Prologue - 함수 정의, 매크로 함수 정의, grammar rules에서 사용될 변수 정의

%{  
    #include <stdio.h>
%}

/* Bison declarations - terminal, non-terminal 심볼에 대한 정의 포함
ex) %union - sementic value를 위한 공용체. C의 union과 동일.

    %require "version" - "version"에 표기된 bison 버젼으로 문법 진행. 
                          일치하지 않을 시 에러를 띄우며 종료.

    %token name - 가장 기본적인 토큰을 선언하는 방식. yylex()에 자동으로
                  '토큰 code 번호 #define' 형태로 생성해줌.
                    ex) %token arrow "=>" : string 형태의 토큰 선언
                        %token <val> : NUM NUM이 val타입으로 선언

    %left, %right, %nonassoc - 결합방향 정의. nonassoc은 결합법칙 적용x
                            ex) %left '+' '-'
                                %left '*' '/'
                                %right '='
                                %nonassoc UMINUS
                            -> '+', '-', '*', '/', '=' 의 우선순위는 +, -가
                                가장 낮고, *, /이 다음, =이 그 다음,
                                부호연산자(UMINUS) 순서로 우선순위 적용.
                                또한 사칙연산은 왼쪽으로 결합법칙, = 는 우측으로
                                결합법칙.                     

    %type <type> name - name을 <type>으로 type 정의

    등등         

    http://www.gnu.org/software/bison/manual/html_node/Declarations.html#Declarations

    에 가면 자세히 기술되어 있음.

*/

/* 
Grammar rules - 하나 이상의 Bison문법 규칙이 존재. 첫 번째 %% 이후에 시작되며
하나 이상의 문법이 필수.

형태 - result : components ... ;
* result는 규칙을 정의하는 non-terminal symbol
* components는 terminal과 non-terminal 모두 포함
* 이 때 symantics룰에 부합하면 action을 취할 수 있음.
* action은 
    { C statements }
    와 같이 C로 구성된 명령 수행.
* 만약 result가 다수의 규칙을 따른다면, | 를 통해 표시

    ex) result:
            rule1-comp...
            | rule2-comp...
            | ...
            ;

* Recursive rules: non-terminal symbol로 시작해 위에서 아래로 분리하는 
                    Top-Down Approach 방식으로 수행됨. 이 때 자기자신이 
                    Grammar요소에 하나씩 포함되어 있는 경우

                    ex) 
                    -left recursion
                    expseq1:
                        exp
                        | expseq1 ',' exp
                        ;
                    
                    -right recursion
                    expseq1:
                        exp
                        | exp ',' expseq1
                        ;

*/

%% 

%%

/* Epilogue: 시작할 때 parser implementation file에 복사됨. 
             이 때 yylex와 yyerror와 같은 이미 정의된 함수의 사용을 필요로
             한다면 이미 정의가 되어 있더라도, 함수를 선언하고 사용해야 함.
             Bison parser은 'yy'나 'YY'로 시작되는 매크로, 식별자를 가진다.
             따라서 변수 이름을 지을 때 이러한 규칙은 피해야 함. 이러한 미리
             정의되어 있는 함수들이나 변수들을 C-language Interface라 함.
             
             ex) 
                (1) Function int yyparse(void): token을 읽고, action을 실행시키고,
                    파일의 끝을 만나거나 syntex error가 발생하면 return을 시켜줌.
                    yyparse 함수는 int형을 반환하며, 만약 에러 없이 값이 잘 반환되면
                    0을 리턴함. error발생 시 syntax에러이면 1을 반환하고, 메모리문제이면
                    2를 반환.
                        main(){
                            yyparse();
                         }

                 (2) yylex(): lexical analzer 함수로 input stream으로부터 들어온 토큰을
                              알아보고,         

*/           

