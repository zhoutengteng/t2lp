#ifndef NNFUTILS_H
#define	NNFUTILS_H

#include "structs.h"
#include "Formulas.h"

class Formulas;
/*
 * 否定标准式的工具类
 */
class NNFUtils {
public:
    static bool ms_bIsSM;
private:
    static _formula* negativeNormalForm_1(_formula* _originalFml);
    static _formula* negativeNormalForm_2(_formula* _originalFml);
    static _formula* negativeNormalForm_3_1(_formula* _originalFml);
    static _formula* negativeNormalForm_3_2(_formula* _originalFml);
    static _formula* negativeNormalForm_4(_formula* _originalFml);
    static _formula* negativeNormalForm_5(_formula* _originalFml);
    static _formula* negativeNormalForm_6(_formula* _originalFml);
public:
    static _formula* convertToNegativeNormalForm(_formula* _originalFml);
//    static Formula convertToNegativeNormalForm(const Formula& _originalFml, bool _bIsSM = true);
//    static Formulas* convertToNegativeNormalForms(const Formulas& _originalFmls, bool _bIsSM = true);
//    static void convertToNegativeNormalForms(Formulas* _originalFmls, bool _bIsSM = true);
};


#endif	/* NNFUTILS_H */

