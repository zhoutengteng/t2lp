#include "Vocabulary.h"
#include "SMTranslator.h"
#include "Utils.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <assert.h>

Vocabulary& Vocabulary::instance() {
    static Vocabulary vocabulary;
    return vocabulary;
}

Vocabulary::Vocabulary() : m_nVariableId(0), m_nDomainId(0), m_nFunctionId(0),
        m_nPredicateId(0), m_nRenameVariablePostfix(0), m_nSPostfix(0), m_nWPostfix(0), 
        m_nTPostfix(0), m_nRPostfix(0), m_nPrenexRenamePostfix(0), m_nRenameVariPostfix(0),
        m_nPriIndex(0) {
    m_mapVariableName.clear();
    m_mapDomainName.clear();
    m_mapFunctionName.clear();
    m_mapPredicateName.clear();
    
    m_mapVariableDomain.clear();
    m_mapFunctionArity.clear();
    m_mapPredicateArity.clear();
    m_mapIsIntensionPredicate.clear();
    m_mapIsVaryPredicate.clear();
    m_mapDomainVariables.clear();
    m_vvMininalPredicates.clear();
    m_mapConstVariables.clear();
    m_fmlAtomList = new Formulas();
}

Vocabulary::~Vocabulary() {
    if (m_fmlAtomList != NULL) {
        delete m_fmlAtomList;
        m_fmlAtomList = NULL;
    }
    m_mapVariableName.clear();
    m_mapDomainName.clear();
    m_mapFunctionName.clear();
    m_mapPredicateName.clear();
    m_mapVariableDomain.clear();
    m_mapFunctionArity.clear();
    m_mapPredicateArity.clear();
    m_mapIsIntensionPredicate.clear();
    m_mapIsVaryPredicate.clear();
    m_mapDomainVariables.clear();
    m_vvMininalPredicates.clear();
    m_mapConstVariables.clear();
}
/**
 * 保存内涵谓词
 * @param _name 内涵谓词名
 */
void Vocabulary::addIntensionPredicate(const char* _name) {
    int id = getSymbolId(_name, PREDICATE);
    m_mapIsIntensionPredicate[id] = true;
}
void Vocabulary::addIntensionPredicate(int _predicateId) {
    map<int, string>::const_iterator it = m_mapPredicateName.find(_predicateId);
    assert(it != m_mapPredicateName.end());
    m_mapIsIntensionPredicate[_predicateId] = true;
}
/**
 * 保存可变谓词
 * @param _name
 */
void Vocabulary::addVaryPredicate(const char* _name) {
    int id = getSymbolId(_name, PREDICATE);
    m_mapIsVaryPredicate[id] = true;
}
/**
 * 获取变量所在论域
 * @param _variableId
 * @return 
 */
const char* Vocabulary::getVariableDomain(int _variableId) {
    int domainId = m_mapVariableDomain[_variableId];
    return getNameById(domainId, DOMAIN);
}
/**
 * 记录变量的论域
 * @param _variable 变量名
 * @param _domain 论域名
 */
void Vocabulary::setVariableDomain(const char* _variable, const char* _domain) {
    int domainId = getSymbolId(_domain, DOMAIN);
    int variableId;
    if(domainId == -1) {
        domainId = m_nDomainId ++;
        m_mapDomainName[domainId] = _domain;
    }
    if((variableId = getSymbolId(_variable, VARIABLE)) != -1) {
        m_mapVariableDomain[variableId] = domainId;
        if (! Utils::isInList(variableId, m_mapDomainVariables[domainId])) {
            m_mapDomainVariables[domainId].push_back(variableId);
        }
    }
}
/**
 * 设置极少化谓词的优先级
 * @param _sName
 * @param _bIsNewLevel
 */
