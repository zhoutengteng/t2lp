#ifndef UTIL_H
#define	UTIL_H

#include <cstdio>
#include "structs.h"
#include <map>
#include <vector>
#include <string>
#include "Vocabulary.h"
#include "Formulas.h"

using namespace std;



class Formulas;
/**
 * 工具类
 */
class Utils {
private:
    static void generateFormulaString(const _formula* _fml, string& _sRet);
    static void generateTermString(const _term* _t, string& _sRet);
public: 
    //对term的操作
    static void outputTerm(FILE* _out, const _term* _t);
    static void replaceTerm(_term* _ts, int _nArity, const vector<int>& _originals, 
                        const vector<int>& _replacements);
    static _term* combineTerms(const vector<int>& _head, const vector<int>& _tail);
    static bool compareTerm(const _term* _lhs, const _term* _rhs);
    static _term* copyTerms(const _term* _ts, int _nSize);
    static void deleteTerms(_term* _ts, int _nSize);
    static void renameTermVariables(_term* _t, int _nOldVariableId, int _nNewVariableId);
    //对formula的操作
    static void outputFormula(FILE* _out, const _formula* _fml);
    static bool compareFormula(const _formula* _lhs, const _formula* _rhs);
    static _formula* copyFormula(const _formula* _fml);
    static void deleteFormula(_formula* _fml);
    static bool isUniversal(_formula* _fml);
    static void renameFormulaVariables(_formula* _fml, int _nOldVariableId, int _nNewVariableId);
    static void getNoQuantifierVariables(map<int, bool>& _flag, vector<int>& _varis, _formula* _fml);
    static void getNoQuantifierVariablesInTerms(map<int, bool>& _flag, vector<int>& _varis, _term* _t);
    static bool isInList(int _target, const vector<int>& _vPredicates);
    static _formula* doubleNegationPredicates(_formula* _fml, const map<int, string>& _mapPredicates, 
                                        FORMULA_TYPE _fatherType = UNIV);
    static void replaceFormulaTerms(_formula* _fml, 
                                const vector<int>& _originals, 
				const vector<int>& _replacements);
    static void divideFormula(_formula* _fml, Formulas* _result);
    
    //对于rule
    static void printAtom(const _formula* _atom, FILE* _out);
    static string convertAtomToString(const _formula* _atom);
    static string convertFormulaToString(const _formula* _fml);
    
    
    static _formula* compositeByConnective(FORMULA_TYPE _formulaType, 
                         _formula* _subformulaL, _formula* _subformulaR = NULL);
    static _formula* compositeByQuantifier(FORMULA_TYPE _formulaType, 
                         _formula* _subformulaL, int _variableId);
    static _formula* compositeToAtom(int _predicateId, _term* _parameters);
    
    static vector<string> convertFormulasToStrings(Formulas* _fmls);

    static _formula* _thetaReplace(const int& _rId, _formula* _fml, _formula* _fatherFml = NULL);
    static _formula* _thetaReplace(const vector<int>& _preMiniPredicates, 
                const vector<int>& _curMiniPredicates, const vector<int>& _otherPredicates,
                const int& _rId, const int& _index, _formula* _fml, _formula* _fatherFml = NULL);
    static _formula* thetaT__Replace(_formula* _fml, _formula* _fatherFml = NULL);
    static _formula* thetaT__Replace(const vector<int>& _vPredicateP, const vector<int>& _vPredicateQ, 
                                _formula* _fml, _formula* _fatherFml);
    static _formula* removeImpl(_formula* _fml);
    static string convertNumToString(int _num);
    
    static _formula* convertDNFtoCNF(_formula* _fml);
    
    static _formula* convertToSt(_formula* _fml);
};



#endif	/* UTIL_H */

