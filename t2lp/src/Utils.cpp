#include "Utils.h"
#include <assert.h>
#include <cstdlib>
#include <cstring>
/**
 * 输出term
 * @param _out
 * @param _t
 */
void Utils::outputTerm(FILE* _out, const _term* _t) {
    assert (_t);

    if (VARI==_t->term_type) {
        fprintf(_out, "%s", Vocabulary::instance().getNameById(_t->variable_id, VARIABLE));
    }
    else {
        fprintf(_out, "%s", Vocabulary::instance().getNameById(_t->function_id, FUNCTION));
        int k = Vocabulary::instance().getFunctionArity(_t->function_id);
        if (k > 0) {
            fprintf ( _out, "(" );
            for (int i = 0; i < k; ++ i) {
                if (0 < i) {
                    printf(", ");
                }
                outputTerm(_out, _t->parameters+i);
            }
            fprintf(_out, ")");
        }
    }
}
/**
 * 替换参数
 * @param _t 参数
 * @param _arity　参数个数
 * @param _originals　带替换的参数
 * @param _replacements　替换值
 */
void Utils::replaceTerm(_term* _ts, int _arity, const vector<int>& _originals, 
                        const vector<int>& _replacements) {
    for(int i = 0; i < _arity; i++) {
        //replacement
        if(_ts[i].term_type == VARI) {
            for(unsigned int j = 0; j < _originals.size(); j++) {
                if(_ts[i].variable_id == _originals[j]) {
                    _ts[i].variable_id = _replacements[j];
                }
            }
        }
        //traversal
        else if(_ts[i].term_type == FUNC) {
            replaceTerm(_ts[i].parameters, 
                        Vocabulary::instance().getFunctionArity(_ts[i].function_id), 
                        _originals, _replacements);
        }
    }
}
/**
 * 连接参数 {X,Y} {Z,R}=>{X,Y,Z,R}
 * @param _head
 * @param _tail
 * @return _term* 结果:{X,Y,Z,R}
 */
_term* Utils::combineTerms(const vector<int>& _head, const vector<int>& _tail) {
    _term* terms = (_term*)malloc(sizeof(_term) * (_head.size() + _tail.size()));
    int index = 0;
    for(std::vector<int>::const_iterator it = _head.begin();
		it != _head.end(); it++, index++) {
        terms[index].variable_id = _head[index];
        terms[index].term_type = VARI;
    }
    index = 0;
    for(std::vector<int>::const_iterator it = _tail.begin(); 
		it != _tail.end(); it++, index++) {
        terms[index+_head.size()].variable_id = _tail[index];
        terms[index+_head.size()].term_type = VARI;
    }
    return terms;
}
/**
 * 比较两个term是否相同
 * @param _lhs
 * @param _rhs
 * @return bool
 */
bool Utils::compareTerm(const _term* _lhs, const _term* _rhs) {
    assert(_lhs);
    assert(_rhs);

    if (_lhs->term_type != _rhs->term_type) {
        return false;
    }

    int k;
    switch (_lhs->term_type)
    {
    case VARI:
        return (_lhs->variable_id == _rhs->variable_id);
    case FUNC:
        if (_lhs->function_id == _rhs->function_id) {
            k = Vocabulary::instance().getFunctionArity(_lhs->function_id) - 1;
            assert(k < 0 || _lhs->parameters);
            assert(k < 0 || _rhs->parameters);
            for ( ; k >= 0; -- k) {
                if (! compareTerm(_lhs->parameters + k, _rhs->parameters + k)) {
                    return false;
                }
            }
            return true;
        }
    default:
        assert(0);
    }
    return false;
}
/**
 * 拷贝参数
 * @param _terms 待拷贝的参数
 * @param _size  参数个数
 * @return 拷贝结果
 */
_term* Utils::copyTerms(const _term* _ts, int _size) {
    _term* newTerms = (_term*)malloc(sizeof(_term)*_size);
    assert(newTerms);

    memcpy(newTerms, _ts, sizeof(_term)*_size);

    for(int i = 0; i < _size; ++ i) {
        if(_ts[i].term_type == FUNC) {
            newTerms[i].parameters = copyTerms(_ts[i].parameters,
			Vocabulary::instance().getFunctionArity(_ts[i].function_id));
        }
    }

    return newTerms;
}
/**
 * 销毁term指针
 * @param _ts term指针
 * @param _size 元素个数
 */
void Utils::deleteTerms(_term* _ts, int _size) {
    for(int i = 0; i < _size; ++ i) {
        if(_ts[i].term_type == FUNC) {
            deleteTerms(_ts[i].parameters,
                    Vocabulary::instance().getFunctionArity(_ts[i].function_id));
        }
    }
    free(_ts);
}
/**
 * 重命名参数
 * @param _t 
 * @param _oldVariableId
 * @param _newVariableId
 */
