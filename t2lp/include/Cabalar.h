#ifndef CABALAR_H
#define	CABALAR_H

#include "Formula.h"
#include "Formulas.h"

class Formulas;

class Cabalar {
private:
    Cabalar();
    ~Cabalar();
    Cabalar(const Cabalar&);
    Cabalar& operator = (const Cabalar&);
    
    Formulas* convertToNegativeNormalForms(const Formulas& _originalFmls); 
public:
    Formulas* convert(const Formulas& _originalFmls);
    static Cabalar& instance();
};


#endif	/* CABALAR_H */

