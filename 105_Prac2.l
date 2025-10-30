%{
#include <stdio.h>
#include <string.h>

int lc = 0, wc = 0, cc = 0, sc = 0, tc = 0, kw = 0, id = 0;
char *keywords[] = {
    "int", "float", "while", "do", "for", "if", "else",
    "switch", "case", "break", "continue", "char",
    "double", "long", "short", "typedef", "static",
    "enum", "const", "signed", "unsigned", "void",
    "struct", "union"
};

int is_keyword(char *text) {
    for (int i = 0; i < sizeof(keywords)/sizeof(keywords[0]); i++) {
        if (strcmp(text, keywords[i]) == 0)
            return 1;
    }
    return 0;
}
%}

%%
\n          { lc++; }
" "         { sc++; }
\t          { tc++; }
[a-zA-Z_][a-zA-Z0-9_]*  {
                if (is_keyword(yytext))
                    kw++;
                else
                    id++;
            }
.           { cc++; }
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter the input (Ctrl+D to end):\n");
    yylex();

    printf("\n--- Count Summary ---\n");
    printf("Lines      : %d\n", lc);
    printf("Spaces     : %d\n", sc);
    printf("Tabs       : %d\n", tc);
    printf("Characters : %d\n", cc);
    printf("Keywords   : %d\n", kw);
    printf("Identifiers: %d\n", id);

    return 0;
}