void Utils::renameTermVariables(_term* _t, int _oldVariableId, int _newVariableId) {
    int i;
    assert(_t);

    switch(_t->term_type)
    {
    case VARI:
        if (_t->variable_id == _oldVariableId) {
            _t->variable_id = _newVariableId;
        }
        break;
    case FUNC:
        assert(_t->parameters);
        for(i = 0; i < Vocabulary::instance().getFunctionArity(_t->function_id); ++ i) {
            renameTermVariables(_t->parameters+i, _oldVariableId, _newVariableId);
        }
        break;
    default:
        assert(0);
    }
}
/**
 * 输出公式
 * @param _out 文件标识
 * @param _fml 公式
 */
void Utils::outputFormula(FILE* _out, const _formula* _fml) {
    assert(_fml);
    
    char* s_conn = NULL;
    switch (_fml->formula_type) {
    case ATOM:
        if (_fml->predicate_id >= 0 && Vocabulary::instance().getPredicateArity(_fml->predicate_id) == 0) {
            fprintf(_out, "%s", Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE));
        }
        else{
            if (_fml->predicate_id >= 0) {
                fprintf(_out, "%s(", Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE));
                for(int i = 0; i < Vocabulary::instance().getPredicateArity(_fml->predicate_id); ++ i) {
                    if (i > 0) {
                        fprintf(_out, ",");
                    }
                    outputTerm(_out, _fml->parameters+i);
                }
            }
            else {
                switch (_fml->predicate_id) {
                case PRED_TRUE:
                    fprintf(_out, "(TRUE");
                    break;
                case PRED_FALSE:
                    fprintf(_out, "(FALSE");
                    break;
                case PRED_EQUALITY:
                    fprintf(_out, "(");
                    assert(_fml->parameters);
                    outputTerm(_out, _fml->parameters);
                    fprintf(_out, "=");
                    outputTerm(_out, _fml->parameters+1);
                    break;
                case PRED_MIN:
                    fprintf(_out, "MIN(");
                    assert(_fml->parameters);
                    outputTerm(_out, _fml->parameters);
                    break;
                case PRED_MAX:
                    fprintf(_out, "MAX(");
                    assert(_fml->parameters);
                    outputTerm(_out, _fml->parameters);
                    break;
                case PRED_SUCC:
                    fprintf(_out, "SUCC(");
                    assert(_fml->parameters);
                    outputTerm(_out, _fml->parameters);
                    fprintf(_out, ",");
                    outputTerm(_out, _fml->parameters+1);
                    break;
                default:
                    assert ( 0 );
                }
            }
            fprintf(_out, ")");
        }
        break;
    case NEGA:
        fprintf(_out, "~");
        assert(_fml->subformula_l);
        outputFormula(_out, _fml->subformula_l);
        break;
    case CONJ:
        s_conn = (char*)"&";
    case DISJ:
        if ( NULL==s_conn ) {
            s_conn = (char*)"|";
        }
    case IMPL:
        if ( NULL==s_conn ) {
            s_conn = (char*)"->";
        }
        fprintf(_out, "(");
        assert(_fml->subformula_l);
        outputFormula(_out, _fml->subformula_l);
    	fprintf(_out, "%s", s_conn);
        assert(_fml->subformula_r);
        outputFormula(_out, _fml->subformula_r);
        fprintf(_out, ")");
        break;
    case UNIV:
        s_conn = (char*)"!";
    case EXIS:
        if ( NULL==s_conn ) {
            s_conn = (char*)"?";
        }
        fprintf(_out, "[%s%s](", s_conn, Vocabulary::instance().getNameById(_fml->variable_id, VARIABLE));
        assert(_fml->subformula_l);
        outputFormula(_out, _fml->subformula_l);
        fprintf ( _out, ")" );
        break;
    default:
        assert ( 0 );
    }
}
/**
 * 比较两条公式是否相同
 * @param _lhs
 * @param _rhs
 * @return bool
 */
bool Utils::compareFormula(const _formula* _lhs, const _formula* _rhs) {
    assert(_lhs);
    assert(_rhs);

    if (_lhs->formula_type!=_rhs->formula_type) {
        return false;
    }
    int k;
    switch (_lhs->formula_type) {
    case ATOM:
        if (_lhs->predicate_id!=_rhs->predicate_id) {
            return false;
        }
        k = Vocabulary::instance().getPredicateArity(_lhs->predicate_id) - 1;
        assert(k < 0 || _lhs->parameters);
        assert(k < 0 || _rhs->parameters);
        for ( ; k >= 0; -- k) {
            if (! compareTerm(_lhs->parameters + k,_rhs->parameters + k)) {
                return FALSE;
            }
        }
        return true;
    case UNIV:
    case EXIS:
        if (_lhs->variable_id!=_rhs->variable_id) {
            return false;
        }
    case NEGA:
        assert(_lhs->subformula_l);
        assert(_rhs->subformula_l);
        return compareFormula(_lhs->subformula_l,_rhs->subformula_l);
    case CONJ:
    case DISJ:
    case IMPL:
        assert(_lhs->subformula_l);
        assert(_rhs->subformula_l);
        assert(_lhs->subformula_r);
        assert(_rhs->subformula_r);
        return (compareFormula(_lhs->subformula_l,_rhs->subformula_l)
            && compareFormula(_lhs->subformula_r,_rhs->subformula_r));
    default:
        assert(0);
    }
    return false;
}
/**
 * 拷贝公式
 * @param _fml
 * @return _formula* 公式的拷贝
 */
