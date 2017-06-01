#include "Rule.h"
#include "Utils.h"
#include "SMTranslator.h"
#include <assert.h>
#include <cstdlib>

Rule::Rule(const Formula& _fml) : 
        m_pHeadFormulas(new Formulas()),
        m_pBodyFormulas(new Formulas()),
        m_sRuleString("") {
    convertFormulaToRule(_fml.getFormula());
    aspModify();
    //存储正文asp
    generateRuleString();
}
Rule::Rule(const Rule& _rhs) : 
        m_pHeadFormulas(NULL),
        m_pBodyFormulas(NULL),
        m_sRuleString(_rhs.m_sRuleString) {
}
Rule::~Rule() {
    destroy();
}
Rule& Rule::operator = (const Rule& _rhs) {
    m_pHeadFormulas = NULL;
    m_pBodyFormulas = NULL;
    m_sRuleString = _rhs.m_sRuleString;
    return *this;
}
void Rule::destroy() {
    if (m_pHeadFormulas != NULL) {
        delete m_pHeadFormulas;
        m_pHeadFormulas = NULL;
    }
    if (m_pBodyFormulas != NULL) {
        delete m_pBodyFormulas;
        m_pBodyFormulas = NULL;
    }
}
/**
 * 输出规则
 * @param _out
 */
void Rule::output(FILE* _out) const {
    fprintf(_out, "%s\n", m_sRuleString.c_str());
}
/**
 * 生成规则的头部
 * @param _head
 */
void Rule::divideHead(const _formula* _head) {
    assert(_head);
    if (_head->formula_type != DISJ) {
        _formula* newHead = Utils::copyFormula(_head);
        m_pHeadFormulas->pushBack(Formula(newHead, false));
    }
    else {
        divideHead(_head->subformula_l);
        divideHead(_head->subformula_r);
    }
}
/**
 * 生成规则的体部
 * @param _body
 */
void Rule::divideBody(const _formula* _body) {
    assert(_body);
    if (_body->formula_type != CONJ) {
        _formula* newBody = Utils::copyFormula(_body);
        m_pBodyFormulas->pushBack(Formula(newBody, false));
    }
    else {
        divideBody(_body->subformula_l);
        divideBody(_body->subformula_r);
    }
}
/**
 * 把公式转化成规则
 * @param _fml
 */
void Rule::convertFormulaToRule(const _formula* _fml) {
    if (_fml == NULL) {
        return;
    }
    switch (_fml->formula_type) {
    case IMPL:
        divideHead(_fml->subformula_r);
        divideBody(_fml->subformula_l);
        break;
    case NEGA:
    case DISJ:
    case ATOM:
        divideHead(_fml);
        break;
    default:
        assert(0);
        break;
    }
}
/**
 * 处理多余的非
 */
void Rule::aspModify() {
    //把带非的，出现在头部的外延谓词，加上非，放到体部
    for (FORMULAS_ITERATOR iter = m_pHeadFormulas->begin(); 
            iter != m_pHeadFormulas->end(); ) {
        _formula* headPart = iter->getFormula();
        _formula* cur = headPart;
        while (cur->formula_type != ATOM) {
            cur = cur->subformula_l;
        }
        
        bool flag = false;
//        if ((headPart->formula_type == NEGA && (headPart->subformula_l->formula_type == NEGA)) 
//                || 
//                (cur->predicate_id >= 0 && 
//                        ! Vocabulary::instance()
//                                .isIntensionPredicate(cur->predicate_id))) {
        // /*modify by zhoutengteng*/ //
        if ((headPart->formula_type == NEGA) 
                || 
                (cur->predicate_id >= 0 && 
                        ! Vocabulary::instance()
                                .isIntensionPredicate(cur->predicate_id))) {
            _formula* newHeadPart = Utils::compositeByConnective(NEGA, 
                                        Utils::copyFormula(headPart), NULL);
            flag = true;
            iter = m_pHeadFormulas->erase(iter);
            m_pBodyFormulas->pushBack(Formula(newHeadPart, false));
        }               
        if (! flag) {
            ++ iter;
        }
    }
    
    //体部消除多余的非
    for (FORMULAS_ITERATOR iter = m_pBodyFormulas->begin(); 
            iter != m_pBodyFormulas->end(); ++ iter) {
        _formula* bodyPart = iter->getFormula();
        _formula* cur = bodyPart;
        
        while (cur->formula_type != ATOM) {
            cur = cur->subformula_l;
        }
        //Cabalar转换后，谓词最多只带一个～，由于头部不能出现～，所以头部的～p被移到体部后，就变成~~p
        //~~fml => fml
        if (! Vocabulary::instance().isIntensionPredicate(cur->predicate_id)) {
            if (bodyPart->formula_type == NEGA && bodyPart->subformula_l->formula_type == NEGA) {
                bodyPart = bodyPart->subformula_l->subformula_l;
            }
            iter->setFormula(Utils::copyFormula(bodyPart));
        }
        //～～~fml => ~fml
        else {
            if (bodyPart->formula_type == NEGA && bodyPart->subformula_l->formula_type == NEGA 
                        && bodyPart->subformula_l->subformula_l->formula_type == NEGA) {
                bodyPart = bodyPart->subformula_l->subformula_l;
            }
            iter->setFormula(Utils::copyFormula(bodyPart));
        }
    }
}
/**
 * 把规则转化成字符串
 */
