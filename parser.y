%{
#include<ctype.h>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
FILE *file ;
extern char * yytext;
char arr[100]="",arr1[100]="";
int section1 = 0, subsection = 0, issection;
FILE *fp;
void write_to_file();

struct node {
		struct node* left;
		char value[100000];
		struct node* right;
		struct node* sibling;
};

struct node* createnode(struct node* left, char val[], struct node* right)
{
	int len=0;
	struct node *node = (struct node*)malloc(sizeof(struct node));
	node->left = left;
	node->right = right;
	node->sibling = NULL;
	len=strlen(val);
	memcpy(node->value,val,len);
	//node->value = val; 
	return node;

}
struct node* createsiblingnode(struct node* left, char val[], struct node* right,struct node* sibling)
{
	int len=0;
	struct node *node = (struct node*)malloc(sizeof(struct node));
	node->left = left;
	node->right = right;
	node->sibling = sibling;
	len=strlen(val);
	memcpy(node->value,val,len);
	//node->value = val; 
	return node;

}




void print(struct node* node)
{
 if(node==NULL)
	return;
else
	{
	fprintf(file,"%s",node->value);
	}
}
%}

%union 
{
  	char*	arr;
  	int	val;
        struct node* node;
 
} 

%start latexstatement
%token DOCUMENTCLASS BEGINDOC ENDDOC TITLE  MAKETITLE PARAGRAPH  LCURLYB RCURLYB LBRACKET RBRACKET
%token BEGINENUM ENDENUM ITEM LABEL CAPTION 
%token BEGINTABLE BEGINTABULAR HLINE AMPERSAND NEWLINE ENDTABLE ENDTABULAR
%token PIPE
%token <arr> LETTERS WORD
%type <node> latexstatement body options  textoption  paragraph listitem enumoption caption 
%type <node>     tablerow hline tabularbody endtabular starttabular tablebody table
%type <arr> word  letters

%%
word : WORD
letters: LETTERS

latexstatement   :  DOCUMENTCLASS
			{
				fprintf(file,"start document and body \n");
			} 
			BEGINDOC
			{
				printf("\nIn Begin Document\n");				
				fprintf(file,"start document\n");
				fprintf(file,"headers and objects\n");
				fprintf(file,"satrt body\n");
			} body ENDDOC
			{
				fprintf(file,"start document tag\n"); 
			}
			{
				fprintf(file,"end document tag"); 
				char buff[200000];
				$$ = createnode ($5,buff,NULL);

				char htmlBuff[200000];
				print($$);
			}
		  ;
body         	 :  body options
			{ 		printf("\nIn Body\n");
					char buff[200000];
					$$ = createnode($1,buff,$2);

					
			}
		 |  options
			{ 
					printf("\nIn Options\n");
					char buff[100000];
					printf("$1->value is %s\n",$1->value);					
					$$ = createnode($1,buff,NULL);
					
			}
		 ;


options		 :table 
			{ 
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		 |  paragraph
			{ 
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		 |  textoption
			{ 
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		 |  enumoption
			{ 
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		 |  listitem
			{ 
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		 |  caption
			{ 
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		;
paragraph 	 : PARAGRAPH LCURLYB
			{
				fprintf(file,"paragraph start");
			} textoption RCURLYB
			{
				fprintf(file,"paragraph end \n");
				char buff[100000];
				$$ = createnode(NULL,buff,$4);
			}
		 ;



enumoption	 : BEGINENUM 
			{
				fprintf(file,"\nstariting tag of list \n"); 
			} listitem ENDENUM 
			{
				fprintf(file,"\nend tag of list \n");
				char buff[100000];
				$$ = createnode(NULL,buff,$3);
			}
		 

		 ;


listitem         : listitem ITEM textoption 
			{
				char buff[100000];
				printf("1------in listitem buff is %s\n",buff);
				$$ = createnode($1,buff,$3);

			}
			|
		   ITEM textoption
			{

				char buff[100000];
				printf("1------in listitem buff is %s\n",buff);
				$$ = createnode(NULL,buff,$2);
			}
			
		 ;
caption		 : CAPTION LCURLYB 
		 {
			fprintf(file,"\ncaption &nbsp;&nbsp;&nbsp");
		 }
		 textoption RCURLYB 
		{
			fprintf(file,"caption");
			char buff[100000];
			$$ = createnode(NULL,buff,$4);
		}	
		;

table		 :  BEGINTABLE caption tablebody ENDTABLE
			{
			  char buff[100000];
			  $$ = createnode($2,buff,$3);
			}
		 | BEGINTABLE tablebody ENDTABLE
			{
			  char buff[100000];
			  $$ = createnode($2,buff,NULL);
			
			}
		 ;



tablebody	 : starttabular tabularbody endtabular
			{
			  char buff[100000];
			  printf("\n$2 for table is -----%s----------\n",$2->value);
			  $$ = createsiblingnode($1,buff,$2,$3);				
			}
		 ;

starttabular 	 : BEGINTABULAR 
			{
			printf("MARKER -1"); 
			  char buff[100000];			
			  $$ = createnode(NULL,buff,NULL);
				
			} 
		 ;

endtabular 	 : ENDTABULAR 
			{
			  fprintf(file,"table end \n");
			printf("MARKER 0"); 
			  char buff[100000];
			  $$ = createnode(NULL,buff,NULL); 
			}
		 ;



tabularbody	 : hline  tablerow tabularbody
		   {
			printf("MARKER 1"); 
			  fprintf(file,"table row with header ");
			  char buff[100000];
			  $$ = createsiblingnode($1,buff,$2,$3);
			  
		   }
		 |
		  {
			printf("MARKER 2");
			  char buff[100000];
		          $$ = createnode(NULL,buff,NULL);
		  }
		 ;


hline 		 :  HLINE hline 
			{
				printf("MARKER 3");
 			  char buff[100000];
		          $$ = createnode(NULL,buff,$2);
			}
		 |
			{
			   char buff[100000];
			  printf("\nIn Ebsilon\n");
		          $$ = createnode(NULL,buff,NULL);
			}
		 ;

tablerow	 : textoption AMPERSAND {
					fprintf(file," table start >"); 
					} 
		   tablerow
		   {
			char buff[100000];
   			$$ = createnode($1,buff,$4);
		   }
		 | textoption NEWLINE 
		   {
			char buff[100000];
   			$$ = createnode($1,buff,NULL);
		   }
		 ;

textoption 	 : textoption word
			{
				fprintf(file,"%s ",yytext);
				char buff[100000];
				$$ = createnode($1,buff,NULL);
				
			}
		 |  textoption letters
			{
				fprintf(file,"%s ",yytext);
				char buff[100000];
				$$ = createnode($1,buff,NULL);
			}
		 | word {
				fprintf(file,"%s ",yytext);
				char buff[100000];
				$$ = createnode(NULL,buff,NULL);
			}
		| letters {
				fprintf(file,"%s ",yytext);
				char buff[100000];
				$$ = createnode(NULL,buff,NULL);
			  }
		;

%% 

/* int main(int argc, char *argv[]) */
/* { */
/*     char fname[100]; */
/*     strcpy(fname, argv[1]); */
/*     file = fopen(fname,"w"); */
/*     if (file == NULL) */
/*         printf("Couldnot open the file\n"); */
/*     return yyparse(); */
/* } */

int yyerror (char *msg) {
    fprintf(file,"ERROR");    
	return fprintf (stderr, "YACC: %s\n ", msg);
}