_formula* Utils::copyFormula(const _formula* _fml) {
    if (_fml == NULL) {
        return NULL;
    }
	
    _formula* newFormula = (_formula*)malloc(sizeof(_formula));
    assert (newFormula);

    memcpy(newFormula, _fml, sizeof(_formula));
    switch (_fml->formula_type)
    {
    case ATOM:
        newFormula->parameters = copyTerms(_fml->parameters, 
                Vocabulary::instance().getPredicateArity(_fml->predicate_id));
        break;
    case CONJ:
    case DISJ:
    case IMPL:
        assert(_fml->subformula_r);
        newFormula->subformula_r = copyFormula( _fml->subformula_r);
    case NEGA:
    case UNIV:
    case EXIS:
        assert(_fml->subformula_l);
        newFormula->subformula_l = copyFormula(_fml->subformula_l);
        break;
    default:
        assert (0);
    }

    return newFormula;
}
/**
 * 销毁公式
 * @param _fml
 */
void Utils::deleteFormula(_formula* _fml) {
    assert(_fml);

    switch (_fml->formula_type)
    {
    case ATOM:
        if(_fml->parameters) {
            deleteTerms(_fml->parameters, 
                    Vocabulary::instance().getPredicateArity(_fml->predicate_id));
        }
        break;
    case CONJ:
    case DISJ:
    case IMPL:
        assert(_fml->subformula_r);
        deleteFormula(_fml->subformula_r);
    case NEGA:
    case UNIV:
    case EXIS:
        assert(_fml->subformula_l);
        deleteFormula(_fml->subformula_l);
        break;
    default:
        assert ( 0 );
    }

    free(_fml);
}
/**
 * 判断公式是否含有存在量词
 * @param _fml
 * @return bool
 */
bool Utils::isUniversal(_formula* _fml) {
    if(_fml != NULL) {
        switch(_fml->formula_type) {
        case ATOM:
            return true;
        case CONJ:
        case DISJ:
        case IMPL:
            return isUniversal(_fml->subformula_l) && isUniversal(_fml->subformula_r);
        case NEGA:
        case UNIV:
            return isUniversal(_fml->subformula_l);
        case EXIS:
            return false;
        default:
            assert(0);
        }
    }

    return false;
}
/**
 * 把需要重命名的变量重命名
 * @param _fml 公式
 * @param _oldVariableId 需要重命名的变量id
 * @param _newVariableId 新变量id
 */
void Utils::renameFormulaVariables(_formula* _fml, int _oldVariableId, int _newVariableId) {
    assert(_fml);
	
    if(_oldVariableId == _newVariableId) {
        return;
    }

    switch (_fml->formula_type)
    {
    case ATOM:
        if (_fml->parameters == NULL) return;
        for (int i = 0; i < Vocabulary::instance().getPredicateArity(_fml->predicate_id); ++ i) {
            renameTermVariables(_fml->parameters + i, _oldVariableId, _newVariableId);
        }
        break;
    case UNIV:
    case EXIS:
        if (_fml->variable_id==_oldVariableId) {
            _fml->variable_id = _newVariableId;
        }
    case NEGA:
        assert(_fml->subformula_l);
        renameFormulaVariables(_fml->subformula_l, _oldVariableId, _newVariableId);
        break;
    default:
        assert(_fml->subformula_l);
        assert(_fml->subformula_r);
        renameFormulaVariables(_fml->subformula_l, _oldVariableId, _newVariableId);
        renameFormulaVariables(_fml->subformula_r, _oldVariableId, _newVariableId);
    }
}
/**
 * 获取公式中没有量词限定的变量
 * @param _flag 标记
 * @param _varis 存放结果
 * @param _fml 公式
 */
void Utils::getNoQuantifierVariables(map<int, bool>& _flag, vector<int>& _varis, _formula* _fml) {
    assert(_fml);
    switch (_fml->formula_type) {
    case UNIV:
    case EXIS:
        _flag[_fml->variable_id] = true;
        getNoQuantifierVariables(_flag, _varis, _fml->subformula_l);
        break;
    case IMPL:
    case CONJ:
    case DISJ:
        getNoQuantifierVariables(_flag, _varis, _fml->subformula_r);
    case NEGA:
        getNoQuantifierVariables(_flag, _varis, _fml->subformula_l);
        break;
    case ATOM:
        for(int i = 0; i < Vocabulary::instance().getPredicateArity(_fml->predicate_id); ++ i) {
            _term* term = _fml->parameters + i;
            getNoQuantifierVariablesInTerms(_flag, _varis, term);
        }
        break;
    default:
        assert(0);
    }
}
/**
 * 获取参数中，没有量词限定的变量
 * @param _flag 标记
 * @param _varis 存放结果
 * @param _t 参数
 */
