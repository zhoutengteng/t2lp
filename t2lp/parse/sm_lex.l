%{
#include "parse.h"

extern "C" {
    int yywrap(void);
    int yylex(void);
}
extern int context_flag;/* 0 - not in any atom, 1 - in an atom*/

%}


%x COMMENT

blank	  			[ \n\t\r]*
variable			[A-Z][a-zA-Z0-9_]*
predicate_function              [a-z][a-zA-Z0-9_]*
integer                         [1-9][0-9]*

%%
{variable}	   		{
                                    yylval.s=strdup(yytext);
                                    printf("Vari: %s\n",yytext);
                                    return S_VARI;
                                }

{predicate_function}	   	{
                                    yylval.s=strdup(yytext);
                                    if (1 == context_flag) { 
                                        printf("Func: %s\n",yytext);
                                        return S_FUNC;
                                    } 
                                    else {
                                        printf("Pred: %s\n",yytext);
                                        context_flag = 1;
                                        return S_PRED;
                                    }
                                }
{integer}                       {
                                    yylval.num=atoi(yytext);
                                    return INTEGER;
                                }
"~"				{return S_NEGA;			}
"&"				{return S_CONJ;			}
"|"				{return S_DISJ;			}
"->"                            {return S_IMPL;			}
"!"				{return S_UNIV;			}
"?"				{return S_EXIS;			}
"."				{return PERIOD;			}
"("				{return LPAREN;			}
")"				{return RPAREN;			}
"["				{return LBRACKET;		}
"]"				{return RBRACKET;		}
","				{return COMMA;			}
"="				{return EQUAL;			}
"#"				{return MARCO;			}
"{"                             {return LBRACE;                 }
"}"                             {return RBRACE;                 }
"<"                             {return LL;                     }
">"                             {return RR;                     }
";"                             {return SEMICO;                 }
"@"                             {return AT;                     }
{blank}                         {/* skip blankspace */	}

"%"                             {BEGIN COMMENT;                 }
<COMMENT>\n                     {BEGIN INITIAL;                 }
<COMMENT>.                      {}

%%

int yywrap() {
    return 1;
}


