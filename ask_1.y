%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
int yylex();
extern char* yytext;
extern int yylineno;
void yyerror(char const *s);
void fanction(char id[60]);
void fanction2(char id[60]);
void fanction3(char id[60]);
void fanction4();
void fanction5();
extern FILE *yyin;
int count=0;
int empRadio=0;

%}

%type <id> STRING
%type <number> NUM
%union {char id[60]; int number;}
%define parse.lac full
%define parse.error verbose
%token STRING NUM ID COMMENT_START
%token COMMENT_END LINEAR_LAYOUT RELATIVE_LAYOUT TEXT_VIEW
%token IMAGE_VIEW BUTTON RADIO_GROUP RADIO_BUTTON
%token PROGRESS_BAR LAYOUT_WIDTH LAYOUT_HEIGHT ANDR_ID
%token ORIENTATION TEXT TEXT_COLOR PADDING
%token PROGRESS MAX CHECKED_BUTTON TAG_CLOSED
%token OTHER SELF_CLOSING SRC
%token LINEAR_ENDED RELATIVE_ENDED RADIO_ENDED
%token MATCH_PARENT WRAP_CONTENT BUTTON_NUMBER


%%

program: {fanction5();} stmts		{printf("\nThe XML file is properly formatted!");}
		;

stmts: LINEAR_LAYOUT linear_layout 
		|  RELATIVE_LAYOUT relative_layout 
		| COMMENT_START comment stmts
		;
		
values: WRAP_CONTENT | MATCH_PARENT | NUM ;
		
linear_layout: 
		LAYOUT_WIDTH values LAYOUT_HEIGHT values TAG_CLOSED linear_check LINEAR_ENDED TAG_CLOSED
		| LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);} TAG_CLOSED linear_check LINEAR_ENDED TAG_CLOSED
		| LAYOUT_WIDTH values LAYOUT_HEIGHT values ORIENTATION STRING TAG_CLOSED linear_check LINEAR_ENDED TAG_CLOSED
		| LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);} ORIENTATION STRING TAG_CLOSED linear_check LINEAR_ENDED TAG_CLOSED
		;


relative_layout: 
		LAYOUT_WIDTH values LAYOUT_HEIGHT values TAG_CLOSED layout_content RELATIVE_ENDED TAG_CLOSED
		| LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);} TAG_CLOSED layout_content RELATIVE_ENDED TAG_CLOSED
		;
		
linear_check:  
		{yyerror("\nLinear Layout is empty"); return 0;} 
		| layout_content;
	
layout_content: 
			  LINEAR_LAYOUT linear_layout layout_content
			  | RELATIVE_LAYOUT relative_layout layout_content
			  | COMMENT_START comment layout_content
			  | TEXT_VIEW text_view SELF_CLOSING layout_content
			  | IMAGE_VIEW image_view SELF_CLOSING layout_content
			  | BUTTON button SELF_CLOSING layout_content
			  | RADIO_GROUP {fanction4();} radio_group layout_content
			  | PROGRESS_BAR progress SELF_CLOSING layout_content
			  |
			  ;
			  
comment: 
		STRING COMMENT_END
		;
		
text_view: 
		 LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING ANDR_ID STRING {fanction($8);}
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING TEXT_COLOR STRING
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING ANDR_ID STRING {fanction($8);} TEXT_COLOR STRING
		 ;

image_view: 
		 LAYOUT_WIDTH values LAYOUT_HEIGHT values SRC STRING
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values SRC STRING ANDR_ID STRING   {fanction($8);}
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values SRC STRING PADDING NUM 		{if($8<1) {yyerror("\nPadding must be a positive integrer "); return 0;}}
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values SRC STRING ANDR_ID STRING   {fanction($8);} PADDING NUM {if($11<1) {yyerror("\nPadding must be a positive integrer "); return 0;}}
		 ;
		 
button: 
		 LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING ANDR_ID STRING 	{fanction($8);} PADDING NUM {if($11<1) {yyerror("\nPadding must be a positive integrer "); return 0;}}
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING ANDR_ID STRING 	{fanction($8);}
		 | LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING PADDING NUM     {if($8<1)  {yyerror("\nPadding must be a positive integrer "); return 0;}}
		 ;
		 
