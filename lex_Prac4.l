%{
#include <stdio.h>
%}
%%
[a-z]    { printf("%c", yytext[0] - 32); }
[A-Z]    { printf("%c", yytext[0] + 32); }
.        { printf("%c", yytext[0]); }
%%
int main() {
    yylex();
    return 0;
}

