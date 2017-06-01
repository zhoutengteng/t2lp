#include "CabalarUtils.h"
#include "Utils.h"
#include "NNFUtils.h"
#include <cstdlib>
#include <assert.h>
/**
 * TRUE | fml => TRUE
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::disjLeftTrue(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == DISJ);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == ATOM);
    assert(_originalFml->subformula_l->predicate_id == PRED_TRUE);
    assert(_originalFml->subformula_r);
    _formula* ret = _originalFml->subformula_l;
    Utils::deleteFormula(_originalFml->subformula_r);
    free(_originalFml);
    return ret;
}
/**
 * FALSE | fml => fml
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::disjLeftFalse(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == DISJ);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == ATOM);
    assert(_originalFml->subformula_l->predicate_id == PRED_FALSE);
    assert(_originalFml->subformula_r);
    _formula* ret = _originalFml->subformula_r;
    Utils::deleteFormula(_originalFml->subformula_l);
    free(_originalFml);
    return ret;
}
/**
 * TRUE & fml => fml
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::conjLeftTrue(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == CONJ);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == ATOM);
    assert(_originalFml->subformula_l->predicate_id == PRED_TRUE);
    assert(_originalFml->subformula_r);
    _formula* ret = _originalFml->subformula_r;
    Utils::deleteFormula(_originalFml->subformula_l);
    free(_originalFml);
    return ret;
}
/**
 * FALSE & fml => FALSE
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::conjLeftFalse(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == CONJ);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == ATOM);
    assert(_originalFml->subformula_l->predicate_id == PRED_FALSE);
    assert(_originalFml->subformula_r);
    _formula* ret = _originalFml->subformula_l;
    Utils::deleteFormula(_originalFml->subformula_r);
    free(_originalFml);
    return ret;
}
/**
 * TRUE -> fml  =>  fml
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::implLeftTrue(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == ATOM);
    assert(_originalFml->subformula_l->predicate_id == PRED_TRUE);
    assert(_originalFml->subformula_r);
    _formula* ret = _originalFml->subformula_r;
    Utils::deleteFormula(_originalFml->subformula_l);
    free(_originalFml);
    return ret;
}
/**
 * FALSE -> fml  =>  TRUE
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::implLeftFalse(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == ATOM);
    assert(_originalFml->subformula_l->predicate_id == PRED_FALSE);
    assert(_originalFml->subformula_r);
    _formula* ret = Utils::compositeToAtom(PRED_TRUE, NULL);
    Utils::deleteFormula(_originalFml);
    return ret;
}
/**
 * fml -> TRUE => TRUE
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::implRightTrue(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_r);
    assert(_originalFml->subformula_r->formula_type == ATOM);
    assert(_originalFml->subformula_r->predicate_id == PRED_TRUE);
    _formula* ret = Utils::compositeToAtom(PRED_TRUE, NULL);
    Utils::deleteFormula(_originalFml);
    return ret;
}
/**
 * fml -> FALSE => ~fml
 * @param _originalFml
 * @return 
 */