progress: 
		  LAYOUT_WIDTH values LAYOUT_HEIGHT values
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);}
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values MAX NUM
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values PROGRESS NUM
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values MAX NUM PROGRESS NUM {if($8<0 || $8>$6) {yyerror("\nProgress bar doesn't respect limit conditions "); return 0;}}
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);} MAX NUM PROGRESS NUM {if($11<0 || $11>$9) {yyerror("\nProgress bar doesn't respect limit conditions "); return 0;}}
		  ; 


		 
radio_group: 
		  LAYOUT_WIDTH values LAYOUT_HEIGHT values TAG_CLOSED radio_check BUTTON_NUMBER NUM {if(count!=$8) {yyerror("\nWrong Count "); return 0;} count=0;} RADIO_ENDED TAG_CLOSED
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);} TAG_CLOSED radio_check BUTTON_NUMBER NUM {if(count!=$11) {yyerror("\nWrong Count "); return 0;} count=0;} CHECKED_BUTTON STRING {fanction3($14);} RADIO_ENDED TAG_CLOSED
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values ANDR_ID STRING {fanction($6);} TAG_CLOSED radio_check BUTTON_NUMBER NUM {if(count!=$11) {yyerror("\nWrong Count "); return 0;} count=0;} RADIO_ENDED TAG_CLOSED
		  | LAYOUT_WIDTH values LAYOUT_HEIGHT values TAG_CLOSED radio_check BUTTON_NUMBER NUM {if(count!=$8){yyerror("\nWrong Count "); return 0;} count=0;} CHECKED_BUTTON STRING {fanction3($11);} RADIO_ENDED TAG_CLOSED
		  ; 
		  
radio_check: 
		{ if(empRadio==0){yyerror("\nRadio Group is empty "); return 0;} } 
		| {empRadio=1;} radio_content; 

radio_content: 
			 RADIO_BUTTON LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING {count++;} SELF_CLOSING radio_check
			 | RADIO_BUTTON LAYOUT_WIDTH values LAYOUT_HEIGHT values TEXT STRING ANDR_ID STRING {fanction($9); fanction2($9); count++;} SELF_CLOSING radio_check
			 | COMMENT_START comment radio_check
			 ;		

%%


void fanction(char id[60]){

	FILE *unique;
	char str[60];
	int flag=0;
	//open file
	unique = fopen("unique.txt", "a+");
	if(unique==NULL){
		perror("Error opening file");
		return;
	}
	
	//compare
	strcat(id,"\n");
	while(fgets(str,60,unique)!=NULL){
	/* edo den ftanei pote */
	printf("12345678 ");
	if(strcmp(id,str)==0){
		printf("WRONG");
		flag=1;
		break;
		}
	}
	
	if(flag==1){yyerror("\nId already exists "); exit(0);
	}

	//write file
	if(flag==0){fprintf(unique,"%s",id);
	}
	
	//close file
	fclose(unique);

}

void fanction2(char id[60]){

	FILE *buttonf;
	char str[60];
	int flag=0;
	//open file
	buttonf = fopen("button.txt", "a+");
	if(buttonf==NULL){
		perror("Error opening file");
		return;
	}
	//compare
	strcat(id,"\n");
	while(fgets(str,60,buttonf)!=NULL){
	if(strcmp(id,str)==0){
		flag=1;
		break;
		}
	}

	//write file
	if(flag==0){
	fprintf(buttonf,"%s",id);}
	
	
	//close file
	fclose(buttonf);

}
void fanction3(char id[60]){

	FILE *buttonf;
	char str[60];
	int flag=0;
	//open file
	buttonf = fopen("button.txt", "r");
	if(buttonf==NULL){
		perror("Error opening file");
		return;
	}
	//compare
	strcat(id,"\n");
	while(fgets(str,60,buttonf)!=NULL){
	if(strcmp(id,str)==0){
		flag=1;
		break;
		}
	}

	//write file
	if(flag==0){ yyerror("\nThis button doesn't exist"); exit(0);}
	
	
	//close file
	fclose(buttonf);

}
void fanction4(){
FILE *buttonf;
buttonf = fopen("button.txt", "w");
fclose(buttonf);
}

void fanction5(){
FILE *unique;
unique = fopen("unique.txt", "w");
fclose(unique);
}

void yyerror (char const *s)
{
	printf("%s on line %d - %s\n", s, yylineno, yytext);
	return;
}

int main ( int argc, char **argv) 
 {
  ++argv; --argc;
  if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
  if(yyin == NULL){
		perror ("Error opening file");
		return -1; }
  yyparse();	  
  return 0;
 }   