void Utils::getNoQuantifierVariablesInTerms(map<int, bool>& _flag, vector<int>& _varis, _term* _t) {
    assert(_t);
    switch (_t->term_type) {
    case VARI:
        if (! _flag[_t->variable_id]) {
            _flag[_t->variable_id] = true;
            _varis.push_back(-(_t->variable_id));
        }
        break;
    case FUNC:
        for(int i = 0; i < Vocabulary::instance().getFunctionArity(_t->function_id); ++ i) {
            _term* term = _t->parameters + i;
            getNoQuantifierVariablesInTerms(_flag, _varis, term);
        }
        break;
    default:
        assert(0);
    }
}
/**
 * 判断_target是否在数组_p中
 * @param _target　查找值
 * @param _p　数组
 * @param size　数组大小
 * @return bool
 */
bool Utils::isInList(int _target, const vector<int>& _list) {
    unsigned int size = _list.size();
    for (unsigned int i = 0; i < size; ++ i) {
        if (_list[i] == _target) {
            return true;
        }
    }
    return false;
}
/**
 * 在指定的不带非的谓词前添加非非，_p == NULL或_size = 0时，则对内涵谓词操作
 * @param _fml
 * @param _p 谓词Id数组
 * @param _size 谓词Id数组的大小
 * @return _formula* 处理后的公式
 */
_formula* Utils::doubleNegationPredicates(_formula* _fml, const map<int, string>& _mapPredicates, FORMULA_TYPE _fatherType) {
    assert(_fml);

    switch (_fml->formula_type) {
    case ATOM:
        if (NEGA != _fatherType) {
            if (_mapPredicates.find(_fml->predicate_id) != _mapPredicates.end()) {
                _fml = compositeByConnective(NEGA, _fml);
                _fml = compositeByConnective(NEGA, _fml);
            }
        }
        break;
    case CONJ:
    case DISJ:
    case IMPL:
        _fml->subformula_r = doubleNegationPredicates(_fml->subformula_r, _mapPredicates, _fml->formula_type);
    case NEGA:
    case UNIV:
    case EXIS:
        _fml->subformula_l = doubleNegationPredicates(_fml->subformula_l, _mapPredicates, _fml->formula_type);
        break;
    default:
        assert(0);
    }

    return _fml;
}
/**
 * 把公式中的参数_originals替换成_replacements，一一对应
 * @param _fml
 * @param _originals
 * @param _replacements
 * @return 
 */
void Utils::replaceFormulaTerms(_formula* _fml, 
                                const vector<int>& _originals, 
				const vector<int>& _replacements) {
    assert(_fml);
    assert(_originals.size() == _replacements.size());

    switch(_fml->formula_type) {
    case ATOM:
        replaceTerm(_fml->parameters, 
                Vocabulary::instance().getPredicateArity(_fml->predicate_id), 
                _originals, _replacements);
        break;
    case DISJ:
    case CONJ:
    case IMPL:
        replaceFormulaTerms(_fml->subformula_r, _originals, _replacements);
    case NEGA:
    case UNIV:
    case EXIS:
        replaceFormulaTerms(_fml->subformula_l, _originals, _replacements);
        break;
    default:
        assert(0);
    }
}
/**
 * 拆分公式，把用&连接的公式拆分成多条公式
 * @param _fml
 * @param _parent
 * @param _result
 */
void Utils::divideFormula(_formula* _fml, Formulas* _result) {
    assert(_fml);
    if(_fml->formula_type == CONJ) {
        divideFormula(_fml->subformula_l, _result);   
        divideFormula(_fml->subformula_r, _result);
    }
    else {
        Formula new_formula = Formula(_fml, true);
        _result->pushBack(new_formula);
    }
}
/**
 * 使用联接词(非、析取、合取、蕴含)生成公式
 * @param _formulaType 联接词
 * @param _subformulaL 左公式
 * @param _subformulaR 右公式
 * @return 新公式
 */
_formula* Utils::compositeByConnective(FORMULA_TYPE _formulaType, 
                    _formula* _subformulaL, _formula* _subformulaR) {
    assert(_formulaType == NEGA || _formulaType == DISJ ||
		   _formulaType == CONJ || _formulaType == IMPL);

    _formula* fml = (_formula*)malloc(sizeof(_formula));
    assert(fml);

    fml->formula_type = _formulaType;
    fml->subformula_l = _subformulaL;
    fml->subformula_r = _subformulaR;
    return fml;
}
/**
 * 在公式前添加量词
 * @param _formulaType 量词类型
 * @param _subformulaL 公式
 * @param _variableId  量词对应的变量Id
 * @return 新公式
 */
