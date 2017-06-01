#include "SMTranslator.h"
#include "HengZhang.h"
#include "Cabalar.h"
#include "Vocabulary.h"
#include "Utils.h"
#include "NNFUtils.h"
#include <assert.h>
#include <cstring>

SMTranslator::SMTranslator() :
        m_pHz(new HengZhang()),
        m_pOriginalFormulas(NULL),
        m_pHengZhangFormulas(NULL),
        m_pDlpFormulas(NULL),
        m_pNegaPredicates(NULL) {
}

SMTranslator::~SMTranslator() {
    if (m_pHz != NULL) {
        delete m_pHz;
        m_pHz = NULL;
    }
    destroy();
}

SMTranslator& SMTranslator::instance() {
    static SMTranslator theInstance;
    return theInstance;
}
/**
 * 初始化S2DLP求解器
 * @param _originalFml  调用divedeFormula方法，将原公式划分为多条子公式
 */
void SMTranslator::init(const Formula& _originalFml) {
    destroy();
    m_pOriginalFormulas = _originalFml.divideFormula();
    // m_pOriginalFormulas =  new Formulas();
    // m_pOriginalFormulas->pushBack(_originalFml);
    printf("\nthe prenex formulas\n\n");
    m_pOriginalFormulas->convertToPNF();
    m_pOriginalFormulas->output(stdout);
    printf("\n");
    printf("\nthe NNF formulas\n\n");
    m_pOriginalFormulas->convertToNNF();
    m_pOriginalFormulas->output(stdout);
    printf("\n");
    m_vOriginalFormulas = Utils::convertFormulasToStrings(m_pOriginalFormulas);
    m_pNegaPredicates = new Formulas();
}
/**
 * 初始化S2DLP求解器
 * @param _originalFmls
 */
void SMTranslator::init(const Formulas& _originalFmls) {
    destroy();
    m_pOriginalFormulas = new Formulas();
    for (FORMULAS_CONST_ITERATOR it = _originalFmls.begin(); 
            it != _originalFmls.end(); ++ it) {
        Formulas* tmp = it->divideFormula();
        m_pOriginalFormulas->joinBack(*tmp);
        delete tmp;
    }
    m_pOriginalFormulas->convertToPNF();
    m_pOriginalFormulas->convertToNNF();
    m_vOriginalFormulas = Utils::convertFormulasToStrings(m_pOriginalFormulas);
    m_pNegaPredicates = new Formulas();
}
/**
 * 销毁
 */
void SMTranslator::destroy() {
    if (m_pOriginalFormulas != NULL) {
        delete m_pOriginalFormulas;
        m_pOriginalFormulas = NULL;
    }
    if (m_pHengZhangFormulas != NULL) {
        delete m_pHengZhangFormulas;
        m_pHengZhangFormulas = NULL;
    }
    if (m_pDlpFormulas != NULL) {
        delete m_pDlpFormulas;
        m_pDlpFormulas = NULL;
    }
    if (m_pNegaPredicates != NULL) {
        delete m_pNegaPredicates;
        m_pNegaPredicates = NULL;
    }
    m_listRules.clear();
    m_vHengZhangFormulas.clear();
    m_vDlpFormulas.clear();
}
void SMTranslator::outputOriginalFormulas(FILE* _out) const {
    printf("ori:\n");
    output(_out, m_vOriginalFormulas);
}
/**
 * 进行章衡量词消去转化
 */
void SMTranslator::hengZhangTransform() {
    assert(m_pOriginalFormulas);
    m_pHengZhangFormulas = m_pHz->convert(*m_pOriginalFormulas);
    m_vHengZhangFormulas = Utils::convertFormulasToStrings(m_pHengZhangFormulas);
    delete m_pOriginalFormulas;
    m_pOriginalFormulas = NULL;
}
/**
 * 输出章衡转化结果
 * @param _out
 */
void SMTranslator::outputHengZhangFormulas(FILE* _out) const {
    printf("hz:\n\n");
    output(_out, m_vHengZhangFormulas);
}
/**
 * 对章衡转化结果进行Cabalar转化
 */
void SMTranslator::cabalarTransform() {
    assert(m_pHengZhangFormulas);
    m_pDlpFormulas = Cabalar::instance().convert(*m_pHengZhangFormulas);

    m_vDlpFormulas = Utils::convertFormulasToStrings(m_pDlpFormulas);
    delete m_pHengZhangFormulas;
    m_pHengZhangFormulas = NULL;
}
/**
 * 输出Cabalar转化结果
 * @param _out
 */
