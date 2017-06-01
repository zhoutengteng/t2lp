#ifndef SMTRANSLATOR_H
#define	SMTRANSLATOR_H

#include "Formula.h"
#include "Formulas.h"
#include "Rule.h"
#include "HengZhang.h"
#include <list>
#include <string>
#include <vector>
#include <cstdio>

class HengZhang;
class Formula;
class Formulas;
class Rule;
/*
 * StableModel转换器，单例
 */
class SMTranslator {
private:
    HengZhang* m_pHz;
    Formulas* m_pOriginalFormulas;      //原公式
    vector<string> m_vOriginalFormulas;
    Formulas* m_pHengZhangFormulas;     //章衡转化结果
    vector<string> m_vHengZhangFormulas;
    Formulas* m_pDlpFormulas;           //Cabalar转化结果
    vector<string> m_vDlpFormulas;
    Formulas* m_pNegaPredicates;        //出现非非的谓词公式
    list<Rule> m_listRules;             //转换后的所有规则
private:
    SMTranslator();
    SMTranslator(const SMTranslator&);
    SMTranslator& operator = (const SMTranslator&);
    ~SMTranslator();
    
    void hengZhangTransform();
    void cabalarTransform();
    void ruleTransform();
    void output(FILE* _out, vector<string> _vStr) const;
    void outputSucc(FILE* _out, vector<string> domains) const;
    void outputAddition(FILE* _out) const;
public:
    static SMTranslator& instance();
    
    void init(const Formula& _originalFml);
    void init(const Formulas& _originalFmls);
    void destroy();
    void convert();
    void outputOriginalFormulas(FILE* _out) const;
    void outputHengZhangFormulas(FILE* _out) const;
    void outputCabalarFormulas(FILE* _out) const;
    void outputRules(FILE* _out) const;
    
    void outputFinalResult(FILE* _out) const;
    const Formulas* getNegaPredicates() const;
    void addNegaPredicates(const Formula& _negaPredicate);
};

#endif	/* SMTRANSLATOR_H */

