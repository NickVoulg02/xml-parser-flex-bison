/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ASK_1_TAB_H_INCLUDED
# define YY_YY_ASK_1_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    STRING = 258,                  /* STRING  */
    NUM = 259,                     /* NUM  */
    ID = 260,                      /* ID  */
    COMMENT_START = 261,           /* COMMENT_START  */
    COMMENT_END = 262,             /* COMMENT_END  */
    LINEAR_LAYOUT = 263,           /* LINEAR_LAYOUT  */
    RELATIVE_LAYOUT = 264,         /* RELATIVE_LAYOUT  */
    TEXT_VIEW = 265,               /* TEXT_VIEW  */
    IMAGE_VIEW = 266,              /* IMAGE_VIEW  */
    BUTTON = 267,                  /* BUTTON  */
    RADIO_GROUP = 268,             /* RADIO_GROUP  */
    RADIO_BUTTON = 269,            /* RADIO_BUTTON  */
    PROGRESS_BAR = 270,            /* PROGRESS_BAR  */
    LAYOUT_WIDTH = 271,            /* LAYOUT_WIDTH  */
    LAYOUT_HEIGHT = 272,           /* LAYOUT_HEIGHT  */
    ANDR_ID = 273,                 /* ANDR_ID  */
    ORIENTATION = 274,             /* ORIENTATION  */
    TEXT = 275,                    /* TEXT  */
    TEXT_COLOR = 276,              /* TEXT_COLOR  */
    PADDING = 277,                 /* PADDING  */
    PROGRESS = 278,                /* PROGRESS  */
    MAX = 279,                     /* MAX  */
    CHECKED_BUTTON = 280,          /* CHECKED_BUTTON  */
    TAG_CLOSED = 281,              /* TAG_CLOSED  */
    OTHER = 282,                   /* OTHER  */
    SELF_CLOSING = 283,            /* SELF_CLOSING  */
    SRC = 284,                     /* SRC  */
    LINEAR_ENDED = 285,            /* LINEAR_ENDED  */
    RELATIVE_ENDED = 286,          /* RELATIVE_ENDED  */
    RADIO_ENDED = 287,             /* RADIO_ENDED  */
    MATCH_PARENT = 288,            /* MATCH_PARENT  */
    WRAP_CONTENT = 289,            /* WRAP_CONTENT  */
    BUTTON_NUMBER = 290            /* BUTTON_NUMBER  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 23 "ask_1.y"
char id[60]; int number;

#line 102 "ask_1.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ASK_1_TAB_H_INCLUDED  */
