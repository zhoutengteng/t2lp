#ifndef PNFUTILS_H
#define	PNFUTILS_H

#include "structs.h"
/**
 * 前束范式的工具类
 */
class PNFUtils {
private:
    static bool isVariableInFormula(_formula* _fml, int _nVariableId);
    static void extractQuantifier_NEGA(_formula* _fml);
    static void extractQuantifier_IMPL_CONJ_DISJ(_formula* _fml);
public:
    static void convertToPNF(_formula* _fml);
};

#endif	/* PNFUTILS_H */

