%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
[ \t\n]     ; // ignore spaces, tabs, newlines
.           { return yytext[0]; }

%%
int yywrap() { return 1; }