void SMTranslator::outputCabalarFormulas(FILE* _out) const {
    fprintf(_out, "cabalar:\n\n");
    output(_out, m_vDlpFormulas);
}
void SMTranslator::output(FILE* _out, vector<string> _vStr) const {
    for (vector<string>::const_iterator it = _vStr.begin();
            it != _vStr.end(); ++ it) {
        fprintf(_out, "%s\n", it->c_str());
    }
}
/**
 * 把Cabalar转化的结果转成供ASP使用的规则
 */
void SMTranslator::ruleTransform() {
    assert(m_pDlpFormulas);
    for (FORMULAS_CONST_ITERATOR it = m_pDlpFormulas->begin();
            it != m_pDlpFormulas->end(); ++ it) {
        Rule rule = Rule(*it);
        m_listRules.push_back(rule);
    }
    delete m_pDlpFormulas;
    m_pDlpFormulas = NULL;
}
/**
 * 输出规则
 * @param _out
 */
void SMTranslator::outputRules(FILE* _out) const {
    int i = 0;
    for (list<Rule>::const_iterator it = m_listRules.begin();
            it != m_listRules.end(); ++ it) {
        it->output(_out);
        if (++ i % 500 == 0) {
            fflush(_out);
        } 
    }
}
/**
 * 获取所有出现过非非的谓词公式
 * @return 
 */
const Formulas* SMTranslator::getNegaPredicates() const {
    return m_pNegaPredicates;
}
/**
 * 添加出现非非的谓词的公式
 * @param _negaPredicate
 */
void SMTranslator::addNegaPredicates(const Formula& _negaPredicate) {
    m_pNegaPredicates->pushBack(_negaPredicate);
}
/**
 * 章衡、Cabalar、规则全套服务
 */
void SMTranslator::convert() {
    hengZhangTransform();
    cabalarTransform();
    ruleTransform();
}
/**
 * 输出附加信息
 * @param _out
 */
void SMTranslator::outputAddition(FILE* _out) const {
    fprintf(_out, "%%MIN and MAX domain\n");
    map<int, string> domainNames = Vocabulary::instance().getDomainNames();
    for (map<int, string>::const_iterator it = domainNames.begin();
            it != domainNames.end(); ++ it) {
        if (strncmp("const", it->second.c_str(), 5) != 0) {
            fprintf(_out, "#domain min_%s(MIN_%s).\n", it->second.c_str(), it->second.c_str());
            fprintf(_out, "#domain max_%s(MAX_%s).\n", it->second.c_str(), it->second.c_str());
        }
    }
    
    fprintf(_out, "\n%%Variable domain\n");
    map<int, int> variablesDomains = Vocabulary::instance().getVariablesDomains();
    for (map<int, int>::const_iterator it = variablesDomains.begin();
            it != variablesDomains.end(); ++ it) {
        const char* variName = Vocabulary::instance().getNameById(it->first, VARIABLE);
        const char* domainName = Vocabulary::instance().getNameById(it->second, DOMAIN);
        if (strncmp("MIN", variName, 3) == 0 || 
                strncmp("MAX", variName, 3) == 0) {
            continue;
        }
        fprintf(_out, "#domain %s(%s).\n", domainName, variName);
        if (strncmp("const", domainName, 5) == 0) {
            fprintf(_out, "%s(%s).\n", domainName, domainName + 6);
        }
    }
    fprintf(_out, "\n%%Nega nega predicate define\n");
    for (FORMULAS_CONST_ITERATOR iter = m_pNegaPredicates->begin(); 
            iter != m_pNegaPredicates->end(); ++ iter) {
        // _p(X):- not p(X).
        fprintf(_out, "_");
        Utils::printAtom(iter->getFormula(), _out);
        fprintf(_out, ":- not ");
        Utils::printAtom(iter->getFormula(), _out);        
        fprintf(_out, ".\n");
        // :- not _p(X), p(X).
//        fprintf(_out, ":- not ");
//        fprintf(_out, "_");
//        Utils::printAtom(iter->getFormula(), _out);
//        fprintf(_out, ", ");
//        Utils::printAtom(iter->getFormula(), _out); 
//        fprintf(_out, ".\n");
    }
    fprintf(_out, "\n%%Extension predicate define\n");
    for(FORMULAS_CONST_ITERATOR iter = Vocabulary::instance().getAtomList()->begin(); 
            iter < Vocabulary::instance().getAtomList()->end(); ++ iter) {
        if(! Vocabulary::instance().isIntensionPredicate(iter->getFormula()->predicate_id)) {
            fprintf(_out, "_");
            Utils::printAtom(iter->getFormula(), _out);
            fprintf(_out, ":- not ");
            Utils::printAtom(iter->getFormula(), _out);
            fprintf(_out, ".\n");
            //p|_p
//            if (! Vocabulary::instance().isSuccOrMax(iter->getFormula()->predicate_id)) {
//                Utils::printAtom(iter->getFormula(), _out);
//                fprintf(_out, " | _");
//                Utils::printAtom(iter->getFormula(), _out);
//                fprintf(_out, ".\n");
//            }
        }
    }
    fprintf(_out, "\n%%Succ predicate definition\n");
    //ms_vDomainNames为在产生ｓｕｃｃ的时候，的存在量词所属的域
    for(unsigned int i = 0; i < Vocabulary::instance().ms_vDomainNames.size(); ++ i) {
        outputSucc(_out, Vocabulary::instance().ms_vDomainNames.at(i));
    }
    fprintf(_out, "eq(X,Y) :- X = Y.\n" );
    fprintf(_out, "\n");
    fflush(_out);
}
/**
 * 输出线序
 * @param _out
 * @param domains
 */
