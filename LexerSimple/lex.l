%{

#include <iostream>
#include <vector>
#include <string>

using namespace std;

vector<std::string> table;
int table_pos = 0;
bool found = false;

%}

%option noyywrap

%%
[ ]
\[ {cout << " <LSQB> ";}
\] {cout << " <RSQB>";}
\n {cout << " <NL>\n";}
\! {cout << " <EOL>";}
int {cout << " <INT> ";}
if {cout << " <IF> ";}
float {cout << " <FLOAT> ";}
\<= {cout << " <COMPARISON, <=> ";}
\>= {cout << " <COMPARISON, >=> ";}
== {cout << " <COMPARISON, ==> ";}
\!= {cout << " <COMPARISON, !=> ";}
\< {cout << " <COMPARISON, <> ";}
\> {cout << " <COMPARISON, >> ";}
\( {cout << " <LPAREN> ";}
\) {cout << " <RPAREN>";}
\{ {cout << " <LCURL> ";}
\} {cout << " <RCURL> ";}
= {cout << " <EQUAL, => ";}
\+\+ {cout << " <OP, ++> ";}
-- {cout << " <OP, --> ";}
\+= {cout << " <OP, +=> ";}
-= {cout << " <OP, -=> ";}
\*= {cout << " <OP, *=> ";}
\/= {cout << " <OP, /=> ";}
\+ {cout << " <OP, +> ";}
- {cout << " <OP, -> ";}
\* {cout << " <OP, *> ";}
\/ {cout << " <OP, /> ";}
\t {cout << " <TAB> ";}


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
}