_formula* CabalarUtils::implRightFalse(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_r);
    assert(_originalFml->subformula_r->formula_type == ATOM);
    assert(_originalFml->subformula_r->predicate_id == PRED_FALSE);
    _formula* ret = Utils::compositeByConnective(NEGA, _originalFml->subformula_l, NULL);
    ret = NNFUtils::convertToNegativeNormalForm(ret);
    Utils::deleteFormula(_originalFml->subformula_r);
    free(_originalFml);
    return ret;
}
/**
 * TRUE ^ F -> G  =>  F->G
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::leftRule_1(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_l->predicate_id == PRED_TRUE);
    assert(_originalFml->subformula_l->subformula_r);
    
    _formula* f = _originalFml->subformula_l->subformula_r;
    _formula* g = _originalFml->subformula_r;
    _formula* fg = Utils::compositeByConnective(IMPL, f, g);
    
    Utils::deleteFormula(_originalFml->subformula_l->subformula_l);//TRUE
    free(_originalFml->subformula_l);//^
    free(_originalFml);// ->
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fg, false));
    return ret;
}
/**
 * FALSE ^ F -> G => {NULL}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::leftRule_2(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_l->predicate_id == PRED_FALSE);
    assert(_originalFml->subformula_l->subformula_r);
    
    Utils::deleteFormula(_originalFml);//_originalFml
    
    Formulas* ret = new Formulas();
    return ret;
}
/**
 * --F ^ G -> H ----> {G -> -F v H}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::leftRule_3(_formula* _originalFml) {
    assert(_originalFml);
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);
    assert(_originalFml->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_l->subformula_l->subformula_l);
    assert(_originalFml->subformula_l->subformula_l->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_l->subformula_l->subformula_l->subformula_l);//f
    assert(_originalFml->subformula_l->subformula_r);//g
    assert(_originalFml->subformula_r);//h
    
    _formula* _f = _originalFml->subformula_l->subformula_l->subformula_l;
    _formula* g = _originalFml->subformula_l->subformula_r;
    _formula* h = _originalFml->subformula_r;
    _formula* _fh = Utils::compositeByConnective(DISJ, _f, h);
    _formula* g_fh = Utils::compositeByConnective(IMPL, g, _fh);
    
    free(_originalFml->subformula_l->subformula_l);// ~
    free(_originalFml->subformula_l); // ^
    free(_originalFml);// ->
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(g_fh, false));
    return ret;
}
/**
 * (F v G) ^ H -> K ----> { F ^ H -> K
 *                          G ^ H -> K}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::leftRule_4(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);//^
    assert(_originalFml->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_l->subformula_l);//v
    assert(_originalFml->subformula_l->subformula_l->formula_type == DISJ);
    assert(_originalFml->subformula_l->subformula_l->subformula_l);//f
    assert(_originalFml->subformula_l->subformula_l->subformula_r);//g
    assert(_originalFml->subformula_l->subformula_r);//h
    assert(_originalFml->subformula_r);//k
    
    _formula* f = _originalFml->subformula_l->subformula_l->subformula_l;
    _formula* g = _originalFml->subformula_l->subformula_l->subformula_r;
    _formula* h = _originalFml->subformula_l->subformula_r;
    _formula* h_2 = Utils::copyFormula(h);
    _formula* k = _originalFml->subformula_r;
    _formula* k_2 = Utils::copyFormula(k);
    _formula* fml_1 = Utils::compositeByConnective(IMPL, Utils::compositeByConnective(CONJ, f, h), k);
    _formula* fml_2 = Utils::compositeByConnective(IMPL, Utils::compositeByConnective(CONJ, g, h_2), k_2);
    
    free(_originalFml->subformula_l->subformula_l);
    free(_originalFml->subformula_l);
    free(_originalFml);
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fml_1, false));
    ret->pushBack(Formula(fml_2, false));
    return ret;
}
/**
 * (F -> G) ^ H -> K  ----> { -F ^ H -> K
//                             G ^ H -> K
//                             H -> F v -G v K}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::leftRule_5(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);//^
    assert(_originalFml->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_l->subformula_l);//->
    assert(_originalFml->subformula_l->subformula_l->formula_type == IMPL);
    assert(_originalFml->subformula_l->subformula_l->subformula_l);//f
    assert(_originalFml->subformula_l->subformula_l->subformula_r);//g
    assert(_originalFml->subformula_l->subformula_r);//h
    assert(_originalFml->subformula_r);//k
    
    _formula* f = _originalFml->subformula_l->subformula_l->subformula_l;
    _formula* _f = NNFUtils::convertToNegativeNormalForm(
                        Utils::compositeByConnective(NEGA, 
                            Utils::copyFormula(f), NULL));
    _formula* g = _originalFml->subformula_l->subformula_l->subformula_r;
    _formula* _g = NNFUtils::convertToNegativeNormalForm(
                        Utils::compositeByConnective(NEGA, 
                            Utils::copyFormula(g), NULL));
    _formula* h = _originalFml->subformula_l->subformula_r;
    _formula* h_2 = Utils::copyFormula(h);
    _formula* h_3 = Utils::copyFormula(h);
    _formula* k = _originalFml->subformula_r;
    _formula* k_2 = Utils::copyFormula(k);
    _formula* k_3 = Utils::copyFormula(k);
    // -F ^ H -> K
    _formula* fml_1 = Utils::compositeByConnective(IMPL, 
                        Utils::compositeByConnective(CONJ, _f, h), k);
    //G ^ H -> K
    _formula* fml_2 = Utils::compositeByConnective(IMPL, 
                        Utils::compositeByConnective(CONJ, g, h_2), k_2);
    //H -> F v -G v K
    _formula* fml_3 = Utils::compositeByConnective(IMPL, h_3, 
                        Utils::compositeByConnective(DISJ, 
                                Utils::compositeByConnective(DISJ, f, _g), k_3));
    
    free(_originalFml->subformula_l->subformula_l);
    free(_originalFml->subformula_l);
    free(_originalFml);
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fml_1, false));
    ret->pushBack(Formula(fml_2, false));
    ret->pushBack(Formula(fml_3, false));
    return ret;
}
/**
 * F-> FALSE v G  => {F->G}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::rightRule_1(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_r);//v
    assert(_originalFml->subformula_r->formula_type == DISJ);
    assert(_originalFml->subformula_l);//f
    assert(_originalFml->subformula_r->subformula_l);//FALSE
    assert(_originalFml->subformula_r->subformula_l->predicate_id == PRED_FALSE);
    assert(_originalFml->subformula_r->subformula_r);//g
    
    _formula* f = _originalFml->subformula_l;
    _formula* g = _originalFml->subformula_r->subformula_r;
    _formula* fml = Utils::compositeByConnective(IMPL, f, g);
    
    Utils::deleteFormula(_originalFml->subformula_r->subformula_l);//FALSE
    free(_originalFml->subformula_r);//v
    free(_originalFml);
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fml, false));
    return ret;
}
/**
 * F-> TRUE v G  => {}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::rightRule_2(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_r);//v
    assert(_originalFml->subformula_r->formula_type == DISJ);
    assert(_originalFml->subformula_l);//f
    assert(_originalFml->subformula_r->subformula_l);//TRUE
    assert(_originalFml->subformula_r->subformula_l->predicate_id == PRED_TRUE);
    assert(_originalFml->subformula_r->subformula_r);//g
    
    Utils::deleteFormula(_originalFml);
    
    Formulas* ret = new Formulas();
    return ret;
}
/**
 * F-> ~~G v H => {~G ^ F -> H}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::rightRule_3(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_r);//v
    assert(_originalFml->subformula_r->formula_type == DISJ);
    assert(_originalFml->subformula_l);//f
    assert(_originalFml->subformula_r->subformula_l);//~
    assert(_originalFml->subformula_r->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_r->subformula_l->subformula_l);//~
    assert(_originalFml->subformula_r->subformula_l->subformula_l->formula_type == NEGA);
    assert(_originalFml->subformula_r->subformula_l->subformula_l->subformula_l);//g
    assert(_originalFml->subformula_r->subformula_r);//H
    
    _formula* _g = _originalFml->subformula_r->subformula_l->subformula_l;
    _formula* f = _originalFml->subformula_l;
    _formula* h = _originalFml->subformula_r->subformula_r;
    _formula* fml = Utils::compositeByConnective(IMPL, 
                        Utils::compositeByConnective(CONJ, _g, f), h);
    
    free(_originalFml->subformula_r->subformula_l);//~
    free(_originalFml->subformula_r);//v
    free(_originalFml);//->

    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fml, false));
    return ret;
}
/**
 * F-> (G ^ H) v K  => {F -> G v K
 *                      F -> H v K}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::rightRule_4(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);//f
    assert(_originalFml->subformula_r);//v
    assert(_originalFml->subformula_r->formula_type == DISJ);
    assert(_originalFml->subformula_r->subformula_l);//^
    assert(_originalFml->subformula_r->subformula_l->formula_type == CONJ);
    assert(_originalFml->subformula_r->subformula_l->subformula_l);//g
    assert(_originalFml->subformula_r->subformula_l->subformula_r);//h
    assert(_originalFml->subformula_r->subformula_r);//k
    
    _formula* f_1 = _originalFml->subformula_l;
    _formula* f_2 = Utils::copyFormula(f_1);
    _formula* g = _originalFml->subformula_r->subformula_l->subformula_l;
    _formula* k_1 = _originalFml->subformula_r->subformula_r;
    _formula* k_2 = Utils::copyFormula(k_1);
    _formula* h = _originalFml->subformula_r->subformula_l->subformula_r;
    _formula* fml_1 = Utils::compositeByConnective(IMPL, f_1,
                        Utils::compositeByConnective(DISJ, g, k_1));
    _formula* fml_2 = Utils::compositeByConnective(IMPL, f_2,
                        Utils::compositeByConnective(DISJ, h, k_2));
     
    free(_originalFml->subformula_r->subformula_l);
    free(_originalFml->subformula_r);
    free(_originalFml);
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fml_1, false));
    ret->pushBack(Formula(fml_2, false));
    return ret;
}
/**
 * F-> (G -> H) v K  => {G ^ F -> H v K
 *                      ~H ^ F -> ~G v K}
 * @param _originalFml
 * @return 
 */