_formula* Utils::compositeByQuantifier(FORMULA_TYPE _formulaType, 
                         _formula* _subformulaL, int _variableId) {
    assert(_formulaType == EXIS || _formulaType == UNIV);
    
    _formula* fml = (_formula*)malloc(sizeof(_formula));
    assert(fml);

    fml->formula_type = _formulaType;
    fml->subformula_l = _subformulaL;
    fml->variable_id = _variableId;
    return fml;
}
/**
 * 生成atom
 * @param _formulaType
 * @param _predicateId
 * @param _parameters
 * @return 
 */
_formula* Utils::compositeToAtom(int _predicateId, _term* _parameters) {
    _formula* fml = (_formula*)malloc(sizeof(_formula));
    assert(fml);

    fml->formula_type = ATOM;
    fml->predicate_id = _predicateId;
    fml->parameters   = _parameters;
    return fml;
}
/**
 * 输出原子
 * @param _atom
 * @param _out
 */
void Utils::printAtom(const _formula* _atom, FILE* _out) {
    assert(_atom->formula_type == ATOM);
    fprintf(_out, "%s", Vocabulary::instance().getNameById(_atom->predicate_id, PREDICATE));
    if (_atom->parameters != NULL) {
        _term* ft = _atom->parameters;
        int ftc = Vocabulary::instance().getPredicateArity(_atom->predicate_id);
        for (int i = 0; i < ftc; ++ i) {
            if (0 == i) {
                fprintf(_out, "(%s", 
                        Vocabulary::instance().getNameById(ft[i].variable_id, VARIABLE));
            }
            else {
                fprintf(_out, ",%s", 
                        Vocabulary::instance().getNameById(ft[i].variable_id, VARIABLE));  
            }
            
            if (i == ftc - 1) {
                fprintf(_out, ")");
            }
        }        
    }    
}
/**
 * 把原子转化成字符串
 * @param atom
 * @return 
 */
string Utils::convertAtomToString(const _formula* _atom) {
    assert(_atom->formula_type == ATOM);
    string sRet = "";
    sRet += Vocabulary::instance().getNameById(_atom->predicate_id, PREDICATE);
    if (_atom->parameters != NULL) {
        _term* ft = _atom->parameters;
        int ftc = Vocabulary::instance().getPredicateArity(_atom->predicate_id);
        for (int i = 0; i < ftc; ++ i) {
            if (0 == i) {
                sRet += "(";
            }
            else {
                sRet += ",";
            }
            sRet += Vocabulary::instance().getNameById(ft[i].variable_id, VARIABLE);
            
            if (i == ftc - 1) {
                sRet += ")";
            }
        }        
    }    
    return sRet;
}
/**
 * 把公式转化成字符串
 * @param _fml
 * @return 
 */
string Utils::convertFormulaToString(const _formula* _fml) {
    assert(_fml);
    string sRet;
    generateFormulaString(_fml, sRet);
    return sRet;
}
/**
 * 递归用
 * @param _fml
 * @param _sRet
 */
void Utils::generateFormulaString(const _formula* _fml, string& _sRet) {
    assert(_fml);
    
    char* s_conn = NULL;
    switch (_fml->formula_type) {
    case ATOM:
        if (_fml->predicate_id >= 0 && Vocabulary::instance().getPredicateArity(_fml->predicate_id) == 0) {
            _sRet += Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE);
        }
        else{
            if (_fml->predicate_id >= 0) {
                _sRet += Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE) + string("(");
                for(int i = 0; i < Vocabulary::instance().getPredicateArity(_fml->predicate_id); ++ i) {
                    if (i > 0) {
                        _sRet += ",";
                    }
                    generateTermString(_fml->parameters + i, _sRet);
                }
            }
            else {
                switch (_fml->predicate_id) {
                case PRED_TRUE:
                    _sRet += "(TRUE";
                    break;
                case PRED_FALSE:
                    _sRet += "(FALSE";
                    break;
                default:
                    assert ( 0 );
                }
            }
            _sRet += ")";
        }
        break;
    case NEGA:
        _sRet += "~";
        assert(_fml->subformula_l);
        generateFormulaString(_fml->subformula_l, _sRet);
        break;
    case CONJ:
        s_conn = (char*)"&";
    case DISJ:
        if ( NULL==s_conn ) {
            s_conn = (char*)"|";
        }
    case IMPL:
        if ( NULL==s_conn ) {
            s_conn = (char*)"->";
        }
        _sRet += "(";
        assert(_fml->subformula_l);
        generateFormulaString(_fml->subformula_l, _sRet);
        _sRet += s_conn;
        assert(_fml->subformula_r);
        generateFormulaString(_fml->subformula_r, _sRet);
        _sRet += ")";
        break;
    case UNIV:
        s_conn = (char*)"!";
    case EXIS:
        if ( NULL==s_conn ) {
            s_conn = (char*)"?";
        }
        _sRet += "[" + string(s_conn) + string(Vocabulary::instance().getNameById(_fml->variable_id, VARIABLE)) + string("](");
        assert(_fml->subformula_l);
        generateFormulaString(_fml->subformula_l, _sRet);
        _sRet += ")";
        break;
    default:
        assert ( 0 );
    }
}
/**
 * 递归用
 * @param _t
 * @param _sRet
 */
