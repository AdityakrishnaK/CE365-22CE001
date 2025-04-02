%option noyywrap
%{
    #include <stdio.h>
    #include <string.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9]*     { printf("%s is an identifier.\n", yytext); }

[0-9]+\.[0-9]+           { printf("%s is a float constant.\n", yytext); }

[0-9]+                   { printf("%s is an integer constant.\n", yytext); }

(==|&&|>=|<=|>|<|=|\+|-|\|\||\||\*|/|%|\+\+|--|!|\^)   { printf("%s is an operator.\n", yytext); }

[(){}\[\],:;?.'"\\]      { printf("%s is a punctuation symbol.\n", yytext); }

(auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|
int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|
volatile|while)    { printf("%s is a keyword.\n", yytext); }

//.*                   { printf("%s is a single-line comment.\n", yytext); }

/\*[^*]*\*+([^/*][^*]*\*+)*/    { printf("%s is a multi-line comment.\n", yytext); }

[ \t\n]+               ;

%%

int main() {
    yyin = fopen("input.c", "r");
    if (!yyin) {
        perror("Error opening file");
        return 1;
    }
    yylex();
    fclose(yyin);
    return 0;
}

int yywrap() {
    return 1;
}