Formulas* CabalarUtils::rightRule_5(_formula* _originalFml) {
    assert(_originalFml);//->
    assert(_originalFml->formula_type == IMPL);
    assert(_originalFml->subformula_l);//f
    assert(_originalFml->subformula_r);//v
    assert(_originalFml->subformula_r->formula_type == DISJ);
    assert(_originalFml->subformula_r->subformula_l);//->
    assert(_originalFml->subformula_r->subformula_l->formula_type == IMPL);
    assert(_originalFml->subformula_r->subformula_l->subformula_l);//g
    assert(_originalFml->subformula_r->subformula_l->subformula_r);//h
    assert(_originalFml->subformula_r->subformula_r);//k
    
    _formula* f = _originalFml->subformula_l;
    _formula* f_2 = Utils::copyFormula(f);
    _formula* g = _originalFml->subformula_r->subformula_l->subformula_l;
    _formula* _g = NNFUtils::convertToNegativeNormalForm(
                        Utils::compositeByConnective(NEGA, 
                            Utils::copyFormula(g), NULL));
    _formula* h = _originalFml->subformula_r->subformula_l->subformula_r;
    _formula* _h = NNFUtils::convertToNegativeNormalForm(
                        Utils::compositeByConnective(NEGA, 
                            Utils::copyFormula(h), NULL));
    _formula* k = _originalFml->subformula_r->subformula_r;
    _formula* k_2 = Utils::copyFormula(k);
    //G ^ F -> H v K
    _formula* fml_1 = Utils::compositeByConnective(IMPL, 
                        Utils::compositeByConnective(CONJ, g, f),
                        Utils::compositeByConnective(DISJ, h, k));
    //~H ^ F -> ~G v K
    _formula* fml_2 = Utils::compositeByConnective(IMPL, 
                        Utils::compositeByConnective(CONJ, _h, f_2), 
                        Utils::compositeByConnective(DISJ, _g, k_2));

    free(_originalFml->subformula_r->subformula_l);
    free(_originalFml->subformula_r);
    free(_originalFml);
    
    Formulas* ret = new Formulas();
    ret->pushBack(Formula(fml_1, false));
    ret->pushBack(Formula(fml_2, false));
    return ret;
}
/** 把特殊子公式提前到最左端，因为Cabalar转换中，特殊子公式都在最左端
 * 所谓特殊子公式，指的是Cabalar要消去的部分，即true,false,~~,体部的v和->,头部的^和->
 * @param _root
 * @param _cur
 * @param _commutativeSymbol
 * @return 0 - 无需转换, 1- 需要转换, 2- 转换完成
 */
