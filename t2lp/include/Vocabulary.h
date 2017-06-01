#ifndef VOCABULARY_H
#define VOCABULARY_H

#include "structs.h"
#include <cstdio>
#include <vector>
#include <map>
#include <string>
#include "Formulas.h"

using namespace std;

#define S_PREFIX "s_"
#define W_PREFIX "w_"
#define T_PREFIX "t_"
#define R_PREFIX "r_"
#define SUCC_PREFIX "succ"
#define PRENEX_RENAME_PREFIX "PN_"
#define RENAME_VARI_PREFIX "NV_"
#define VARY_PREDICATE_POSTFIX "_vary"
#define MIN_VARI_PREFIX "MIN_"
#define MAX_VARI_PREFIX "MAX_"
#define MIN_DOMAIN_PREFIX "min_"
#define MAX_DOMAIN_PREFIX "max_"
#define CONST_VARI_PREFIX "CONST_"
#define CONST_DOMAIN_PREFIX "const_"

class Formual;
class Formulas;

using namespace std;
/*
 * 字符表类，保存各种信息
 */
class Vocabulary {
private:
    // 变量、论域、函词、谓词 id
    unsigned int m_nVariableId;
    unsigned int m_nDomainId;
    unsigned int m_nFunctionId;
    unsigned int m_nPredicateId;
    // 重名变量后缀
    unsigned int m_nRenameVariablePostfix;
    // s,w,t谓词后缀
    unsigned int m_nSPostfix;
    unsigned int m_nWPostfix;
    unsigned int m_nTPostfix;
    unsigned int m_nRPostfix;
    unsigned int m_nPrenexRenamePostfix;
    unsigned int m_nRenameVariPostfix;
    unsigned int m_nPriIndex;
    

    map<int, string> m_mapVariableName;         // map[变量id] = 对应的变量名
    map<int, string> m_mapDomainName;           // map[论域id] = 对应的论域名
    map<int, string> m_mapFunctionName;         // map[函词id] = 对应的函词名
    map<int, string> m_mapPredicateName;        // map[谓词id] = 对应的谓词名
    
    map<int, int> m_mapVariableDomain;          // map[变量id] = 所在的论域id
    map<int, int> m_mapFunctionArity;           // map[函词id] = 函词的参数个数
    map<int, int> m_mapPredicateArity;          // map[谓词id] = 谓词的参数个数
    
    map<int, vector<int> > m_mapDomainVariables;// map[论域id] = 在该论域的变量的id的数组 
    
    map<int, bool> m_mapIsIntensionPredicate;   // 记录是否为内涵谓词
    map<int, bool> m_mapIsVaryPredicate;        // 记录是否为可变谓词
    vector< vector<int> > m_vvMininalPredicates;
    map<string, string> m_mapConstVariables;
    
    Formulas* m_fmlAtomList;
public:    
    vector< vector<string> > ms_vDomainNames;

private:
    Vocabulary();
    Vocabulary(const Vocabulary&);
    Vocabulary& operator =(const Vocabulary&);
    ~Vocabulary();

public:
    static Vocabulary& instance();
    void dumpVocabulary(FILE* _out) ;
    //setter adder
    void setVariableDomain(const char* _sVariable, const char* _sDomain);
    void setMininalPredicatePriority(const char* _sName);
    int addSymbol(const char* _sName, SYMBOL_TYPE _type, int _nArity = 0);
    int addRenameVariable();
    void addIntensionPredicate(const char*_sName);
    void addIntensionPredicate(int _predicateId);
    void addVaryPredicate(const char* _sName);
    void addAtom(const Formula& _newAtom);
    //getter
    bool isIntensionPredicate(int _nPredicateId) const;
    bool isVaryPredicate(int _nPredicateId) const;
    bool isSuccOrMax(int _nPredicateId) const;
    int getSymbolId(const char* _sName, SYMBOL_TYPE _type);
    int getPredicateArity(int _id);
    int getFunctionArity(int _id);
    const char* getVariableDomain(int _nVariableId);
    const char* getNameById(int _nId, SYMBOL_TYPE _type) const;
    map<int, string> getDomainNames() const;
    map<int, int> getVariablesDomains() const;
    Formula getAtom(int _nPredicateId) const;
    Formulas* getAtomList() const;
    map<int, string> getAllPredicates() const;
    map<int, string> getAllIntensionPredicates() const;
    map<int, string> getAllVaryPredicates() const;
    map<int, string> getAllVariableName() const;
    vector<int> getAllVaryPredicatesId() const;
    vector< vector<int> > getAllMininalPredicates() const;
    
    //生成新的s,w,t
    int generatePredicateS(vector<int> _termsX, vector<int> _termsY);
    int generatePredicateW(vector<int> _termsX, vector<int> _termsY);
    int generatePredicateT(vector<int> _termsX, vector<int> _termsY);
    int generatePredicateR(vector<int> _termsX, vector<int> _termsY);
    int generatePredicateSucc(vector<int> _termsY, vector<int> _termsZ);
    int generateDomainMIN(const char* _domain);
    int generateDomainMAX(const char* _domain);
    int generateNewVariable(int _oriVariId);

    void increaseMininalPredicatePriority();
    int addConstant(int _nNum);
};

#endif
