%{
#include <stdio.h>
#include <string.h>
#include "ask_1.tab.h"
void showError();
void remove_quotes(char* string);
%}

%option yylineno
%option noyywrap

number			([-"0-9]*)
string			([" _,!a-zA-Z0-9]*)

%%
	
"<!--"						{printf("%s", yytext); return (COMMENT_START);}
"-->"						{printf("%s", yytext); return (COMMENT_END);}
"<LinearLayout"				{printf("%s", yytext); return (LINEAR_LAYOUT);}
"<RelativeLayout"			{printf("%s", yytext); return (RELATIVE_LAYOUT);}
"<TextView"					{printf("%s", yytext); return (TEXT_VIEW);}
"<ImageView"				{printf("%s", yytext); return (IMAGE_VIEW);}
"<Button"					{printf("%s", yytext); return (BUTTON);}
"<RadioGroup"				{printf("%s", yytext); return (RADIO_GROUP);}
"<RadioButton"				{printf("%s", yytext); return (RADIO_BUTTON);}
"<ProgressBar"				{printf("%s", yytext); return (PROGRESS_BAR);}
"android:layout_width="		{printf("%s", yytext); return (LAYOUT_WIDTH);}
"android:layout_height="	{printf("%s", yytext);; return (LAYOUT_HEIGHT);}
"android:id="				{printf("%s", yytext); return (ANDR_ID);}
"android:bnum="				{printf("%s", yytext); return (BUTTON_NUMBER);}
"android:orientation="		{printf("%s", yytext); return (ORIENTATION);}
"android:text="				{printf("%s", yytext); return (TEXT);}
"android:src="				{printf("%s", yytext); return (SRC);};
"android:textColor="		{printf("%s", yytext); return (TEXT_COLOR);}
"android:padding="			{printf("%s", yytext); return (PADDING);}
"android:progress="			{printf("%s", yytext); return (PROGRESS);}
"android:max="				{printf("%s", yytext); return (MAX);}
"android:checkedbutton="	{printf("%s", yytext); return (CHECKED_BUTTON);}
">"							{printf("%s", yytext); return (TAG_CLOSED);}
"</LinearLayout"			{printf("%s", yytext); return (LINEAR_ENDED);}
"</RelativeLayout"			{printf("%s", yytext); return (RELATIVE_ENDED);}
"</RadioGroup"				{printf("%s", yytext); return (RADIO_ENDED);}
"\"wrap_content\""			{printf("%s", yytext); return (WRAP_CONTENT);}
"\"match_parent\""			{printf("%s", yytext); return (MATCH_PARENT);}
"/>"						{printf("%s", yytext); return (SELF_CLOSING);}
{number}   					{printf("%s", yytext); remove_quotes(yytext); yylval.number=atoi(yytext);  return (NUM);}
{string}					{printf("%s", yytext); sscanf(yytext,"%s",yylval.id); return (STRING);}
"\n"						{printf("%s", yytext); }
"\t"						{}
<<EOF>>						{return 0;}
.      		    		    {}


%%


void remove_quotes(char* string)
{
	int j = 0;
	int len = strlen(string);
	for (int i = 0; i < len; i++)
	{
		if (string[i] != '"')
		{
			string[j++]=string[i];
		}
	}
	string[j] = '\0';
}


