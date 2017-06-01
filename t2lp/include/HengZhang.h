#ifndef HENGZHANG_H
#define	HENGZHANG_H

#include <vector>
#include <string>
#include "structs.h"
#include "Formula.h"
#include "Formulas.h"

using namespace std;

class Formula;
class Formulas;
/*
 * 章衡转换类，单例
 */
class HengZhang {
protected:
    vector<int> m_vTermsX;
    vector<int> m_vTermsY;
    vector<int> m_vTermsZ;
    vector<int> m_vTermsMIN;
    vector<int> m_vTermsMAX;

    int m_nSymbolS;
    int m_nSymbolT;
    int m_nSymbolSucc;
protected:
    Formula create__S();
    Formula createSuccAndSOrTheta__ImplS(const Formula& _originalFml);
    Formula recordQuantifier(const Formula& _originalFml);
    Formula preProcessing(const Formula& _originalFml);
    void postProcessing();
private:
    Formulas transform(const Formula& _originalFml);
    Formula createFormula_1();
    Formula createFormula_2(const Formula& _originalFml);
    Formula createFormula_3(const Formula& _originalFml);
    Formula createFormula_4_1(const Formula& _originalFml);
    Formula createFormula_4_2(const Formula& _originalFml);
    Formula createFormula_5_1(const Formula& _originalFml);
    Formula createFormula_5_2(const Formula& _originalFml);
    _formula* generateFormulaLeft_4();
public:
    HengZhang();
    virtual ~HengZhang();
    Formulas* convert(const Formulas& _originalFmls);
    
    
};

#endif	/* HENGZHANG_H */

