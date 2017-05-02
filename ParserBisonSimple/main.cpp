// Justin James
// 3-31-2017
// main.cpp
// driver for the lexer which tokenizes our class language.

#include <iostream>
#include <string>
#include <vector>
//#include <fstream>
#include <FlexLexer.h>


using namespace std;

// the extern keyword lets the compiler know that 
// the variables exist somewhere outside of this file.
extern vector<string> table;
extern int yylex();
//extern FILE* yyin;
extern int yyparse();

int main (){
  
  //yyin = fopen("text.txt", "r");
  //yyparse();
  
  FlexLexer* lexer = new yyFlexLexer;
  
  while(lexer->yylex() !=0){
    yyparse();
  }
  
  cout << "\n\n\tSymbol Table\n\n";
  for (int i = 0; i < table.size(); i++){
    cout << i << "\t" << table[i] << "\n";
  }
  
  return 0;
}