void Vocabulary::setMininalPredicatePriority(const char* _sName) {
    int predicateId = getSymbolId(_sName, PREDICATE);
    assert(predicateId != -1);
    while (m_nPriIndex >= m_vvMininalPredicates.size()) {
        m_vvMininalPredicates.push_back(vector<int>());
    }
    
    m_vvMininalPredicates[m_nPriIndex].push_back(predicateId);
}
/**
 * 查询符号的id
 * @param _name 符号名字
 * @param _type 符号类型
 * @return 符号的id 
 */
int Vocabulary::getSymbolId(const char* _name, SYMBOL_TYPE _type) {
    
    //return value: 1. >=0 id; 2. -1 no such symbol; 3. -2 type error
    assert(_name);

    string name = _name;
    map<int, string> mapIdName;
    switch(_type)
    {
    case VARIABLE:
        mapIdName = m_mapVariableName;
        break;
    case FUNCTION:
        mapIdName = m_mapFunctionName;
        break;
    case PREDICATE:
        mapIdName = m_mapPredicateName;
        break;
    case DOMAIN:
        mapIdName = m_mapDomainName;
        break;  
    default:
        assert(0);
        return -2;
    }

    for (map<int, string>::const_iterator it = mapIdName.begin(); 
            it != mapIdName.end(); ++ it) {
        if (it->second == name) {
            return it->first;
        }
    }

    return -1;
}
/**
 * 把符号标识添加到字符表
 * @param _name 符号标识
 * @param _type 类型(变量、函词、谓词)
 * @param _arity 参数个数
 * @return 符号标识的id
 */
int Vocabulary::addSymbol(const char* _name, SYMBOL_TYPE _type, int _arity )
{
    // return value: 1. >=0 - id; 2. -1 - too many symbols; 3. -2 - _type error
    assert(_name);
    
    int id;
    string name = _name;
    
    if((id = getSymbolId(_name, _type)) < 0) {

        switch (_type) {
        case VARIABLE:
            id = m_nVariableId ++;
            m_mapVariableName[id] = name;
            break;
        case FUNCTION:
            id = m_nFunctionId ++;
            m_mapFunctionName[id] = name;
            m_mapFunctionArity[id] = _arity;
            break;
        case PREDICATE:
            id = m_nPredicateId ++;
            m_mapPredicateName[id] = name;
            m_mapPredicateArity[id] = _arity;
            break;
        default:
            assert(0);
            return -2;
        }
    }
    
    return id;
}
/**
 * 获取谓词的参数个数
 * @param _id 谓词id
 * @return 参数个数
 */
int Vocabulary::getPredicateArity(int _id) {
    if(_id < 0) {
        return spec_pred_arities[-_id-1];
    }
    else { 
        map<int, int>::const_iterator it = m_mapPredicateArity.find(_id);
        assert(it != m_mapPredicateArity.end());
        return it->second;
    }
}
/**
 * 获取函词的参数个数
 * @param _id 函词id
 * @return 参数个数
 */
int Vocabulary::getFunctionArity(int _id) {
    map<int, int>::const_iterator it = m_mapFunctionArity.find(_id);
    assert(it != m_mapFunctionArity.end());
    return it->second;
}
/**
 * 保存重命名变量
 * @return 变量Id
 */
int Vocabulary::addRenameVariable() {
    char nameBuf[10];
    sprintf(nameBuf, "%s%d", PRENEX_RENAME_PREFIX, m_nRenameVariablePostfix ++);
    return addSymbol(nameBuf, VARIABLE);
}
/**
 * 查询谓词是否为内涵谓词
 * @param _variableId
 * @return 
 */
bool Vocabulary::isIntensionPredicate(int _nPredicateId) const {
    map<int, bool>::const_iterator it = m_mapIsIntensionPredicate.find(_nPredicateId);
    return it != m_mapIsIntensionPredicate.end() ? true : false;
}
/**
 * 查询谓词是否为可变谓词
 * @param _nPredicateId
 * @return 
 */
