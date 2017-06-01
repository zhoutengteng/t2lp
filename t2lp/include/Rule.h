#ifndef RULE_H
#define	RULE_H

#include <cstdio>
#include <string>
#include "Formula.h"
#include "Formulas.h"

class Formula;
class Formulas;
/*
 * 规则类
 */
class Rule {
private:
    Formulas* m_pHeadFormulas;//规则的头部
    Formulas* m_pBodyFormulas;//规则的体部
    string m_sRuleString;
private:
    void divideHead(const _formula* _head);
    void divideBody(const _formula* _body);
    void convertFormulaToRule(const _formula* _fml);
    void aspModify();
    void generateRuleString();
    void destroy();
public:
    Rule(const Formula& _fml);
    Rule(const Rule& _rhs);
    ~Rule();
    Rule& operator = (const Rule& _rhs);
    void output(FILE* _out) const;
};

#endif	/* RULE_H */

