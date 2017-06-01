#include <cstdlib>
#include <cstdio>
#include <assert.h>
#include "Vocabulary.h"
#include "Utils.h"
#include "Formula.h"
#include "Formulas.h"
#include "SMTranslator.h"
#include <iostream>
#include <unistd.h>
#include "NNFUtils.h"
#include "PNFUtils.h"
#include "structs.h"
#include "Cabalar.h"
#include "CabalarUtils.h"
#include "parse.h"

using namespace std;

FILE* fout;
extern FILE* yyin;
extern _formula* gformula;
extern int yyparse();

void io(const char* iPathName, const char* oPathName) {
    yyin = fopen (iPathName, "r");
    fout = fopen (oPathName, "w+");

    if (! yyin) {
        printf("IO Error: cannot open the input file.\n" );
        assert(0);
    }
    if (! fout) {
        printf("IO Error: cannot open the output file.\n");
        assert(0);
    }
}



int main(int argc, char** argv) {
  
    io(argv[1], argv[2]);

    yyparse();
    fclose(yyin);

    
    Formula f = Formula(gformula, false);
    printf("parse finish\n");
    printf("\nthe input formulas\n\n");
    Utils::outputFormula(stdout, f.getFormula());
    printf("\n");


    SMTranslator::instance().init(f);
    SMTranslator::instance().convert();
    SMTranslator::instance().outputHengZhangFormulas(stdout);
    printf("\n");
    SMTranslator::instance().outputCabalarFormulas(stdout);
    printf("\n");
    SMTranslator::instance().outputFinalResult(fout);
    SMTranslator::instance().destroy();






    return 0;
}