bool Vocabulary::isVaryPredicate(int _nPredicateId) const {
    map<int, bool>::const_iterator it = m_mapIsVaryPredicate.find(_nPredicateId);
    return it != m_mapIsVaryPredicate.end() ? true : false;
}
bool Vocabulary::isSuccOrMax(int _nPredicateId) const {
    const char* name = getNameById(_nPredicateId, PREDICATE);
    assert(name);
    if (strncmp(name, "succ", 4) == 0 || strncmp(name, "max", 3) == 0) {
        return true;
    }
    return false;
}
/**
 * 获取id对应的名字
 * @param _id 
 * @param _type 类型
 * @return 
 */
const char* Vocabulary::getNameById(int _id, SYMBOL_TYPE _type) const {
    assert(0 <= _id);
    
    map<int, string>::const_iterator it;
    switch (_type)
    {
    case VARIABLE:
        it = m_mapVariableName.find(_id);
        if (it != m_mapVariableName.end()) {
            return (it->second).c_str();
        }
        break;
    case FUNCTION:
        it = m_mapFunctionName.find(_id);
        if (it != m_mapFunctionName.end()) {
            return (it->second).c_str();
        }
        break;
    case PREDICATE:
        it = m_mapPredicateName.find(_id);
        if (it != m_mapPredicateName.end()) {
            return (it->second).c_str();
        }
        break;
    case DOMAIN:
        it = m_mapDomainName.find(_id);
        if (it != m_mapDomainName.end()) {
            return (it->second).c_str();
        }
        break;
    default:
        assert ( 0 );
    }
    return NULL;
}
/**
 * 输出字符表的信息
 * @param out
 */
void Vocabulary::dumpVocabulary(FILE* _out)  {
    
    fprintf(_out, "\nvariable:\n");
    for (map<int, string>::const_iterator it = m_mapVariableName.begin(); 
            it != m_mapVariableName.end(); ++ it) {
        fprintf(_out, "%s ", (it->second).c_str());
    }
    
    fprintf(_out, "\nfunction:\n");
    for (map<int, string>::const_iterator it = m_mapFunctionName.begin(); 
            it != m_mapFunctionName.end(); ++ it) {
        fprintf(_out, "%s ", (it->second).c_str());
    }
    
    fprintf(_out, "\npredicate:\n");
    for (map<int, string>::const_iterator it = m_mapPredicateName.begin(); 
            it != m_mapPredicateName.end(); ++ it) {
        fprintf(_out, "%s:%d\t", (it->second).c_str(), it->first);
    }
    
    fprintf(_out, "\nmininal predicates' priority:\n");
    for (unsigned int i = 0; i < m_vvMininalPredicates.size(); ++ i) {
        for (unsigned int j = 0; j < m_vvMininalPredicates[i].size(); ++ j) {
            fprintf(_out, "%s:%d\t", getNameById(m_vvMininalPredicates[i][j], PREDICATE), i);
        }
    }
    
    fprintf(_out, "\nintension predicate:\n");
    for (map<int, string>::const_iterator it = m_mapPredicateName.begin(); 
            it != m_mapPredicateName.end(); ++ it) {
        if (isIntensionPredicate(it->first)) {
            fprintf(_out, "%s ", (it->second).c_str());
        }
    }
    fprintf(_out, "\nvary predicate:\n");
    for (map<int, string>::const_iterator it = m_mapPredicateName.begin(); 
            it != m_mapPredicateName.end(); ++ it) {
        if (isVaryPredicate(it->first)) {
            fprintf(_out, "%s ", (it->second).c_str());
        }
    }
    
    fprintf(_out, "\ndomains:");    
    for (map<int, string>::const_iterator it = m_mapDomainName.begin(); 
            it != m_mapDomainName.end(); ++ it) {
        fprintf(_out, "\nvariables at domain %s: ", (it->second).c_str());
        vector<int> variables = m_mapDomainVariables[it->first];
        for (vector<int>::const_iterator it2 = variables.begin();
                it2 != variables.end(); ++ it2) {
            fprintf(_out, "%s", m_mapVariableName[*it2].c_str());
            if (it2 != variables.end() - 1) {
                fprintf(_out, ", ");
            }
        }
    }
    
    fprintf(_out, "\n\natom:\n");
    for (FORMULAS_CONST_ITERATOR it = m_fmlAtomList->begin();
            it != m_fmlAtomList->end(); ++ it) {
        it->output(stdout);
    }
}

