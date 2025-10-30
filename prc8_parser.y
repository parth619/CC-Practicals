%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
int result;
int valid = 1;
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%%
input:
    expr { result = $1; }
    ;
expr:
    expr '+' expr { $$ = $1 + $3; }
  | expr '-' expr { $$ = $1 - $3; }
  | expr '*' expr { $$ = $1 * $3; }
  | expr '/' expr {
        if ($3 == 0) {
            printf("Error: Division by zero!\n");
            valid = 0;
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
  | NUMBER { $$ = $1; }
  ;
%%
void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
    valid = 0;
}
int main() {
    printf("Enter infix arithmetic expression:\n");
    if (yyparse() == 0 && valid) {
        printf("Valid Expression\n");
        printf("Result = %d\n", result);
    } else {
        printf("Invalid Expression\n");
    }
    return 0;
}