int CabalarUtils::commutaiveTrans(_formula* _root, _formula* _cur, 
                        FORMULA_TYPE _commutativeSymbol) {
    assert(_root);
    assert(_cur);
    assert(_commutativeSymbol == DISJ || _commutativeSymbol == CONJ);

    static bool isLeftSide;
    _formula* temp;

    // terminals
    if (_cur->formula_type != _commutativeSymbol) {
        // 特殊子公式  Cabalar的目的在于消除 true,false,~~,体部的v和->,头部的^和->
        if (_cur->formula_type == ATOM && 
                (_cur->predicate_id == PRED_TRUE || 
                        _cur->predicate_id == PRED_FALSE)) {
            return 1;// true or false
        }
        else if (_cur->formula_type == NEGA && 
                    _cur->subformula_l->formula_type == NEGA) {
            return 1;// ~~
        }
        else if (_cur->formula_type == CONJ || _cur->formula_type == DISJ ||
                        _cur->formula_type == IMPL) {
            return 1;// ^ v ->
        }
        // 非特殊子公式
        else {
            return 0;
        }
    }


    // left sub-formula　检查左节点
    if (_cur == _root) { 
        isLeftSide = true; 
    }
    int value_l = commutaiveTrans(_root, _cur->subformula_l, _commutativeSymbol);

    if (value_l == 2) { 
        return 2; 
    }
    if (value_l == 1) {
        if (isLeftSide) {//transform 1　　特殊公式在当前节点的左节点　在根节点左子树　
	    /*情况 1:
	    当前左公式<-根的右公式
	    根的右公式<-跟的左公式
	    根的左公式<-特殊子公式*/
	    /*(true & c)当前节点，(true & c) & d父节点　
	     *(true & c) & d
	     * (d & c) & d
	     * (d　& c) & (d & c)
	     * true & (d & c)
	     */
            temp = _cur->subformula_l;
            _cur->subformula_l = _root->subformula_r;

            _root->subformula_r = _root->subformula_l;
            _root->subformula_l = temp;
        }
        else {//transform 2 　特殊公式在当前节点的左节点 在根节点右子树
	    /*情况 2:
	     *当前左公式<-根的左公式
	     * 根的左公式<-特殊子公式
	     * (true & b)当前节点　a & (true & b)父节点
	     * a & (true & b)
	     * true & (a & b)
	     */
	  
            temp = _cur->subformula_l;
            _cur->subformula_l = _root->subformula_l;

            _root->subformula_l = temp;
        }
        return 2;
    }

    // right sub-formula　检查右节点
    if(_cur == _root) { 
        isLeftSide = false; 
    }
    int value_r = commutaiveTrans(_root, _cur->subformula_r, _commutativeSymbol);

    if(value_r == 2) { 
        return 2; 
    }
    if(value_r == 1) {
        if (isLeftSide) {//transform 3 特殊公式在当前节点的右节点　在根节点左子树
	  /*情况 3:
	   *当前右公式<-根的右公式
	   *根的右公式<-跟的左公式
	   *根的左公式<-特殊子公式
	   * (c & true) & d
	   * (c & d) &  d
	   * (c　& d) & (c & d)
	   * true & (c & d)
	   * 
	   * 
	   */
            temp = _cur->subformula_r;
            _cur->subformula_r = _root->subformula_r;

            _root->subformula_r = _root->subformula_l;
            _root->subformula_l = temp;
        }
        else {//transform 4 特殊公式在当前节点的右节点　在根节点右子树
	    /*
	     * 情况 4
	     * 根的左公式<-特殊子公式
	     * 根的左公式<-特殊子公式
	     * a & (b & true)
	     * true & (b & a)
	     */
            temp = _cur->subformula_r;
            _cur->subformula_r = _root->subformula_l;

            _root->subformula_l = temp;
        }
        return 2;
    }

    return 0;
}
/**
 * !!请确保 _originalFml不存在任何量词
 * @param _originalFml 在调用该函数前申请的空间，这里会处理这些空间的销毁
 * @return 
 */