Formula Vocabulary::getAtom(int _predicateId) const {
    for (FORMULAS_CONST_ITERATOR it = m_fmlAtomList->begin();
            it != m_fmlAtomList->end(); ++ it) {
        if (it->getFormula()->predicate_id == _predicateId) {
            return *it;
        }
    }
    return Formula();
}
void Vocabulary::addAtom(const Formula& _newAtom) {
    for (FORMULAS_CONST_ITERATOR iter = m_fmlAtomList->begin();
            iter != m_fmlAtomList->end(); ++ iter) {
        if (iter->getFormula()->predicate_id == _newAtom.getFormula()->predicate_id) {
            return;
        }
    }
    m_fmlAtomList->pushBack(_newAtom);
}

map<int, string> Vocabulary::getDomainNames() const {
    return m_mapDomainName;
}

map<int, int> Vocabulary::getVariablesDomains() const {
    return m_mapVariableDomain;
}

Formulas* Vocabulary::getAtomList() const {
    return m_fmlAtomList;
}
/**
 * 获取所有谓词
 * @return 
 */
map<int, string> Vocabulary::getAllPredicates() const {
    return m_mapPredicateName;
}
/**
 * 获取所有内涵谓词
 * @return 
 */
map<int, string> Vocabulary::getAllIntensionPredicates() const {
    map<int, string> vRet;
    for (map<int, string>::const_iterator it = m_mapPredicateName.begin();
            it != m_mapPredicateName.end(); ++ it) {
        if (isIntensionPredicate(it->first)) {
            vRet.insert(make_pair<int, string>(it->first, it->second));
        }
    }
    return vRet;
}
/**
 * 获取所有可变谓词
 * @return 
 */
map<int, string> Vocabulary::getAllVaryPredicates() const {
    map<int, string> vRet;
    for (map<int,string>::const_iterator it = m_mapPredicateName.begin();
            it != m_mapPredicateName.end(); ++ it) {
        if (isVaryPredicate(it->first)) {
            vRet.insert(make_pair<int, string>(it->first, it->second));
        }
    }
    return vRet;
}

vector<int> Vocabulary::getAllVaryPredicatesId() const {
    vector<int> ret;
    for (map<int,string>::const_iterator it = m_mapPredicateName.begin();
            it != m_mapPredicateName.end(); ++ it) {
        if (isVaryPredicate(it->first)) {
            ret.push_back(it->first);
        }
    }
    return ret;
}

vector< vector<int> > Vocabulary::getAllMininalPredicates() const {
    return m_vvMininalPredicates;
}

int Vocabulary::generatePredicateS(vector<int> _termsX, vector<int> _termsY) {
    char name[32];
    sprintf(name, "%s%d", S_PREFIX, m_nSPostfix ++);
    int id = addSymbol(name, PREDICATE, _termsX.size() + _termsY.size());
    _term* t = Utils::combineTerms(_termsX, _termsY);
    addAtom(Formula(Utils::compositeToAtom(id, t), false));
    return id;
}

int Vocabulary::generatePredicateW(vector<int> _termsX, vector<int> _termsY) {
    char name[32];
    sprintf(name, "%s%d", W_PREFIX, m_nWPostfix ++);
    int id = addSymbol(name, PREDICATE, _termsX.size() + _termsY.size());
    _term* t = Utils::combineTerms(_termsX, _termsY);
    addAtom(Formula(Utils::compositeToAtom(id, t), false));
    return id;
}