void SMTranslator::outputSucc(FILE* _out, vector<string> domains) const {
    int size = domains.size();
    
    if (size == 1) {
        fprintf(_out, "succ");
        for (int i = 0; i < size; ++ i) {
            fprintf(_out, "_%s", domains[i].c_str());
        }
        fprintf(_out, "(A1,A2):- A1==A2-1, %s(A1), %s(A2).\n", 
                domains[0].c_str(), domains[0].c_str());
    }
    else {
        for (int i = 0; i < size; ++ i) {
            fprintf(_out, "succ");
            for (int j = 0; j < size; ++ j) {
                fprintf(_out, "_%s", domains[j].c_str());
            }	
            fprintf(_out, "(");
            for (int j = 0; j < size; ++ j) {
                if (j >= size - i) {
                    fprintf(_out, "MAX_%s,", domains[j].c_str());
                }
                else if (j == size - i - 1) {
                    fprintf(_out, "%c1,", 'A' + j);
                }
                else {
                    fprintf(_out, "%c,", 'A' + j); 
                }
            }
            for (int j = 0; j < size; ++ j) {
                if (j >= size - i) {
                    fprintf(_out, "MIN_%s", domains.at(j).c_str());
                }
                else if (j == size - i - 1) {
                    fprintf(_out, "%c2", 'A' + j);
                }
                else {
                    fprintf(_out, "%c", 'A' + j);
                }
                if (j == size - 1) {
                    fprintf(_out, ")");
                }
                else {
                    fprintf(_out, ",");
                }
            }
	    //防止出现不产生最类似succ_vtx(A1,A2):- A1==A2-1, vtx(A1), vtx(A2)，　因为这个是size为１才能产生的,添加这个succ的产生
            bool exis = false;
            for (unsigned int j = 0; j < Vocabulary::instance().ms_vDomainNames.size(); ++ j) {
                if(Vocabulary::instance().ms_vDomainNames[j].size() == 1 && Vocabulary::instance().ms_vDomainNames[j][0] == domains[size - i - 1]) {
                    exis = true;
                }
            }
            if (! exis) {
                vector<string> d;
                d.push_back(domains[size - i - 1]);
                Vocabulary::instance().ms_vDomainNames.push_back(d);
            }
            fprintf(_out, ":- succ_%s(%c1,%c2), ", 
                    domains[size - i - 1].c_str(), 'A' + size - i - 1, 'A' + size - i - 1);

            for (int j = 0; j < size - i; ++ j) {
                if (j == size - i - 1) {
                    fprintf(_out, "%s(%c1), %s(%c2).", 
                            domains[j].c_str(), 'A' + j, domains[j].c_str(), 'A' + j);
                }
                else {
                    fprintf(_out, "%s(%c), ", domains[j].c_str(), 'A' + j);            
                }
            }
            
            fprintf(_out, "\n");
        }      
    }
}
/**
 * 输出供ASP使用的结果
 * @param _out
 */
void SMTranslator::outputFinalResult(FILE* _out) const {
    outputAddition(_out);
    outputRules(_out);
}