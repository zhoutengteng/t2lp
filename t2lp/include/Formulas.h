#ifndef FORMULAS_H
#define	FORMULAS_H

#include "Formula.h"
#include <deque>

using namespace std;

class Formula;

#define FORMULAS_ITERATOR deque<Formula>::iterator
#define FORMULAS_CONST_ITERATOR deque<Formula>::const_iterator
#define FORMULAS_CONST_REV_ITERATOR deque<Formula>::const_reverse_iterator
/*
 * 公式组类
 */
class Formulas {
private:
    deque<Formula> m_dequeFormulas;
    
public:
    Formulas();
    Formulas(const deque<Formula>& _formulas);
    Formulas(const Formulas& _rhs);
    ~Formulas();
    unsigned int size() const;
    bool isEmpty() const;
    void pushBack(const Formula& _tail);
    void pushBackUnique(const Formula& _tail);
    void pushFront(const Formula& _front);
    void pushFrontUnique(const Formula& _front);
    Formula popBack();
    Formula popFront();
    Formula front();
    Formula back();
    void joinBack(const Formulas& _tail);
    void joinBackUnique(const Formulas& _tail);
    void joinFront(const Formulas& _head);
    void joinFrontUnique(const Formulas& _head);
    Formulas& operator = (const Formulas& _rhs);
    bool operator == (const Formulas& _rhs) const;
    bool operator != (const Formulas& _rhs) const;
    Formula& operator [] (int _id);
    void output(FILE* _out) const;
    
    FORMULAS_ITERATOR begin();
    FORMULAS_ITERATOR end();
    FORMULAS_CONST_ITERATOR begin() const;
    FORMULAS_CONST_ITERATOR end() const;
    FORMULAS_CONST_REV_ITERATOR rbegin() const;
    FORMULAS_CONST_REV_ITERATOR rend() const;
    FORMULAS_ITERATOR erase(FORMULAS_ITERATOR _it);
    void convertToNNF(bool _bIsSM = true);
    void convertToPNF();
    void removeImpl();
    void convertToSt();
};



#endif	/* FORMULAS_H */

