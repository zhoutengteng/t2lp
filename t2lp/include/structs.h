#ifndef STRUCTS_H
#define	STRUCTS_H

//Pre-definition
////////////////////////////////////////////////////////////////////////////////
#define MAX_NUM_PREDICATE       100
#define MAX_NUM_DOMAIN          10
#define MAX_NUM_FUNCTION        100
#define MAX_NUM_VARIABLE	100
#define MAX_LEN_PARAMETER	10
#define MAX_NUM_ATOM		200
#define MAX_LEN_CLAUSE		(MAX_NUM_ATOM*2)

#define PRED_TRUE	-1
#define PRED_FALSE	-2
#define PRED_EQUALITY	-3
#define PRED_MIN	-4
#define PRED_MAX	-5
#define PRED_SUCC	-6

const int spec_pred_arities[] =
{
    0,			//PRED_TRUE
    0,			//PRED_FALSE
    2,			//PRED_EQUALITY
    1,			//PRED_MIN
    1,			//PRED_MAX
    2,			//PRED_SUCC
};

// Type definition
////////////////////////////////////////////////////////////////////////////////
enum BOOL {
    FALSE = 0,
    TRUE = 1,
};

enum TERM_TYPE {
    VARI = 0,
    FUNC,
};

enum SYMBOL_TYPE {
    VARIABLE = 0,
    FUNCTION,
    PREDICATE,
    DOMAIN,
};

enum FORMULA_TYPE {
    ATOM = 0,	//atom
    NEGA,		//negation
    CONJ,		//conjunction
    DISJ,		//disjunction
    IMPL,		//implication
    UNIV,		//universal
    EXIS,		//existential
};

// Structures
typedef struct __term {
    TERM_TYPE term_type;

    union {
        int variable_id;			//VARI
        int function_id;			//FUNC
    };

    __term* parameters;		//FUNC
}_term;

typedef struct __terms {			// only be used in lex&yacc
    _term terms[MAX_LEN_PARAMETER];
    int num_term;
}_terms;

typedef struct __formula {
    FORMULA_TYPE formula_type;

    union {
        __formula* subformula_l;   //NEGA,CONJ,DISJ,IMPL,UNIV,EXIS
        int predicate_id;                 //ATOM
    };

    union {
        __formula* subformula_r;   //CONJ,DISJ,IMPL
        int variable_id;                  //UNIV,EXIS
        struct __term* parameters;        //ATOM
    };
}_formula;

#endif



