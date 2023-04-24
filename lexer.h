#ifndef LEXER_H
#define LEXER_H

#include <stdlib.h>
#include <stdio.h> 
#include <errno.h>
#include <string.h>
#include <assert.h>


typedef enum {
    TOK_WORD = 1,
    TOK_NUM,
} TokenType;

typedef union {
    char* str;
    int num;
} TokenValue;

extern TokenValue yylval;

int yylex();
int yywrap();
extern FILE* yyin;

#endif /* LEXER_H */
