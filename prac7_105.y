%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
int result;
int valid = 1;  // assume valid unless proven otherwise
%}
%token NUMBER
%%
input:
    expr { result = $1; }
    ;
expr:
    expr expr '+' { $$ = $1 + $2; }
  | expr expr '-' { $$ = $1 - $2; }
  | expr expr '*' { $$ = $1 * $2; }
  | expr expr '/' {
        if ($2 == 0) {
            printf("Error: Division by zero!\n");
            valid = 0;
            $$ = 0;
        } else {
            $$ = $1 / $2;
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
    printf("Enter postfix expression:\n");
    if (yyparse() == 0 && valid) {
        printf("Valid Postfix Expression\n");
        printf("Result = %d\n", result);
    } else {
        printf("Invalid Postfix Expression\n");
    }
    return 0;
}

