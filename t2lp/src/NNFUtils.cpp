#include "NNFUtils.h"
#include "Utils.h"
#include <assert.h>
#include <cstdio>
#include <cstdlib>

bool NNFUtils::ms_bIsSM = true;
/**
 * ~TRUE => FALSE
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_1(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->predicate_id == PRED_TRUE);
    _formula* ret = Utils::compositeToAtom(PRED_FALSE, NULL);
    Utils::deleteFormula(_originalFml);
    return ret;
}
/**
 * ~FALSE => TRUE
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_2(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->predicate_id == PRED_FALSE);
    _formula* ret = Utils::compositeToAtom(PRED_TRUE, NULL);
    Utils::deleteFormula(_originalFml);
    return ret;
}
/**
 * ~~~fml => ~fml
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_3_1(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_l->subformula_l->subformula_l);
    _formula* ret = convertToNegativeNormalForm(_originalFml->subformula_l->subformula_l);
    free(_originalFml->subformula_l);
    free(_originalFml);
    return ret;
}
/**
 * ~~fml => fml
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_3_2(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_l->subformula_l);
    printf("here\n");
    _formula* ret = convertToNegativeNormalForm(_originalFml->subformula_l->subformula_l);
    free(_originalFml->subformula_l);
    free(_originalFml);
    return ret;
}
/**
 * ~(F ^ G) => ~F v ~G
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_4(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_r);
    _formula* f = _originalFml->subformula_l->subformula_l;
    _formula* g = _originalFml->subformula_l->subformula_r;
    _formula* _f = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, f, NULL));
    _formula* _g = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, g, NULL));
    _formula* ret = Utils::compositeByConnective(DISJ, _f, _g);
    free(_originalFml->subformula_l);// ^
    free(_originalFml);// ~
    return ret;
}
/**
 * ~(F v G) => ~F ^ ~G
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_5(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == DISJ);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_r);
    _formula* f = _originalFml->subformula_l->subformula_l;
    _formula* g = _originalFml->subformula_l->subformula_r;
    _formula* _f = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, f, NULL));
    _formula* _g = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, g, NULL));
    _formula* ret = Utils::compositeByConnective(CONJ, _f, _g);
    free(_originalFml->subformula_l);// v
    free(_originalFml);// ~
    return ret;
}
/**
 * ~(F -> G) => ~~F ^ ~G
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::negativeNormalForm_6(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == NEGA);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == IMPL);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_r);
    _formula* f = _originalFml->subformula_l->subformula_l;
    _formula* g = _originalFml->subformula_l->subformula_r;
    _formula* _f = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, f, NULL));
    _formula* __f = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, _f, NULL));
    _formula* _g = convertToNegativeNormalForm(Utils::compositeByConnective(NEGA, g, NULL));
    _formula* ret = Utils::compositeByConnective(CONJ, __f, _g);
    free(_originalFml->subformula_l);// ->
    free(_originalFml);// ~
    return ret;
}
/**
 * 把公式转化成否定标准式
 * @param _originalFml
 * @return 
 */
_formula* NNFUtils::convertToNegativeNormalForm(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == ATOM || _originalFml->formula_type == NEGA ||
               _originalFml->formula_type == DISJ || _originalFml->formula_type == CONJ ||
               _originalFml->formula_type == IMPL || _originalFml->formula_type == UNIV ||
               _originalFml->formula_type == EXIS);
    //Cabalar. (2005)
    if (_originalFml->formula_type == ATOM) {
        //do nothing
    } else if (_originalFml->formula_type == NEGA) {
        _formula* subformula_l = _originalFml->subformula_l;
        if (subformula_l->formula_type == ATOM) {
            //N1
            if (subformula_l->predicate_id == PRED_TRUE) {
                return negativeNormalForm_1(_originalFml);
            }
            //N2
            else if (subformula_l->predicate_id == PRED_FALSE) {
                return negativeNormalForm_2(_originalFml);
            }
        }  
        else if (subformula_l->formula_type == NEGA) {
            //N3
            if (! ms_bIsSM) {
                return negativeNormalForm_3_2(_originalFml);
            }
            if (subformula_l->subformula_l->formula_type == NEGA) {
                return negativeNormalForm_3_1(_originalFml);
            }
            // 如~~(p|~q)  =>  ~~p | ~q
            if (subformula_l->subformula_l->formula_type == CONJ || 
                    subformula_l->subformula_l->formula_type == DISJ ||
                    subformula_l->subformula_l->formula_type == IMPL) {
                _originalFml->subformula_l = convertToNegativeNormalForm(subformula_l);
                _originalFml = convertToNegativeNormalForm(_originalFml);
                return _originalFml;
            }
        }
        //N4
        else if (subformula_l->formula_type == CONJ) {
        	//printf("CONJ\n");
            	
            	return negativeNormalForm_4(_originalFml);
        }
        //N5
        else if (subformula_l->formula_type == DISJ) {
        	//printf("DISJ\n");

            return negativeNormalForm_5(_originalFml);
        }
        //N6
        else if (subformula_l->formula_type == IMPL) {
        	//printf("IMPL\n");
            return negativeNormalForm_6(_originalFml);
        }
    }
    else if (_originalFml->formula_type == UNIV || _originalFml->formula_type == EXIS) {
        _originalFml->subformula_l = convertToNegativeNormalForm(_originalFml->subformula_l);
    }
    else {// CONJ,DISJ,IMPL
        _originalFml->subformula_l = convertToNegativeNormalForm(_originalFml->subformula_l);
	_originalFml->subformula_r = convertToNegativeNormalForm(_originalFml->subformula_r);
    }
    
    return _originalFml;
}
