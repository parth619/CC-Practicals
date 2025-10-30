%{
#include <stdio.h>
%}

%%
.*com { printf("Ends with com: %s\n", yytext); }
.*    { printf("Does not end with com\n"); }
%%

int main() {
    yylex();
    return 0;
}
