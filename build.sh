#!/bin/sh -e
set -xe
CC=gcc
CFLAGS="-Wall -Wextra"
bison -d -Wcounterexamples parser.y
flex lexer.l
$CC $CFLAGS parser.tab.c lex.yy.c main.c -o parser
./parser test.tex