void Utils::generateTermString(const _term* _t, string& _sRet) {
    assert (_t);

    if (VARI ==_t->term_type) {
        _sRet += Vocabulary::instance().getNameById(_t->variable_id, VARIABLE);
    }
    else {
        _sRet += Vocabulary::instance().getNameById(_t->function_id, FUNCTION);
        int k = Vocabulary::instance().getFunctionArity(_t->function_id);
        if (k > 0) {
            _sRet += "(";
            for (int i = 0; i < k; ++ i) {
                if (0 < i) {
                    _sRet += ", ";
                }
                generateTermString(_t->parameters + i, _sRet);
            }
            _sRet += ")";
        }
    }
}
/**
 * 把公式组转化成字符串
 * @param _fmls Formulas*
 * @return vector<string>
 */
vector<string> Utils::convertFormulasToStrings(Formulas* _fmls) {
    vector<string> vRet;
    for (FORMULAS_CONST_ITERATOR it = _fmls->begin(); 
            it != _fmls->end(); ++ it) {
        vRet.push_back(convertFormulaToString(it->getFormula()));
    }
    return vRet;
}
/**
 * 
 * @param _fml
 * @param _fatherType
 * @return 
 */
_formula* Utils::_thetaReplace(const int& _rId, _formula* _fml, _formula* _fatherFml) {
    assert(_fml);
    switch (_fml->formula_type) {
        case ATOM:
            if (NULL != _fatherFml && NEGA == _fatherFml->formula_type) {
                if (Vocabulary::instance().isIntensionPredicate(_fml->predicate_id)) {
                    // p->r 替换 ~p
                    _fatherFml->formula_type = IMPL;
                    _fatherFml->subformula_r = Utils::compositeToAtom(_rId, NULL);
                }
                else if (Vocabulary::instance().isVaryPredicate(_fml->predicate_id)) {
                    // Q_vary->r 替换 ~Q
                    const char* qName = Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE);
                    char qVaryName[64];
                    sprintf(qVaryName, "%s%s", qName, VARY_PREDICATE_POSTFIX);
                    // ->
                    _fatherFml->formula_type = IMPL;
                    // Q_vary
                    int qVaryId = Vocabulary::instance().getSymbolId(qVaryName, PREDICATE);
                    _fatherFml->subformula_l->predicate_id = qVaryId;
                    // r
                    _fatherFml->subformula_r = Utils::compositeToAtom(_rId, NULL); 
                }
            }
            else { // Q_vary  替换 Q，Q_vary属于内涵谓词
                if (Vocabulary::instance().isVaryPredicate(_fml->predicate_id)) {
                    const char* qName = Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE);
                    char qVaryName[64];
                    sprintf(qVaryName, "%s%s", qName, VARY_PREDICATE_POSTFIX);
                    int qVaryId = Vocabulary::instance().getSymbolId(qVaryName, PREDICATE);
                    _fml->predicate_id = qVaryId;
                }
            }
            break;
        case IMPL:
        case CONJ:
        case DISJ:
            _fml->subformula_r= _thetaReplace(_rId, _fml->subformula_r, _fml);
        case UNIV:
        case EXIS:
        case NEGA:
            _fml->subformula_l = _thetaReplace(_rId, _fml->subformula_l, _fml);
            break;
        default:
            assert(0);
    }
    return _fml;
}
_formula* Utils::_thetaReplace(const vector<int>& _preMiniPredicates, 
                const vector<int>& _curMiniPredicates, const vector<int>& _otherPredicates,
                const int& _rId, const int& _index, _formula* _fml, _formula* _fatherFml) {
    assert(_fml);
    switch (_fml->formula_type) {
        case ATOM:
            if (NULL != _fatherFml && NEGA == _fatherFml->formula_type) {
                if (isInList(_fml->predicate_id, _curMiniPredicates)) {
                    // p->r 替换 ~p
                    _fatherFml->formula_type = IMPL;
                    _fatherFml->subformula_r = compositeToAtom(_rId, NULL);
                }
                else if (isInList(_fml->predicate_id, _otherPredicates)) {
                    // Q_j_vary->r 替换 ~Q
                    const char* qName = Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE);
                    char qVaryName[64];
                    sprintf(qVaryName, "%s_%d%s", qName, _index, VARY_PREDICATE_POSTFIX);
                    // ->
                    _fatherFml->formula_type = IMPL;
                    // Q_j_vary
                    int qVaryId = Vocabulary::instance().getSymbolId(qVaryName, PREDICATE);
                    assert(qVaryId != -1);
                    _fatherFml->subformula_l->predicate_id = qVaryId;
                    // r
                    _fatherFml->subformula_r = compositeToAtom(_rId, NULL); 
                }
            }
            else { // Q_j_vary  替换 Q，Q_j_vary属于内涵谓词
                if (isInList(_fml->predicate_id, _otherPredicates)) {
                    const char* qName = Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE);
                    char qVaryName[64];
                    sprintf(qVaryName, "%s_%d%s", qName, _index,  VARY_PREDICATE_POSTFIX);
                    int qVaryId = Vocabulary::instance().getSymbolId(qVaryName, PREDICATE);
                    assert(qVaryId != -1);
                    _fml->predicate_id = qVaryId;
                }
                // ~~p 替换 p
                else if (isInList(_fml->predicate_id, _preMiniPredicates)) {
                    _fml = compositeByConnective(NEGA, _fml);
                    _fml = compositeByConnective(NEGA, _fml);
                }
            }
            break;
        case IMPL:
        case CONJ:
        case DISJ:
            _fml->subformula_r = _thetaReplace(_preMiniPredicates, _curMiniPredicates, _otherPredicates, 
                    _rId, _index, _fml->subformula_r, _fml);
        case UNIV:
        case EXIS:
        case NEGA:
            _fml->subformula_l = _thetaReplace(_preMiniPredicates, _curMiniPredicates, _otherPredicates, 
                    _rId, _index, _fml->subformula_l, _fml);
            break;
        default:
            assert(0);
    }
    return _fml;
}
_formula* Utils::thetaT__Replace(_formula* _fml, _formula* _fatherFml) {
    assert(_fml);
    _formula* tmp;
    switch (_fml->formula_type) {
        case ATOM:
            if (NULL != _fatherFml && NEGA == _fatherFml->formula_type) {
                // true 替换 负文字
                if (Vocabulary::instance().isIntensionPredicate(_fml->predicate_id) ||
                        Vocabulary::instance().isVaryPredicate(_fml->predicate_id)) {
                    _fatherFml->formula_type = ATOM;
                    _fatherFml->predicate_id = PRED_TRUE;
                    _fatherFml->parameters = NULL;
                    deleteFormula(_fml);
                    _fml = NULL;
                }
            }
            else {
                if (Vocabulary::instance().isIntensionPredicate(_fml->predicate_id)) {
                    // ~~p 替换 p
                    _fml = compositeByConnective(NEGA, _fml);
                    _fml = compositeByConnective(NEGA, _fml);
                }
                else if (Vocabulary::instance().isVaryPredicate(_fml->predicate_id)) {
                    // true 替换 q
                    tmp = _fml;
                    _fml = Utils::compositeToAtom(PRED_TRUE, NULL);
                    deleteFormula(tmp);
                }
            }
            break;
        case CONJ:
        case DISJ:
        case IMPL:
            tmp = thetaT__Replace(_fml->subformula_r, _fml);
            _fml->subformula_r = (NULL == tmp) ? _fml->subformula_r : tmp;
        case UNIV:
        case EXIS:
        case NEGA:
            tmp = thetaT__Replace(_fml->subformula_l, _fml);
            _fml->subformula_l = (NULL == tmp) ? _fml->subformula_l : tmp;
            break;
        default:
            assert(0);
    }
    return _fml;
}

