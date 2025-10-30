%{
#include<stdio.h>
int a_word_count = 0;
%}

%%
[aA][a-zA-Z]*   { a_word_count++; }
[a-zA-Z]+       { }
[ \t\n]+        { }
%%

int main() {
    yylex();
    printf("Number of words starting with 'a' or 'A' : %d\n", a_word_count);
    return 0;
}
