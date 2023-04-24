#include "lexer.h"

void usage(FILE *file, char *program){
  fprintf(file, "USAGEs: %s <input.tex>\n", program);
}

int main(int argc, char **argv) {
    (void)argc;
    assert(*argv != NULL);
    char *program = *argv++;
    if(*argv == NULL){
      usage(stderr, program);
      fprintf(stderr, "ERROR: No input file is provided.\n");
      exit(1);
    }

    char *input_filepath = *argv++;
    printf("Inspected file is: %s\n", input_filepath);
    FILE *input_file = fopen(input_filepath, "r");

    if (input_file == NULL) {
        fprintf(stderr, "ERROR: could not open input file '%s': %s\n", input_filepath, strerror(errno));
        exit(1);
    }

    yyin = input_file;
    int token;
    while ((token = yylex()) != 0) {
      //printf("Token: %d\n", token);
    }

    fclose(input_file);
    return 0;
}
