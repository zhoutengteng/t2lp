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

    //printf("\nthe prenex formulas\n\n");
    //PNFUtils::convertToPNF(f.getFormula());

    // int left = CabalarUtils::commutaiveTrans(f.getFormula()->subformula_l, f.getFormula()->subformula_l, CONJ);
    // int right = CabalarUtils::commutaiveTrans(f.getFormula()->subformula_r, f.getFormula()->subformula_r, DISJ);
    // printf("\nthe move formula left = %d, right = %d\n", left, right);
    // Utils::outputFormula(stdout, f.getFormula());
    // printf("\n");

/*
    printf("parse finish\n");
    printf("\nthe input formulas\n\n");
    Utils::outputFormula(stdout, f.getFormula());
    printf("\n");
    printf("\nthe NNF formulas\n\n");
    NNFUtils::convertToNegativeNormalForm(f.getFormula());
    Utils::outputFormula(stdout, f.getFormula());
    printf("\n");

    printf("\nthe prenex formulas\n\n");
    PNFUtils::convertToPNF(f.getFormula());
    Utils::outputFormula(stdout, f.getFormula());

    printf("\nenter elim_quantifier formulas\n\n");
    Formulas* m_pOriginalFormulas = f.divideFormula();
    // m_pOriginalFormulas->convertToPNF();
    // m_pOriginalFormulas->convertToNNF();
    m_pOriginalFormulas->output(stdout);


    HengZhang* m_pHz = new HengZhang();
    Formulas* m_pHengZhangFormulas = m_pHz->convert(* m_pOriginalFormulas);
    printf("\nafter elim_quantifier formulas\n\n");
    m_pHengZhangFormulas->output(stdout);
    // f.setFormula(elim_quantifier(f.getFormula()));
    // HengZhang::transform(f);
    printf("\nthe cabalar formulas\n\n");
    Formulas* m_pDlpFormulas = Cabalar::instance().convert(*m_pHengZhangFormulas);
    //m_pDlpFormulas->output(stdout);

    printf("\nthe rule formulas\n\n");
*/

    SMTranslator::instance().init(f);
    SMTranslator::instance().convert();
    SMTranslator::instance().outputHengZhangFormulas(stdout);
    printf("\n");
    SMTranslator::instance().outputCabalarFormulas(stdout);
    printf("\n");
    SMTranslator::instance().outputFinalResult(fout);
    SMTranslator::instance().destroy();



    // list<Rule> m_listRules; 
    // for (FORMULAS_CONST_ITERATOR it = m_pDlpFormulas->begin();
    //         it != m_pDlpFormulas->end(); ++ it) {
    //     Rule rule = Rule(*it);
    //     m_listRules.push_back(rule);
    // }
    // delete m_pDlpFormulas;
    // m_pDlpFormulas = NULL;





    return 0;
}


