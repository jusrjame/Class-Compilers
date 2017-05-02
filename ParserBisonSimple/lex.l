%{

#include <iostream>
#include <vector>
#include <string>
#include "bison.tab.hh"

using namespace std;

vector<std::string> table;
int table_pos = 0;
bool found = false;

%}

%option noyywrap

%%
[ ]
\[ {cout <<   " <LSQB> "; return LSQB;}
\] {cout <<   " <RSQB>"; return RSQB;}
\n {cout <<   " <NL>\n"; }
\! {cout <<   " <EOL>"; return EOL;}
int {cout <<   " <INT> "; return INT;}
if {cout <<   " <IF> "; return IF;}
return {cout << " <RET> "; return RET;}
float {cout <<   " <FLOAT> "; return FLOAT;}
\<= {cout <<   " <COMPARISON, <=> "; return LEQ;}
\>= {cout <<   " <COMPARISON, >=> "; return GEQ;}
== {cout <<   " <COMPARISON, ==> "; return EQ;}
\!= {cout <<   " <COMPARISON, !=> "; return NEQ;}
\< {cout <<   " <COMPARISON, <> "; return LT;}
\> {cout <<   " <COMPARISON, >> "; return GT;}
\( {cout <<   " <LPAREN> "; return LPAREN;}
\) {cout <<   " <RPAREN>"; return RPAREN;}
\{ {cout <<   " <LCURL> "; return LCURL;}
\} {cout <<   " <RCURL> "; return RCURL;}
= {cout <<   " <EQUAL, => ";}
\+\+ {cout <<   " <OP, ++> "; }
-- {cout <<   " <OP, --> "; }
\+= {cout <<   " <OP, +=> "; return PEQ;}
-= {cout <<   " <OP, -=> "; return MEQ;}
\*= {cout <<   " <OP, *=> "; return TEQ;}
\/= {cout <<   " <OP, /=> "; return DEQ;}
\+ {cout <<   " <OP, +> "; return PLUS;}
- {cout <<   " <OP, -> "; return SUB;}
\* {cout <<   " <OP, *> "; return MUL;}
\/ {cout <<   " <OP, /> "; return DIV;}
\t {cout <<   " <TAB> ";}


[0-9]*\.[0-9]+ {

  // tabs are for formatting only
  string Real_entry = "REAL\t\t" + (string)yytext;

  if(table.size() != 0){
    for (int i = 0; i < table.size(); i++){
      if(table[i] == Real_entry){
	table_pos = i;
	found = true;
	break;
      }
    }
    if (!found) {
      table.push_back(Real_entry);
      table_pos = table.size() - 1;
    }
  }
  else{
    table.push_back(Real_entry);
    table_pos = table.size() - 1;
  }
  
  cout << " <REAL, " << table_pos << "> ";
  table_pos = 0;
  found = false;

  return REAL;
}


[0-9]+ {
  
  // tabs are for formatting only
  string int_entry = "INTEGER\t\t" + (string)yytext;
  
  if(table.size() != 0){
    for (int i = 0; i < table.size(); i++){
      if(table[i] == int_entry){
	table_pos = i;
	found = true;
	break;
      }
    }
    if (!found) {
      table.push_back(int_entry);
      table_pos = table.size() - 1;
    }
  }
  else{
    table.push_back(int_entry);
    table_pos = table.size() - 1;
  }
  
  cout << " <INTEGER, " << table_pos <<  "> ";
  table_pos = 0;
  found = false;

  return INTEGER;
}


[a-zA-Z_][a-zA-Z_0-9]* {

  // tabs are for formatting only
  string id_entry = "ID\t\t" + (string)yytext;

  if(table.size() != 0){
    
    for (int i = 0; i < table.size(); i++){
      if(table[i] == id_entry){
	table_pos = i;
	found = true;
	break;
      }
    }
    if (!found) {
      table.push_back(id_entry);
      table_pos = table.size() - 1;
    }
  }
  else{
    table.push_back(id_entry);
    table_pos = table.size() - 1;
  }

  cout << " <ID, " << table_pos << "> ";
  table_pos = 0;
  found = false;

  return ID;
}


