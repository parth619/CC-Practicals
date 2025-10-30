%{
#include <stdio.h>
#include <stdlib.h>

void printHex(int num) {
    if (num == 0) {
        printf("0");
        return;
    }

    char hex[20];
    int i = 0;

    while (num > 0) {
        int rem = num % 16;
        if (rem < 10)
            hex[i++] = rem + '0';
        else
            hex[i++] = rem - 10 + 'A';
        num /= 16;
    }

    for (int j = i - 1; j >= 0; j--)
        putchar(hex[j]);
    putchar('\n');
}
%}

%%
[0-9]+ {
    int num = atoi(yytext);
    printHex(num);
}
\n     { }
.      { }
%%

int main() {
    yylex();
    return 0;
}
