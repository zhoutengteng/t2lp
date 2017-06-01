#ifndef CABALARUTILS_H
#define	CABALARUTILS_H

#include "structs.h"
#include "Formulas.h"

class Formulas;
/*
 * 进行Cabalar转换的工具类
 */
class CabalarUtils {
private:
    static _formula* disjLeftTrue(_formula* _originalFml);
    static _formula* disjLeftFalse(_formula* _originalFml);
    static _formula* conjLeftTrue(_formula* _originalFml);
    static _formula* conjLeftFalse(_formula* _originalFml);
    static _formula* implLeftTrue(_formula* _originalFml);
    static _formula* implLeftFalse(_formula* _originalFml);
    static _formula* implRightTrue(_formula* _originalFml);
    static _formula* implRightFalse(_formula* _originalFml);
    
    static Formulas* leftRule_1(_formula* _originalFml);
    static Formulas* leftRule_2(_formula* _originalFml);
    static Formulas* leftRule_3(_formula* _originalFml);
    static Formulas* leftRule_4(_formula* _originalFml);
    static Formulas* leftRule_5(_formula* _originalFml);
    
    static Formulas* rightRule_1(_formula* _originalFml);
    static Formulas* rightRule_2(_formula* _originalFml);
    static Formulas* rightRule_3(_formula* _originalFml);
    static Formulas* rightRule_4(_formula* _originalFml);
    static Formulas* rightRule_5(_formula* _originalFml);
    

public:
        static int commutaiveTrans(_formula* _root, _formula* _cur, 
                        FORMULA_TYPE _commutativeSymbol);
    static Formulas* transform(_formula* _originalFml);
};


#endif	/* CABALARUTILS_H */