_formula* Utils::thetaT__Replace(const vector<int>& _vPredicateP, const vector<int>& _vPredicateQ, 
                                _formula* _fml, _formula* _fatherFml) {
    assert(_fml);
    _formula* tmp;
    switch (_fml->formula_type) {
        case ATOM:
            if (NULL != _fatherFml && NEGA == _fatherFml->formula_type) {
                // true 替换 负文字  ~P and ~Q
                if (isInList(_fml->predicate_id, _vPredicateP) ||
                        isInList(_fml->predicate_id, _vPredicateQ)) {
                    _fatherFml->formula_type = ATOM;
                    _fatherFml->predicate_id = PRED_TRUE;
                    _fatherFml->parameters = NULL;
                    deleteFormula(_fml);
                    _fml = NULL;
                }
            }
            else {
                if (isInList(_fml->predicate_id, _vPredicateP)) {
                    // ~~p 替换 p
                    _fml = compositeByConnective(NEGA, _fml);
                    _fml = compositeByConnective(NEGA, _fml);
                }
                else if (isInList(_fml->predicate_id, _vPredicateQ)) {
                    // true 替换 q
                    tmp = _fml;
                    _fml = Utils::compositeToAtom(PRED_TRUE, NULL);
                    deleteFormula(tmp);
                }
            }
            break;
        case CONJ:
        case DISJ:
        case IMPL:
            tmp = thetaT__Replace(_fml->subformula_r, _fml);
            _fml->subformula_r = (NULL == tmp) ? _fml->subformula_r : tmp;
        case UNIV:
        case EXIS:
        case NEGA:
            tmp = thetaT__Replace(_fml->subformula_l, _fml);
            _fml->subformula_l = (NULL == tmp) ? _fml->subformula_l : tmp;
            break;
        default:
            assert(0);
    }
    return _fml;
}