Formulas* CabalarUtils::transform(_formula* _originalFml) {
    assert(_originalFml);
    // Cabalar. (2005) Left/Right side rules
    if (_originalFml->formula_type == IMPL) {
        _formula* subformula_l = _originalFml->subformula_l;
        _formula* subformula_r = _originalFml->subformula_r;

        commutaiveTrans(subformula_l, subformula_l, CONJ);
        commutaiveTrans(subformula_r, subformula_r, DISJ);
		
	_formula* CD_l = subformula_l->subformula_l;
	_formula* CD_r = subformula_r->subformula_l;
        
        if (subformula_l->formula_type == CONJ) {
            if (CD_l->formula_type == ATOM) {
                //L1
                if (CD_l->predicate_id == PRED_TRUE) {
                    return leftRule_1(_originalFml);
                }
                //L2
                if (CD_l->predicate_id == PRED_FALSE) {
                    return leftRule_2(_originalFml);
                }
            }
            //L3
	    if (CD_l->formula_type == NEGA && 
                    CD_l->subformula_l->formula_type == NEGA) {
		return leftRule_3(_originalFml);
	    }
            //L4
            if (CD_l->formula_type == DISJ) {
                return leftRule_4(_originalFml);
            }
            //L5
            if (CD_l->formula_type == IMPL) {
                return leftRule_5(_originalFml);
            }
        }//end of Cabalar Left Translation (full pattern)
		
        // Cabalar. (2005) Right side rules
        if (subformula_r->formula_type == DISJ) {
            if (CD_r->formula_type == ATOM) {
                //R1
                if (CD_r->predicate_id == PRED_FALSE) {
                    return rightRule_1(_originalFml);
                }
                //R2
                if (CD_r->predicate_id == PRED_TRUE) {
                    return rightRule_2(_originalFml);
                }
            }
            //R3
	    if (CD_r->formula_type == NEGA &&
                    CD_r->subformula_l->formula_type == NEGA) {
		return rightRule_3(_originalFml);
	    }
            //R4
            if (CD_r->formula_type == CONJ) {
                return rightRule_4(_originalFml);
            }
            //R5
            if (CD_r->formula_type == IMPL) {
                return rightRule_5(_originalFml);
            }
        }//end of Cabalar Right Translation(full pattern)

		
    	//start of Commutative missing Translation
    	if (subformula_l->formula_type == ATOM) {
                //L1 TRUE->G ------> G
    	    if (subformula_l->predicate_id == PRED_TRUE) {
                    _formula* temp1 = implLeftTrue(_originalFml);
                    Formula temp2(temp1, false);
                    Formulas* ffs = new Formulas();
                    ffs->pushBack(temp2);
                    return ffs;
    	    }
    	    //L2 FALSE->G ------> ALWAYS BE TRUE
    	    if (subformula_l->predicate_id == PRED_FALSE) {
                    _formula* temp1 = implLeftFalse(_originalFml);
                    Formula temp2(temp1, false);
                    Formulas* ffs = new Formulas();
                    ffs->pushBack(temp2);
                    return ffs;
    	    }
    	}
        //L3
        if (subformula_l->formula_type == NEGA &&
                subformula_l->subformula_l->formula_type == NEGA) {
            _originalFml->subformula_l = Utils::compositeByConnective(CONJ, subformula_l, NULL);
            _originalFml->subformula_l
                            ->subformula_r = Utils::compositeToAtom(PRED_TRUE, NULL);
            return leftRule_3(_originalFml);
        }
        //L4
        if (subformula_l->formula_type == DISJ) {
            _originalFml->subformula_l = Utils::compositeByConnective(CONJ, subformula_l, NULL);
            _originalFml->subformula_l
                            ->subformula_r = Utils::compositeToAtom(PRED_TRUE, NULL);
            return leftRule_4(_originalFml);
        }
        //L5
        if (subformula_l->formula_type == IMPL) {
            _originalFml->subformula_l = Utils::compositeByConnective(CONJ, subformula_l, NULL);
            _originalFml->subformula_l
                            ->subformula_r = Utils::compositeToAtom(PRED_TRUE, NULL);
            return leftRule_5(_originalFml);
        }
		
        //R1
        if (subformula_r->formula_type == ATOM) {
            //R1 F->FALSE -------->~F
            if (subformula_r->predicate_id == PRED_FALSE) {
                _formula* temp1 = implRightFalse(_originalFml);
                Formula temp2(temp1, false);
                Formulas* ffs = new Formulas();
                ffs->pushBack(temp2);
                return ffs;
            }
            //R2 F->TRUE --------->ALWAYS BE TRUE
            if (subformula_r->predicate_id == PRED_TRUE) {
                _formula* temp1 = implRightTrue(_originalFml);
                Formula temp2(temp1, false);
                Formulas* ffs = new Formulas();
                ffs->pushBack(temp2);
                return ffs;
            }
        }
        //R3 F -> ~~G v false
        if (subformula_r->formula_type == NEGA &&
                subformula_r->subformula_l->formula_type == NEGA) {
            _originalFml->subformula_r = Utils::compositeByConnective(DISJ, subformula_r, NULL);
            _originalFml->subformula_r
                            ->subformula_r = Utils::compositeToAtom(PRED_FALSE, NULL);
            return rightRule_3(_originalFml);
        }
        //R4 F -> (G ^ H) v false
        if (subformula_r->formula_type == CONJ) {
            _originalFml->subformula_r = Utils::compositeByConnective(DISJ, subformula_r, NULL);
            _originalFml->subformula_r
                            ->subformula_r = Utils::compositeToAtom(PRED_FALSE, NULL);
            return rightRule_4(_originalFml);
        }
        //R5 F -> (G -> H) v false
        if (subformula_r->formula_type == IMPL) {
            _originalFml->subformula_r = Utils::compositeByConnective(DISJ,subformula_r, NULL);
	    _originalFml->subformula_r->subformula_r = Utils::compositeToAtom(PRED_FALSE, NULL);
            return rightRule_5(_originalFml);
        }
    }
	
    //start of imply missing
    if (_originalFml->formula_type == CONJ) {//直接进行分割
        Formula f(_originalFml, false);
        return f.divideFormula();
    }
	
    if (_originalFml->formula_type == DISJ) {
        commutaiveTrans(_originalFml, _originalFml, DISJ);
        _formula* CD_o = _originalFml->subformula_l;
        //disjLeftFalse，也可看成R1的转换
        if (CD_o->formula_type == ATOM &&
                CD_o->predicate_id == PRED_FALSE) {// false v G => G
            _formula* temp1 = disjLeftFalse(_originalFml);
            Formula temp2(temp1, false);
            Formulas* ffs = new Formulas();
            ffs->pushBack(temp2);
            return ffs;
        }
        //disjLeftTrue，也可看成R2的转换
        if (CD_o->formula_type == ATOM &&
                CD_o->predicate_id == PRED_TRUE) {// true v G => true
            _formula* temp1 = disjLeftTrue(_originalFml);
            Formula temp2(temp1, false);
            Formulas* ffs = new Formulas();
            ffs->pushBack(temp2);
            return ffs;
        }
        //R3
        if (CD_o->formula_type == NEGA && 
                CD_o->subformula_l->formula_type == NEGA) {// true -> ~~G v K
            _originalFml = Utils::compositeByConnective(IMPL, NULL, _originalFml);
            _originalFml->subformula_l = Utils::compositeToAtom(PRED_TRUE, NULL);
            return rightRule_3(_originalFml);
        }
        //R4
        if (CD_o->formula_type == CONJ) {// true -> (G ^ H) v K
            _originalFml = Utils::compositeByConnective(IMPL, NULL, _originalFml);
            _originalFml->subformula_l = Utils::compositeToAtom(PRED_TRUE, NULL);
            return rightRule_4(_originalFml);
        }
        //R5
        if (CD_o->formula_type == IMPL) {// true -> (G -> H) v K
            _originalFml = Utils::compositeByConnective(IMPL, NULL, _originalFml);
            _originalFml->subformula_l = Utils::compositeToAtom(PRED_TRUE, NULL);
            return rightRule_5(_originalFml);
        }
    }//end of _originalFml->formula_type == DISJ
	
    
    Formula f_result(_originalFml, false);
    Formulas* fs_result = new Formulas();
    fs_result->pushBack(f_result);
    return fs_result;
}
