#ifndef FORMULA_H
#define	FORMULA_H

#include <cstdio>
#include "structs.h"
#include "Formulas.h"
#include <vector>
#include <map>
#include <string>

using namespace std;

class Formulas;
/*
 * 公式类
 */
class Formula {
private:
    _formula* m_pFormula;//公式
public:
    Formula();
    Formula(const Formula& _rhs);
    Formula(_formula* _fml, bool _bIsCopy = true);
    ~Formula();
    Formula& operator = (const Formula& _rhs);
    bool operator == (const Formula& _rhs) const;
    bool operator != (const Formula& _rhs) const;
    
    _formula* getFormula() const;
    void setFormula(_formula* _newFormula);
    bool isUniversal() const;
    void convertToPNF();
    void convertToNNF(bool _bIsSM = true);
    void fixUniversalQuantifier();
    void removeUniversalQuantifier();
    void output(FILE* _out) const;
    void doubleNegationPredicates(const map<int, string>& _mapPredicates);
    void replaceTerms(const vector<int>& _originals, 
				const vector<int>& _replacements);
    void removeImpl();
    Formulas* divideFormula() const;
    void convertToCNF();
    void convertToSt();
    void displayFormulaByzhoutengteng();
};



#endif	/* FORMULA_H */