int Vocabulary::generatePredicateT(vector<int> _termsX, vector<int> _termsY) {
    char name[32];
    sprintf(name, "%s%d", T_PREFIX, m_nTPostfix ++);
    int id = addSymbol(name, PREDICATE, _termsX.size() + _termsY.size());
    _term* t = Utils::combineTerms(_termsX, _termsY);
    addAtom(Formula(Utils::compositeToAtom(id, t), false));
    return id;
}

int Vocabulary::generatePredicateR(vector<int> _termsX, vector<int> _termsY) {
    char name[32];
    sprintf(name, "%s%d", R_PREFIX, m_nRPostfix ++);
    int id = addSymbol(name, PREDICATE, _termsX.size() + _termsY.size());
    _term* t = Utils::combineTerms(_termsX, _termsY);
    addAtom(Formula(Utils::compositeToAtom(id, t), false));
    return id;
}

int Vocabulary::generatePredicateSucc(vector<int> _termsY, vector<int> _termsZ) {
    string succName = SUCC_PREFIX;
    vector<string> domainNames;
    for (unsigned int i = 0; i < _termsY.size(); ++ i) {
        const char* sDomainName = Vocabulary::instance().getVariableDomain(_termsY[i]);
        succName += string("_") + sDomainName;
        domainNames.push_back(string(sDomainName));
    }
    int id = Vocabulary::instance().getSymbolId(succName.c_str(), PREDICATE);
    if (id != -1) {
        return id;
    }
    id = Vocabulary::instance().addSymbol(succName.c_str(), 
                        PREDICATE, _termsY.size() + _termsZ.size());
    Vocabulary::instance().ms_vDomainNames.push_back(domainNames);
    //保存谓词原型
    _term* term_y_z   = Utils::combineTerms(_termsY, _termsZ);
    _formula* succ_y_z = Utils::compositeToAtom(id, term_y_z);
    //这里term_y_z在ＩＤＥ显示不正确，进入combineTerms可以知道，申请了４个_term宽度的数组长度，这里IDE现实不出来
    Vocabulary::instance().addAtom(Formula(succ_y_z, false));
    return id;
}

int Vocabulary::generateDomainMIN(const char* _domain) {
    char sBuf[32];
    sprintf(sBuf, "%s%s", MIN_VARI_PREFIX, _domain);
    int id = Vocabulary::instance().getSymbolId(sBuf, VARIABLE);
    if (-1 != id) {
        return id;
    }
    id = Vocabulary::instance().addSymbol(sBuf, VARIABLE);
    return id;
}

int Vocabulary::generateDomainMAX(const char* _domain) {
    char sBuf[32];
    sprintf(sBuf, "%s%s", MAX_VARI_PREFIX, _domain);
    int id = Vocabulary::instance().getSymbolId(sBuf, VARIABLE);
    if (-1 != id) {
        return id;
    }
    id = Vocabulary::instance().addSymbol(sBuf, VARIABLE);
    return id;
}

int Vocabulary::generateNewVariable(int _oriVariId) {
    char sBuf[32];
    sprintf(sBuf,"%s%d", RENAME_VARI_PREFIX, m_nRenameVariPostfix ++);
    int id = Vocabulary::instance().addSymbol(sBuf, VARIABLE);
    Vocabulary::instance().setVariableDomain(sBuf, 
                    Vocabulary::instance().getVariableDomain(_oriVariId));
    return id;
}
void Vocabulary::increaseMininalPredicatePriority() {
    ++ m_nPriIndex;
}
/**
 * 添加常量
 * @param _nNum
 */
int Vocabulary::addConstant(int _nNum) {
    char variName[64];
    sprintf(variName, "%s%d", CONST_VARI_PREFIX, _nNum);
    int variId = addSymbol(variName, VARIABLE);
    assert(variId >= 0);
    char domainName[64];
    sprintf(domainName, "%s%d", CONST_DOMAIN_PREFIX, _nNum);
    setVariableDomain(variName, domainName);
    m_mapConstVariables[variName] = domainName;
    return variId;
}

map<int, string> Vocabulary::getAllVariableName() const {
    return m_mapVariableName;
}