%{
#include "y.tab.h"
#include <string.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+                   { yylval.str = strdup(yytext); return NUMBER; }
"="                      { return ASSIGN; }
"+"                      { return PLUS; }
"-"                      { return MINUS; }
"*"                      { return MULT; }
"/"                      { return DIV; }
"("                      { return LPAREN; }
")"                      { return RPAREN; }
\n                       { return EOL; }
[ \t]+                   ;      /* ignore whitespace */
.                        { printf("Unknown character: %s\n", yytext); }
%%

int yywrap() { return 1; }