void Rule::generateRuleString() {
    //　生成规则头部
    for (FORMULAS_ITERATOR it = m_pHeadFormulas->begin(); 
            it != m_pHeadFormulas->end(); ++ it) {
        _formula* headPart = it->getFormula();
        
        if (headPart->formula_type == NEGA) {
            m_sRuleString += "_";
            headPart = headPart->subformula_l;
        }
        
        if (headPart->formula_type == ATOM && headPart->predicate_id != PRED_FALSE 
                && headPart->predicate_id != PRED_TRUE) {
            m_sRuleString += Utils::convertAtomToString(headPart);      
            if (it != m_pHeadFormulas->end() - 1 && 
                    (it+1)->getFormula()->predicate_id != PRED_FALSE &&
                        (it+1)->getFormula()->predicate_id != PRED_TRUE) {
                m_sRuleString += " | ";
            }
        }        
    }
    //　生成规则体部
    bool bodyBegin = true;
    
    for (FORMULAS_ITERATOR it = m_pBodyFormulas->begin(); 
            it != m_pBodyFormulas->end(); ++ it) {
        _formula* bodyPart = it->getFormula();
        _formula* cur = bodyPart;
        
        while (cur->formula_type != ATOM) {
            cur = cur->subformula_l;
        }                
        
        if (cur->predicate_id != PRED_TRUE && cur->predicate_id != PRED_FALSE) {            
            if (bodyBegin) {
                m_sRuleString += ":- ";
                bodyBegin = false;
            }
            
            if (bodyPart->formula_type == NEGA) {
                m_sRuleString += "not ";
                bodyPart = bodyPart->subformula_l;
                if (bodyPart->formula_type == NEGA) {
                    bool exis = false;
                    for (FORMULAS_CONST_ITERATOR it_2 = SMTranslator::instance().getNegaPredicates()->begin();
                            it_2 != SMTranslator::instance().getNegaPredicates()->end(); ++ it_2) {
                        if (it_2->getFormula()->predicate_id == bodyPart->subformula_l->predicate_id) {
                            exis = true;
                        }
                    }
                    if (! exis) {
                        Formula newNegaPredicate = Vocabulary::instance()
                                        .getAtom(bodyPart->subformula_l->predicate_id); 
                        assert(newNegaPredicate.getFormula());
                        SMTranslator::instance().addNegaPredicates(newNegaPredicate);
                    }
                    m_sRuleString += "_";
                }
            }            
            m_sRuleString += Utils::convertAtomToString(cur);
            if(it != m_pBodyFormulas->end() - 1 && (it+1)->getFormula()->predicate_id != PRED_FALSE &&
                (it+1)->getFormula()->predicate_id != PRED_TRUE) {
                m_sRuleString += ", ";
            }
        }
    }  
    if (m_pHeadFormulas->size() + m_pBodyFormulas->size() != 0) {
        m_sRuleString += ".";
    }
    destroy();
}
