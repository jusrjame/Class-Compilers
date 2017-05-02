//Justin James
// 4/20/2017

%{
#include <iostream>
#include <cstdio>
  
using namespace std;

  extern int yylex();
  //extern FILE *yyin();
  
  void yyerror(const char *s) {printf("ERROR: %s\n", s);}
%}

%start program
   
%token LSQB RSQB
%token EOL
%token INT FLOAT ID
%token INTEGER REAL
%token IF RET
%token LEQ GEQ EQ NEQ LT GT
%token LPAREN RPAREN
%token LCURL RCURL
%token PEQ MEQ TEQ DEQ PLUS SUB DIV MUL

%{
  #include <FlexLexer.h>
  FlexLexer* lexer = new yyFlexLexer;
  #undef yylex
  #define yylex lexer->yylex
%}

%%

program:
statments  {cout << "this works";}
;

statments:
stmt statments   //{cout << "this works";}  
| /* empty */
;

stmt:
variableDec  //{cout << "this works";}
| functionDec 
| expression EOL
| RET expression EOL
;

variableDec:
type  ID '=' term EOL   //{cout << "this works";}
| type ID EOL
;

type:
FLOAT  //{cout << "this works";}
| INT
;

term:
ID  //{cout << "this works";}
| INTEGER
| REAL
;


// this guy is gonna be a problem
functionDec:
type ID LPAREN params RPAREN LCURL statments RCURL
;

params:
type ID  //{cout << "this works";}
|type ID "," params
|/* empty */
;
 
expression: T Eprime //{cout << "this works";};

Eprime: '+' T Eprime| /* empty */;

T: F Tprime;

Tprime: '*' F Tprime | /* empty */;

F: A Fprime;

Fprime: '-' A Fprime | /* empty */;

A: B Aprime;

Aprime: '/' B Aprime | /* empty */;

B: LPAREN expression RPAREN | term;
%%