_formula* Utils::removeImpl(_formula* _fml) {
    assert(_fml);
    switch (_fml->formula_type) {
        case ATOM:
            break;
        case IMPL:
            _fml->formula_type = DISJ;
            _fml->subformula_l = compositeByConnective(NEGA, _fml->subformula_l);
        case CONJ:
        case DISJ:
            _fml->subformula_r = removeImpl(_fml->subformula_r);
        case UNIV:
        case EXIS:
        case NEGA:
            _fml->subformula_l = removeImpl(_fml->subformula_l);
            break;
        default:
            assert(0);
    }
    return _fml;
}

string Utils::convertNumToString(int _num) {
    char num[10];
    sprintf(num, "%d", _num);
    return string(num);
}

_formula* Utils::convertDNFtoCNF(_formula* _fml) {
    assert(_fml);
    assert(_fml->formula_type == CONJ || _fml->formula_type == DISJ
            || _fml->formula_type == ATOM);
    switch (_fml->formula_type) {
        case DISJ:
            if (_fml->subformula_r->formula_type == CONJ) {
                _formula* l = _fml->subformula_l;
                _formula* rl = _fml->subformula_r->subformula_l;
                _formula* rr = _fml->subformula_r->subformula_r;
                free(_fml->subformula_r);
                _fml->subformula_l = compositeByConnective(DISJ, l, rl);
                _fml->subformula_r = compositeByConnective(DISJ, copyFormula(l), rr);
                _fml->formula_type = CONJ;
            }
            if (_fml->subformula_l->formula_type == CONJ) {
                _formula* ll = _fml->subformula_l->subformula_l;
                _formula* lr = _fml->subformula_l->subformula_r;
                _formula* r = _fml->subformula_r;
                free(_fml->subformula_l);
                _fml->subformula_l = compositeByConnective(DISJ, ll, r);
                _fml->subformula_r = compositeByConnective(DISJ, lr, copyFormula(r));
                _fml->formula_type = CONJ;
            }
            _fml->subformula_l = convertDNFtoCNF(_fml->subformula_l);
            _fml->subformula_r = convertDNFtoCNF(_fml->subformula_r);
            break;
        case CONJ:
            _fml->subformula_l = convertDNFtoCNF(_fml->subformula_l);
            _fml->subformula_r = convertDNFtoCNF(_fml->subformula_r);
            break;
        case ATOM:
            break;
        default:
            assert(0);
    }
    if (_fml->formula_type == DISJ && 
            (_fml->subformula_l->formula_type == CONJ || _fml->subformula_r->formula_type == CONJ)) {
        _fml = convertDNFtoCNF(_fml);
    }
    return _fml;
}
/**
 * stable语义的转换
 * @param _fml
 * @return 
 */
_formula* Utils::convertToSt(_formula* _fml) {
    assert(_fml);
    switch (_fml->formula_type) {
        case ATOM:
            //　内涵谓词
            if (Vocabulary::instance().isIntensionPredicate(_fml->predicate_id)) {
                const char* preName = Vocabulary::instance().getNameById(_fml->predicate_id, PREDICATE);
                char name[64];
                sprintf(name, "%s_st", preName);
                int id = Vocabulary::instance().addSymbol(name, PREDICATE, 
                                Vocabulary::instance().getPredicateArity(_fml->predicate_id));
                _fml->predicate_id = id;
            }
            //　非内涵谓词，不用处理
            break;
        case CONJ:
        case DISJ:
            _fml->subformula_l = convertToSt(_fml->subformula_l);
            _fml->subformula_r = convertToSt(_fml->subformula_r);
            break;
        case IMPL:
        {
            _formula* cur_l = copyFormula(_fml->subformula_l);
            _formula* cur_r = copyFormula(_fml->subformula_r);
            _formula* cur = copyFormula(_fml);
            _fml->formula_type = CONJ;
            _fml->subformula_l = cur;
            _fml->subformula_r->formula_type = IMPL;
            _fml->subformula_r->subformula_l = convertToSt(cur_l);
            _fml->subformula_r->subformula_r = convertToSt(cur_r);
        }
            break;
        case NEGA:
        {
            _formula* cur = copyFormula(_fml);
            _formula* cur_l = copyFormula(_fml->subformula_l);
            _fml->formula_type = CONJ;
            _fml->subformula_l = compositeByConnective(NEGA, convertToSt(cur_l));
            _fml->subformula_r = cur;
        }   
            break;
        case EXIS:
        case UNIV:
            _fml->subformula_l = convertToSt(_fml->subformula_l);
            break;
        default:
            assert(0);
    }
    return _fml;
}