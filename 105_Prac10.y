%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
int tempCount = 1;
char *newTemp();
%}
/* Define union for token values */
%union {
    char *str;
}
/* Token declarations with type */
%token <str> ID NUMBER
%token ASSIGN PLUS MINUS MULT DIV LPAREN RPAREN EOL
/* Precedence and associativity */
%left PLUS MINUS
%left MULT DIV
/* Non-terminal types */
%type <str> expr line
%%
input:
      /* empty */
    | input line
    ;
line:
      ID ASSIGN expr EOL    { printf("%s = %s\n", $1, $3); free($1); free($3); }
    | expr EOL              { printf("Result: %s\n", $1); free($1); }
    | EOL                   { /* ignore blank line */ }
    ;
expr:
      expr PLUS expr {
            char *temp = newTemp();
            printf("%s = %s + %s\n", temp, $1, $3);
            free($1); free($3);
            $$ = temp;
      }
    | expr MINUS expr {
            char *temp = newTemp();
            printf("%s = %s - %s\n", temp, $1, $3);
            free($1); free($3);
            $$ = temp;
      }
    | expr MULT expr {
            char *temp = newTemp();
            printf("%s = %s * %s\n", temp, $1, $3);
            free($1); free($3);
            $$ = temp;
      }
    | expr DIV expr {
            char *temp = newTemp();
            printf("%s = %s / %s\n", temp, $1, $3);
            free($1); free($3);
            $$ = temp;
      }
    | LPAREN expr RPAREN    { $$ = strdup($2); free($2); }
    | ID                    { $$ = strdup($1); free($1); }
    | NUMBER                { $$ = strdup($1); free($1); }
    ;
%%
char *newTemp() {
    char buffer[10];
    sprintf(buffer, "t%d", tempCount++);
    return strdup(buffer);
}
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int main() {
    printf("=== Intermediate Code Generator for Arithmetic Expressions ===\n");
    printf("Enter expressions (Ctrl+D to quit):\n\n");
    yyparse();
    return 0;
}
