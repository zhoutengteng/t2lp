%MIN and MAX domain
#domain min_conj(MIN_conj).
#domain max_conj(MAX_conj).
#domain min_disj(MIN_disj).
#domain max_disj(MAX_disj).
#domain min_atom(MIN_atom).
#domain max_atom(MAX_atom).

%Variable domain
#domain atom(Y).
#domain conj(X).
#domain disj(X2).
#domain conj(NV_0).
#domain atom(NV_1).
#domain atom(NV_2).
#domain atom(NV_3).
#domain atom(NV_4).

%Nega nega predicate define
_true(Y):- not true(Y).
_false(Y):- not false(Y).
_s_0(X):- not s_0(X).
_okc:- not okc.
_t_1(X,NV_0,Y):- not t_1(X,NV_0,Y).
_t_0(X):- not t_0(X).
_t_2(X,NV_0,Y):- not t_2(X,NV_0,Y).
_t_3(X,NV_0,Y):- not t_3(X,NV_0,Y).
_okd:- not okd.
_t_4(X2,Y):- not t_4(X2,Y).

%Extension predicate define
_posc(X,Y):- not posc(X,Y).
_negc(X,Y):- not negc(X,Y).
_posd(X2,Y):- not posd(X2,Y).
_negd(X2,Y):- not negd(X2,Y).
_un(Y):- not un(Y).
_succ_conj(X,NV_0):- not succ_conj(X,NV_0).
_max_conj(X):- not max_conj(X).
_succ_atom(Y,NV_1):- not succ_atom(Y,NV_1).
_max_atom(Y):- not max_atom(Y).

%Succ predicate definition
succ_conj(A1,A2):- A1==A2-1, conj(A1), conj(A2).
succ_atom(A1,A2):- A1==A2-1, atom(A1), atom(A2).
eq(X,Y) :- X = Y.

true(Y) | false(Y).
:- not s_0(MIN_conj).
:- not s_1(X,NV_0,MIN_atom).
s_1(X,NV_0,Y):- succ_atom(Y,NV_1), s_1(X,NV_0,NV_1).
s_1(X,NV_0,Y):- not succ_conj(X,NV_0), not okc, not _true(Y), posc(X,Y).
s_1(X,NV_0,Y):- not succ_conj(X,NV_0), not okc, not _false(Y), negc(X,Y).
s_1(X,NV_0,Y):- not s_0(NV_0), not okc, not _true(Y), posc(X,Y).
s_1(X,NV_0,Y):- not s_0(NV_0), not okc, not _false(Y), negc(X,Y).
s_1(X,NV_0,Y):- not _s_0(X).
s_1(X,NV_0,Y):- not okc, posc(X,Y), not _true(Y), not succ_conj(X,NV_0), not _s_0(X).
s_1(X,NV_0,Y):- not okc, negc(X,Y), not _false(Y), not succ_conj(X,NV_0), not _s_0(X).
s_1(X,NV_0,Y):- not okc, posc(X,Y), not _true(Y), not succ_conj(X,NV_0), not _s_0(X).
s_1(X,NV_0,Y):- not okc, negc(X,Y), not _false(Y), not succ_conj(X,NV_0), not _s_0(X).
s_1(X,NV_0,Y):- not okc, posc(X,Y), not s_0(NV_0), not _true(Y), not _s_0(X).
s_1(X,NV_0,Y):- not okc, negc(X,Y), not s_0(NV_0), not _false(Y), not _s_0(X).
s_1(X,NV_0,Y):- not okc, not s_0(NV_0), posc(X,Y), not _true(Y), not _s_0(X).
s_1(X,NV_0,Y):- not okc, not s_0(NV_0), negc(X,Y), not _false(Y), not _s_0(X).
s_0(X) | t_1(X,NV_0,MIN_atom):- succ_conj(X,NV_0), s_0(NV_0).
s_0(X) | t_1(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not posc(X,MIN_atom).
s_0(X) | t_1(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(X,MIN_atom).
s_0(X) | t_1(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not true(MIN_atom).
s_0(X) | t_1(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom).
s_0(X) | t_1(X,NV_0,MIN_atom):- not _okc.
s_0(X) | t_1(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not posc(X,MIN_atom), not _okc.
s_0(X) | t_1(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(X,MIN_atom), not _okc.
s_0(X) | t_1(X,NV_0,MIN_atom):- not true(MIN_atom), not negc(X,MIN_atom), not _okc.
s_0(X) | t_1(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not _okc.
t_1(X,NV_0,MIN_atom):- not s_0(X), succ_conj(X,NV_0), not _s_0(NV_0).
t_1(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not posc(X,MIN_atom), not s_0(X).
t_1(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(X,MIN_atom), not s_0(X).
t_1(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not true(MIN_atom), not s_0(X).
t_1(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not s_0(X).
t_1(X,NV_0,MIN_atom):- not s_0(X), not _okc.
s_0(X):- succ_conj(X,NV_0), s_0(NV_0), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y).
s_0(X):- not negc(X,Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not posc(X,Y).
s_0(X):- not false(Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not posc(X,Y).
s_0(X):- not negc(X,Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not true(Y).
s_0(X):- not false(Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not true(Y).
s_0(X):- t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _okc.
s_0(X):- t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not negc(X,Y), not posc(X,Y), not _okc.
s_0(X):- not false(Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not posc(X,Y), not _okc.
s_0(X):- not true(Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not negc(X,Y), not _okc.
s_0(X):- not false(Y), not true(Y), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _okc.
:- not s_0(X), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), succ_conj(X,NV_0), not _s_0(NV_0).
:- not negc(X,Y), not posc(X,Y), not s_0(X), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y).
:- not false(Y), not posc(X,Y), not s_0(X), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y).
:- not negc(X,Y), not true(Y), not s_0(X), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y).
:- not false(Y), not true(Y), not s_0(X), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y).
:- not s_0(X), t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _okc.
:- not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(X), not _s_0(NV_0), succ_conj(X,NV_0), not _t_1(X,NV_0,MAX_atom).
:- not negc(X,Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(X), not posc(X,Y), not _t_1(X,NV_0,MAX_atom).
:- not false(Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(X), not posc(X,Y), not _t_1(X,NV_0,MAX_atom).
:- not negc(X,Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(X), not true(Y), not _t_1(X,NV_0,MAX_atom).
:- not false(Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(X), not true(Y), not _t_1(X,NV_0,MAX_atom).
:- not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(X), not _okc, not _t_1(X,NV_0,MAX_atom).
s_0(X):- succ_conj(X,NV_0), s_0(NV_0), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y).
s_0(X):- not negc(X,Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not posc(X,Y).
s_0(X):- not false(Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not posc(X,Y).
s_0(X):- not negc(X,Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not true(Y).
s_0(X):- not false(Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not true(Y).
s_0(X):- t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not _okc.
s_0(X):- t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not negc(X,Y), not posc(X,Y), not _okc.
s_0(X):- not false(Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not posc(X,Y), not _okc.
s_0(X):- not true(Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not negc(X,Y), not _okc.
s_0(X):- not false(Y), not true(Y), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not _okc.
:- not s_0(X), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), succ_conj(X,NV_0), not _s_0(NV_0).
:- not negc(X,Y), not posc(X,Y), not s_0(X), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y).
:- not false(Y), not posc(X,Y), not s_0(X), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y).
:- not negc(X,Y), not true(Y), not s_0(X), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y).
:- not false(Y), not true(Y), not s_0(X), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y).
:- not s_0(X), t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not _okc.
:- max_atom(Y), s_1(X,NV_0,Y), not s_0(X), not _s_0(NV_0), succ_conj(X,NV_0), not _t_1(X,NV_0,MAX_atom).
:- not negc(X,Y), max_atom(Y), s_1(X,NV_0,Y), not s_0(X), not posc(X,Y), not _t_1(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_1(X,NV_0,Y), not s_0(X), not posc(X,Y), not _t_1(X,NV_0,MAX_atom).
:- not negc(X,Y), max_atom(Y), s_1(X,NV_0,Y), not s_0(X), not true(Y), not _t_1(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_1(X,NV_0,Y), not s_0(X), not true(Y), not _t_1(X,NV_0,MAX_atom).
:- max_atom(Y), s_1(X,NV_0,Y), not s_0(X), not _okc, not _t_1(X,NV_0,MAX_atom).
t_1(X,NV_0,MAX_atom):- not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not succ_conj(X,NV_0), not okc, not _true(Y), posc(X,Y).
t_1(X,NV_0,MAX_atom):- not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not succ_conj(X,NV_0), not okc, not _false(Y), negc(X,Y).
t_1(X,NV_0,MAX_atom):- not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(NV_0), not okc, not _true(Y), posc(X,Y).
t_1(X,NV_0,MAX_atom):- not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not s_0(NV_0), not okc, not _false(Y), negc(X,Y).
t_1(X,NV_0,MAX_atom):- s_0(X), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y).
t_1(X,NV_0,MAX_atom):- not okc, posc(X,Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _true(Y), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,MAX_atom):- not okc, negc(X,Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _false(Y), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,MAX_atom):- not okc, not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), posc(X,Y), not _true(Y), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,MAX_atom):- not okc, not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), negc(X,Y), not _false(Y), not succ_conj(X,NV_0), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, posc(X,Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _true(Y), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, negc(X,Y), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _false(Y), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), posc(X,Y), not _true(Y), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), negc(X,Y), not _false(Y), not _s_0(X).
:- not okc, not succ_conj(X,NV_0), not t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), posc(X,Y), not _true(Y).
:- not okc, not succ_conj(X,NV_0), not t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), negc(X,Y), not _false(Y).
:- not okc, not s_0(NV_0), not t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), posc(X,Y), not _true(Y).
:- not okc, not s_0(NV_0), not t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), negc(X,Y), not _false(Y).
:- not t_1(X,NV_0,MAX_atom), not s_1(X,NV_0,NV_1), succ_atom(Y,NV_1), s_1(X,NV_0,Y), not _s_0(X).
t_1(X,NV_0,MAX_atom):- max_atom(Y), s_1(X,NV_0,Y), not succ_conj(X,NV_0), not okc, not _true(Y), posc(X,Y).
t_1(X,NV_0,MAX_atom):- max_atom(Y), s_1(X,NV_0,Y), not succ_conj(X,NV_0), not okc, not _false(Y), negc(X,Y).
t_1(X,NV_0,MAX_atom):- max_atom(Y), s_1(X,NV_0,Y), not s_0(NV_0), not okc, not _true(Y), posc(X,Y).
t_1(X,NV_0,MAX_atom):- max_atom(Y), s_1(X,NV_0,Y), not s_0(NV_0), not okc, not _false(Y), negc(X,Y).
t_1(X,NV_0,MAX_atom):- s_0(X), max_atom(Y), s_1(X,NV_0,Y).
t_1(X,NV_0,MAX_atom):- not okc, posc(X,Y), max_atom(Y), s_1(X,NV_0,Y), not _true(Y), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,MAX_atom):- not okc, negc(X,Y), max_atom(Y), s_1(X,NV_0,Y), not _false(Y), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_1(X,NV_0,Y), posc(X,Y), not _true(Y), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_1(X,NV_0,Y), negc(X,Y), not _false(Y), not succ_conj(X,NV_0), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, posc(X,Y), max_atom(Y), s_1(X,NV_0,Y), not _true(Y), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, negc(X,Y), max_atom(Y), s_1(X,NV_0,Y), not _false(Y), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_1(X,NV_0,Y), posc(X,Y), not _true(Y), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_1(X,NV_0,Y), negc(X,Y), not _false(Y), not _s_0(X).
:- not okc, not succ_conj(X,NV_0), not t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), posc(X,Y), not _true(Y).
:- not okc, not succ_conj(X,NV_0), not t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), negc(X,Y), not _false(Y).
:- not okc, not s_0(NV_0), not t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), posc(X,Y), not _true(Y).
:- not okc, not s_0(NV_0), not t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), negc(X,Y), not _false(Y).
:- not t_1(X,NV_0,MAX_atom), max_atom(Y), s_1(X,NV_0,Y), not _s_0(X).
s_0(X) | t_1(X,NV_0,NV_1):- succ_conj(X,NV_0), s_0(NV_0), t_1(X,NV_0,Y), succ_atom(Y,NV_1).
s_0(X) | t_1(X,NV_0,NV_1):- not negc(X,NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not posc(X,NV_1).
s_0(X) | t_1(X,NV_0,NV_1):- not false(NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not posc(X,NV_1).
s_0(X) | t_1(X,NV_0,NV_1):- not negc(X,NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not true(NV_1).
s_0(X) | t_1(X,NV_0,NV_1):- not false(NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not true(NV_1).
s_0(X) | t_1(X,NV_0,NV_1):- t_1(X,NV_0,Y), succ_atom(Y,NV_1), not _okc.
s_0(X) | t_1(X,NV_0,NV_1):- t_1(X,NV_0,Y), succ_atom(Y,NV_1), not negc(X,NV_1), not posc(X,NV_1), not _okc.
s_0(X) | t_1(X,NV_0,NV_1):- not false(NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not posc(X,NV_1), not _okc.
s_0(X) | t_1(X,NV_0,NV_1):- not true(NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not negc(X,NV_1), not _okc.
s_0(X) | t_1(X,NV_0,NV_1):- not false(NV_1), not true(NV_1), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not _okc.
t_1(X,NV_0,NV_1):- not s_0(X), t_1(X,NV_0,Y), succ_atom(Y,NV_1), succ_conj(X,NV_0), not _s_0(NV_0).
t_1(X,NV_0,NV_1):- not negc(X,NV_1), not posc(X,NV_1), not s_0(X), t_1(X,NV_0,Y), succ_atom(Y,NV_1).
t_1(X,NV_0,NV_1):- not false(NV_1), not posc(X,NV_1), not s_0(X), t_1(X,NV_0,Y), succ_atom(Y,NV_1).
t_1(X,NV_0,NV_1):- not negc(X,NV_1), not true(NV_1), not s_0(X), t_1(X,NV_0,Y), succ_atom(Y,NV_1).
t_1(X,NV_0,NV_1):- not false(NV_1), not true(NV_1), not s_0(X), t_1(X,NV_0,Y), succ_atom(Y,NV_1).
t_1(X,NV_0,NV_1):- not s_0(X), t_1(X,NV_0,Y), succ_atom(Y,NV_1), not _okc.
:- succ_atom(Y,NV_1), not s_0(X), not t_1(X,NV_0,NV_1), not _s_0(NV_0), succ_conj(X,NV_0), not _t_1(X,NV_0,Y).
:- not negc(X,NV_1), succ_atom(Y,NV_1), not s_0(X), not t_1(X,NV_0,NV_1), not posc(X,NV_1), not _t_1(X,NV_0,Y).
:- not false(NV_1), succ_atom(Y,NV_1), not s_0(X), not t_1(X,NV_0,NV_1), not posc(X,NV_1), not _t_1(X,NV_0,Y).
:- not negc(X,NV_1), succ_atom(Y,NV_1), not s_0(X), not t_1(X,NV_0,NV_1), not true(NV_1), not _t_1(X,NV_0,Y).
:- not false(NV_1), succ_atom(Y,NV_1), not s_0(X), not t_1(X,NV_0,NV_1), not true(NV_1), not _t_1(X,NV_0,Y).
:- succ_atom(Y,NV_1), not s_0(X), not t_1(X,NV_0,NV_1), not _okc, not _t_1(X,NV_0,Y).
t_1(X,NV_0,Y):- succ_atom(Y,NV_1), not succ_conj(X,NV_0), not okc, not _true(NV_1), posc(X,NV_1).
t_1(X,NV_0,Y):- succ_atom(Y,NV_1), not succ_conj(X,NV_0), not okc, not _false(NV_1), negc(X,NV_1).
t_1(X,NV_0,Y):- succ_atom(Y,NV_1), not s_0(NV_0), not okc, not _true(NV_1), posc(X,NV_1).
t_1(X,NV_0,Y):- succ_atom(Y,NV_1), not s_0(NV_0), not okc, not _false(NV_1), negc(X,NV_1).
t_1(X,NV_0,Y):- s_0(X), succ_atom(Y,NV_1).
t_1(X,NV_0,Y):- not okc, posc(X,NV_1), succ_atom(Y,NV_1), not _true(NV_1), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,Y):- not okc, negc(X,NV_1), succ_atom(Y,NV_1), not _false(NV_1), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,Y):- not okc, succ_atom(Y,NV_1), posc(X,NV_1), not _true(NV_1), not succ_conj(X,NV_0), not _s_0(X).
t_1(X,NV_0,Y):- not okc, succ_atom(Y,NV_1), negc(X,NV_1), not _false(NV_1), not succ_conj(X,NV_0), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,Y):- not okc, posc(X,NV_1), succ_atom(Y,NV_1), not _true(NV_1), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,Y):- not okc, negc(X,NV_1), succ_atom(Y,NV_1), not _false(NV_1), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,Y):- not okc, succ_atom(Y,NV_1), posc(X,NV_1), not _true(NV_1), not _s_0(X).
s_0(NV_0) | t_1(X,NV_0,Y):- not okc, succ_atom(Y,NV_1), negc(X,NV_1), not _false(NV_1), not _s_0(X).
t_1(X,NV_0,Y):- t_1(X,NV_0,NV_1), succ_atom(Y,NV_1).
:- not okc, not succ_conj(X,NV_0), not t_1(X,NV_0,Y), succ_atom(Y,NV_1), posc(X,NV_1), not _true(NV_1).
:- not okc, not succ_conj(X,NV_0), not t_1(X,NV_0,Y), succ_atom(Y,NV_1), negc(X,NV_1), not _false(NV_1).
:- not okc, not s_0(NV_0), not t_1(X,NV_0,Y), succ_atom(Y,NV_1), posc(X,NV_1), not _true(NV_1).
:- not okc, not s_0(NV_0), not t_1(X,NV_0,Y), succ_atom(Y,NV_1), negc(X,NV_1), not _false(NV_1).
:- not t_1(X,NV_0,Y), succ_atom(Y,NV_1), not _s_0(X).
:- not t_1(X,NV_0,Y), succ_atom(Y,NV_1), not _t_1(X,NV_0,NV_1).
okc | t_0(MIN_conj):- posc(MIN_conj,Y), true(Y).
okc | t_0(MIN_conj):- negc(MIN_conj,Y), false(Y).
t_0(MIN_conj):- not okc, posc(MIN_conj,Y), not _true(Y).
t_0(MIN_conj):- not okc, negc(MIN_conj,Y), not _false(Y).
okc:- posc(X,Y), true(Y), t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X).
okc:- negc(X,Y), false(Y), t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X).
:- not okc, t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), posc(X,Y), not _true(Y).
:- not okc, t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), negc(X,Y), not _false(Y).
:- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), not okc, not _true(Y), posc(X,Y), not _t_0(MAX_conj).
:- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), not okc, not _false(Y), negc(X,Y), not _t_0(MAX_conj).
okc:- posc(X,Y), true(Y), t_0(MAX_conj), max_conj(X), s_0(X).
okc:- negc(X,Y), false(Y), t_0(MAX_conj), max_conj(X), s_0(X).
:- not okc, t_0(MAX_conj), max_conj(X), s_0(X), posc(X,Y), not _true(Y).
:- not okc, t_0(MAX_conj), max_conj(X), s_0(X), negc(X,Y), not _false(Y).
:- max_conj(X), s_0(X), not okc, not _true(Y), posc(X,Y), not _t_0(MAX_conj).
:- max_conj(X), s_0(X), not okc, not _false(Y), negc(X,Y), not _t_0(MAX_conj).
:- not s_2(X,NV_0,MIN_atom).
s_2(X,NV_0,Y):- succ_atom(Y,NV_2), s_2(X,NV_0,NV_2).
s_2(X,NV_0,Y):- not s_0(X).
s_2(X,NV_0,Y):- not max_conj(X), not _s_0(NV_0).
s_2(X,NV_0,Y):- not succ_conj(X,NV_0), not max_conj(X).
s_2(X,NV_0,Y):- not okc, not _true(Y), posc(X,Y).
s_2(X,NV_0,Y):- not okc, not _false(Y), negc(X,Y).
s_2(X,NV_0,Y):- not _t_0(MAX_conj).
s_2(X,NV_0,Y):- not okc, posc(X,Y), not _true(Y), not _t_0(MAX_conj).
s_2(X,NV_0,Y):- not okc, negc(X,Y), not _false(Y), not _t_0(MAX_conj).
s_2(X,NV_0,Y):- not okc, posc(X,Y), not _true(Y), not _t_0(MAX_conj).
s_2(X,NV_0,Y):- not okc, negc(X,Y), not _false(Y), not _t_0(MAX_conj).
s_2(X,NV_0,Y):- not okc, not s_0(X), posc(X,Y), not _true(Y).
s_2(X,NV_0,Y):- not okc, not s_0(X), negc(X,Y), not _false(Y).
s_2(X,NV_0,Y):- not s_0(X), not _t_0(MAX_conj).
s_2(X,NV_0,Y):- not okc, not _s_0(NV_0), not max_conj(X), posc(X,Y), not _true(Y).
s_2(X,NV_0,Y):- not okc, not _s_0(NV_0), not max_conj(X), negc(X,Y), not _false(Y).
s_2(X,NV_0,Y):- not _t_0(MAX_conj), not _s_0(NV_0), not max_conj(X).
s_2(X,NV_0,Y):- not okc, not succ_conj(X,NV_0), not max_conj(X), posc(X,Y), not _true(Y).
s_2(X,NV_0,Y):- not okc, not succ_conj(X,NV_0), not max_conj(X), negc(X,Y), not _false(Y).
s_2(X,NV_0,Y):- not _t_0(MAX_conj), not succ_conj(X,NV_0), not max_conj(X).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not posc(X,MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not false(MIN_atom), s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not posc(X,MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not true(MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not false(MIN_atom), s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not true(MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- okc, s_0(X), not s_0(NV_0), succ_conj(X,NV_0).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not negc(X,MIN_atom), not posc(X,MIN_atom), not _okc.
false(MIN_atom) | t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not posc(X,MIN_atom), not _okc.
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom) | true(MIN_atom):- s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not negc(X,MIN_atom), not _okc.
false(MIN_atom) | t_0(MAX_conj) | t_2(X,NV_0,MIN_atom) | true(MIN_atom):- s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not _okc.
t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), s_0(X), not s_0(NV_0), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), s_0(X), not s_0(NV_0), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not true(MIN_atom), not t_0(MAX_conj), s_0(X), not s_0(NV_0), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not t_0(MAX_conj), s_0(X), not s_0(NV_0), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not t_0(MAX_conj), s_0(X), not s_0(NV_0), succ_conj(X,NV_0), not _okc.
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), s_0(X), max_conj(X), not posc(X,MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not false(MIN_atom), s_0(X), max_conj(X), not posc(X,MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), s_0(X), max_conj(X), not true(MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- not false(MIN_atom), s_0(X), max_conj(X), not true(MIN_atom).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- okc, s_0(X), max_conj(X).
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- s_0(X), max_conj(X), not negc(X,MIN_atom), not posc(X,MIN_atom), not _okc.
false(MIN_atom) | t_0(MAX_conj) | t_2(X,NV_0,MIN_atom):- s_0(X), max_conj(X), not posc(X,MIN_atom), not _okc.
t_0(MAX_conj) | t_2(X,NV_0,MIN_atom) | true(MIN_atom):- s_0(X), max_conj(X), not negc(X,MIN_atom), not _okc.
false(MIN_atom) | t_0(MAX_conj) | t_2(X,NV_0,MIN_atom) | true(MIN_atom):- s_0(X), max_conj(X), not _okc.
t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), s_0(X), max_conj(X).
t_2(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), s_0(X), max_conj(X).
t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not true(MIN_atom), not t_0(MAX_conj), s_0(X), max_conj(X).
t_2(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not t_0(MAX_conj), s_0(X), max_conj(X).
t_2(X,NV_0,MIN_atom):- not t_0(MAX_conj), s_0(X), max_conj(X), not _okc.
t_2(X,NV_0,MIN_atom):- not s_0(NV_0), not negc(X,MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), max_conj(X), not _s_0(X).
t_2(X,NV_0,MIN_atom):- not s_0(NV_0), not false(MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(X,MIN_atom), not t_0(MAX_conj), max_conj(X), not _s_0(X).
t_2(X,NV_0,MIN_atom):- not s_0(NV_0), not negc(X,MIN_atom), not true(MIN_atom), not t_0(MAX_conj), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not negc(X,MIN_atom), not true(MIN_atom), not t_0(MAX_conj), max_conj(X), not _s_0(X).
t_2(X,NV_0,MIN_atom):- not s_0(NV_0), not false(MIN_atom), not true(MIN_atom), not t_0(MAX_conj), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not t_0(MAX_conj), max_conj(X), not _s_0(X).
t_2(X,NV_0,MIN_atom):- not s_0(NV_0), not t_0(MAX_conj), not _okc, not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,MIN_atom):- not t_0(MAX_conj), max_conj(X), not _okc, not _s_0(X).
t_0(MAX_conj):- not negc(X,Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not false(Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not negc(X,Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- not false(Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- okc, not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not negc(X,Y), not posc(X,Y), not _okc.
false(Y) | t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not posc(X,Y), not _okc.
true(Y) | t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not negc(X,Y), not _okc.
false(Y) | true(Y) | t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _okc.
:- not negc(X,Y), not posc(X,Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not false(Y), not posc(X,Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not negc(X,Y), not true(Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not false(Y), not true(Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _okc.
t_0(MAX_conj):- not negc(X,Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not false(Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not negc(X,Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- not false(Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- okc, max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not negc(X,Y), not posc(X,Y), not _okc.
false(Y) | t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not posc(X,Y), not _okc.
true(Y) | t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not negc(X,Y), not _okc.
false(Y) | true(Y) | t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _okc.
:- not negc(X,Y), not posc(X,Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not false(Y), not posc(X,Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not negc(X,Y), not true(Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not false(Y), not true(Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _okc.
:- not s_0(NV_0), not negc(X,Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), succ_conj(X,NV_0).
:- not negc(X,Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), not false(Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), succ_conj(X,NV_0).
:- not false(Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), not negc(X,Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), succ_conj(X,NV_0).
:- not negc(X,Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), not false(Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), succ_conj(X,NV_0).
:- not false(Y), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not _okc, not _s_0(X), succ_conj(X,NV_0).
:- t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not _okc, not _s_0(X), max_conj(X).
:- not negc(X,Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not posc(X,Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not posc(X,Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not negc(X,Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not true(Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not true(Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not _okc, succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not negc(X,Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not negc(X,Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not t_0(MAX_conj), not _okc, max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
t_0(MAX_conj):- not negc(X,Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not false(Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not negc(X,Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- not false(Y), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- okc, not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not negc(X,Y), not posc(X,Y), not _okc.
false(Y) | t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not posc(X,Y), not _okc.
true(Y) | t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not negc(X,Y), not _okc.
false(Y) | true(Y) | t_0(MAX_conj):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not _okc.
:- not negc(X,Y), not posc(X,Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not false(Y), not posc(X,Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not negc(X,Y), not true(Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not false(Y), not true(Y), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not _okc.
t_0(MAX_conj):- not negc(X,Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not false(Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not posc(X,Y).
t_0(MAX_conj):- not negc(X,Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- not false(Y), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not true(Y).
t_0(MAX_conj):- okc, max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not negc(X,Y), not posc(X,Y), not _okc.
false(Y) | t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not posc(X,Y), not _okc.
true(Y) | t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not negc(X,Y), not _okc.
false(Y) | true(Y) | t_0(MAX_conj):- max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not _okc.
:- not negc(X,Y), not posc(X,Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not false(Y), not posc(X,Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not negc(X,Y), not true(Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not false(Y), not true(Y), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not _okc.
:- not s_0(NV_0), not negc(X,Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), succ_conj(X,NV_0).
:- not negc(X,Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), not false(Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), succ_conj(X,NV_0).
:- not false(Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), not negc(X,Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), succ_conj(X,NV_0).
:- not negc(X,Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), not false(Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), succ_conj(X,NV_0).
:- not false(Y), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), not _s_0(X), max_conj(X).
:- not s_0(NV_0), t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not _okc, not _s_0(X), succ_conj(X,NV_0).
:- t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not _okc, not _s_0(X), max_conj(X).
:- not negc(X,Y), max_atom(Y), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not posc(X,Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not posc(X,Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not negc(X,Y), max_atom(Y), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not true(Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not true(Y), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- max_atom(Y), s_2(X,NV_0,Y), not s_0(NV_0), not t_0(MAX_conj), not _okc, succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not negc(X,Y), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not posc(X,Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not negc(X,Y), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not true(Y), max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
:- max_atom(Y), s_2(X,NV_0,Y), not t_0(MAX_conj), not _okc, max_conj(X), not _s_0(X), not _t_2(X,NV_0,MAX_atom).
t_2(X,NV_0,MAX_atom):- not s_0(X), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
t_2(X,NV_0,MAX_atom):- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not max_conj(X), not _s_0(NV_0).
t_2(X,NV_0,MAX_atom):- not succ_conj(X,NV_0), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not max_conj(X).
t_2(X,NV_0,MAX_atom):- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not okc, not _true(Y), posc(X,Y).
t_2(X,NV_0,MAX_atom):- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not okc, not _false(Y), negc(X,Y).
t_2(X,NV_0,MAX_atom):- t_0(MAX_conj), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
okc | t_2(X,NV_0,MAX_atom):- posc(X,Y), true(Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _t_0(MAX_conj).
okc | t_2(X,NV_0,MAX_atom):- negc(X,Y), false(Y), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), posc(X,Y), not _true(Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), negc(X,Y), not _false(Y), not _t_0(MAX_conj).
s_0(X) | t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), posc(X,Y), not _true(Y).
s_0(X) | t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), negc(X,Y), not _false(Y).
s_0(X) | t_2(X,NV_0,MAX_atom):- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _s_0(NV_0), not max_conj(X), posc(X,Y), not _true(Y).
t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _s_0(NV_0), not max_conj(X), negc(X,Y), not _false(Y).
t_2(X,NV_0,MAX_atom):- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _t_0(MAX_conj), not _s_0(NV_0), not max_conj(X).
t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not succ_conj(X,NV_0), not max_conj(X), posc(X,Y), not _true(Y).
t_2(X,NV_0,MAX_atom):- not okc, not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not succ_conj(X,NV_0), not max_conj(X), negc(X,Y), not _false(Y).
t_2(X,NV_0,MAX_atom):- not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _t_0(MAX_conj), not succ_conj(X,NV_0), not max_conj(X).
:- not s_0(X), not t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not max_conj(X), not t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _s_0(NV_0).
:- not max_conj(X), not succ_conj(X,NV_0), not t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y).
:- not okc, not t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), posc(X,Y), not _true(Y).
:- not okc, not t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), negc(X,Y), not _false(Y).
:- not t_2(X,NV_0,MAX_atom), not s_2(X,NV_0,NV_2), succ_atom(Y,NV_2), s_2(X,NV_0,Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not s_0(X), max_atom(Y), s_2(X,NV_0,Y).
t_2(X,NV_0,MAX_atom):- max_atom(Y), s_2(X,NV_0,Y), not max_conj(X), not _s_0(NV_0).
t_2(X,NV_0,MAX_atom):- not succ_conj(X,NV_0), max_atom(Y), s_2(X,NV_0,Y), not max_conj(X).
t_2(X,NV_0,MAX_atom):- max_atom(Y), s_2(X,NV_0,Y), not okc, not _true(Y), posc(X,Y).
t_2(X,NV_0,MAX_atom):- max_atom(Y), s_2(X,NV_0,Y), not okc, not _false(Y), negc(X,Y).
t_2(X,NV_0,MAX_atom):- t_0(MAX_conj), max_atom(Y), s_2(X,NV_0,Y).
okc | t_2(X,NV_0,MAX_atom):- posc(X,Y), true(Y), max_atom(Y), s_2(X,NV_0,Y), not _t_0(MAX_conj).
okc | t_2(X,NV_0,MAX_atom):- negc(X,Y), false(Y), max_atom(Y), s_2(X,NV_0,Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), posc(X,Y), not _true(Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), negc(X,Y), not _false(Y), not _t_0(MAX_conj).
s_0(X) | t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), posc(X,Y), not _true(Y).
s_0(X) | t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), negc(X,Y), not _false(Y).
s_0(X) | t_2(X,NV_0,MAX_atom):- max_atom(Y), s_2(X,NV_0,Y), not _t_0(MAX_conj).
t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), not _s_0(NV_0), not max_conj(X), posc(X,Y), not _true(Y).
t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), not _s_0(NV_0), not max_conj(X), negc(X,Y), not _false(Y).
t_2(X,NV_0,MAX_atom):- max_atom(Y), s_2(X,NV_0,Y), not _t_0(MAX_conj), not _s_0(NV_0), not max_conj(X).
t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), not succ_conj(X,NV_0), not max_conj(X), posc(X,Y), not _true(Y).
t_2(X,NV_0,MAX_atom):- not okc, max_atom(Y), s_2(X,NV_0,Y), not succ_conj(X,NV_0), not max_conj(X), negc(X,Y), not _false(Y).
t_2(X,NV_0,MAX_atom):- max_atom(Y), s_2(X,NV_0,Y), not _t_0(MAX_conj), not succ_conj(X,NV_0), not max_conj(X).
:- not s_0(X), not t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not max_conj(X), not t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not _s_0(NV_0).
:- not max_conj(X), not succ_conj(X,NV_0), not t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y).
:- not okc, not t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), posc(X,Y), not _true(Y).
:- not okc, not t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), negc(X,Y), not _false(Y).
:- not t_2(X,NV_0,MAX_atom), max_atom(Y), s_2(X,NV_0,Y), not _t_0(MAX_conj).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not negc(X,NV_2), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not posc(X,NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not false(NV_2), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not posc(X,NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not negc(X,NV_2), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not true(NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not false(NV_2), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not true(NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- okc, not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not negc(X,NV_2), not posc(X,NV_2), not _okc.
false(NV_2) | t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not posc(X,NV_2), not _okc.
true(NV_2) | t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not negc(X,NV_2), not _okc.
false(NV_2) | true(NV_2) | t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _okc.
t_2(X,NV_0,NV_2):- not negc(X,NV_2), not posc(X,NV_2), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not false(NV_2), not posc(X,NV_2), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not negc(X,NV_2), not true(NV_2), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not false(NV_2), not true(NV_2), not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not t_0(MAX_conj), not s_0(NV_0), succ_conj(X,NV_0), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _okc.
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not negc(X,NV_2), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not posc(X,NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not false(NV_2), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not posc(X,NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not negc(X,NV_2), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not true(NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- not false(NV_2), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not true(NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- okc, max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_0(MAX_conj) | t_2(X,NV_0,NV_2):- max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not negc(X,NV_2), not posc(X,NV_2), not _okc.
false(NV_2) | t_0(MAX_conj) | t_2(X,NV_0,NV_2):- max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not posc(X,NV_2), not _okc.
true(NV_2) | t_0(MAX_conj) | t_2(X,NV_0,NV_2):- max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not negc(X,NV_2), not _okc.
false(NV_2) | true(NV_2) | t_0(MAX_conj) | t_2(X,NV_0,NV_2):- max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _okc.
t_2(X,NV_0,NV_2):- not negc(X,NV_2), not posc(X,NV_2), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not false(NV_2), not posc(X,NV_2), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not negc(X,NV_2), not true(NV_2), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not false(NV_2), not true(NV_2), not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2).
t_2(X,NV_0,NV_2):- not t_0(MAX_conj), max_conj(X), s_0(X), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _okc.
t_2(X,NV_0,NV_2):- not s_0(NV_0), not negc(X,NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not posc(X,NV_2), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,NV_2):- not negc(X,NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not posc(X,NV_2), not _s_0(X), max_conj(X).
t_2(X,NV_0,NV_2):- not s_0(NV_0), not false(NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not posc(X,NV_2), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,NV_2):- not false(NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not posc(X,NV_2), not _s_0(X), max_conj(X).
t_2(X,NV_0,NV_2):- not s_0(NV_0), not negc(X,NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not true(NV_2), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,NV_2):- not negc(X,NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not true(NV_2), not _s_0(X), max_conj(X).
t_2(X,NV_0,NV_2):- not s_0(NV_0), not false(NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not true(NV_2), not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,NV_2):- not false(NV_2), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not true(NV_2), not _s_0(X), max_conj(X).
t_2(X,NV_0,NV_2):- not s_0(NV_0), t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not _okc, not _s_0(X), succ_conj(X,NV_0).
t_2(X,NV_0,NV_2):- t_2(X,NV_0,Y), succ_atom(Y,NV_2), not t_0(MAX_conj), not _okc, not _s_0(X), max_conj(X).
:- not negc(X,NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not s_0(NV_0), not t_0(MAX_conj), not posc(X,NV_2), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,Y).
:- not false(NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not s_0(NV_0), not t_0(MAX_conj), not posc(X,NV_2), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,Y).
:- not negc(X,NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not s_0(NV_0), not t_0(MAX_conj), not true(NV_2), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,Y).
:- not false(NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not s_0(NV_0), not t_0(MAX_conj), not true(NV_2), succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,Y).
:- succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not s_0(NV_0), not t_0(MAX_conj), not _okc, succ_conj(X,NV_0), not _s_0(X), not _t_2(X,NV_0,Y).
:- not negc(X,NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not t_0(MAX_conj), not posc(X,NV_2), max_conj(X), not _s_0(X), not _t_2(X,NV_0,Y).
:- not false(NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not t_0(MAX_conj), not posc(X,NV_2), max_conj(X), not _s_0(X), not _t_2(X,NV_0,Y).
:- not negc(X,NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not t_0(MAX_conj), not true(NV_2), max_conj(X), not _s_0(X), not _t_2(X,NV_0,Y).
:- not false(NV_2), succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not t_0(MAX_conj), not true(NV_2), max_conj(X), not _s_0(X), not _t_2(X,NV_0,Y).
:- succ_atom(Y,NV_2), not t_2(X,NV_0,NV_2), not t_0(MAX_conj), not _okc, max_conj(X), not _s_0(X), not _t_2(X,NV_0,Y).
t_2(X,NV_0,Y):- not s_0(X), succ_atom(Y,NV_2).
t_2(X,NV_0,Y):- succ_atom(Y,NV_2), not max_conj(X), not _s_0(NV_0).
t_2(X,NV_0,Y):- not succ_conj(X,NV_0), succ_atom(Y,NV_2), not max_conj(X).
t_2(X,NV_0,Y):- succ_atom(Y,NV_2), not okc, not _true(NV_2), posc(X,NV_2).
t_2(X,NV_0,Y):- succ_atom(Y,NV_2), not okc, not _false(NV_2), negc(X,NV_2).
t_2(X,NV_0,Y):- t_0(MAX_conj), succ_atom(Y,NV_2).
okc | t_2(X,NV_0,Y):- posc(X,NV_2), true(NV_2), succ_atom(Y,NV_2), not _t_0(MAX_conj).
okc | t_2(X,NV_0,Y):- negc(X,NV_2), false(NV_2), succ_atom(Y,NV_2), not _t_0(MAX_conj).
t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), posc(X,NV_2), not _true(NV_2), not _t_0(MAX_conj).
t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), negc(X,NV_2), not _false(NV_2), not _t_0(MAX_conj).
s_0(X) | t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), posc(X,NV_2), not _true(NV_2).
s_0(X) | t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), negc(X,NV_2), not _false(NV_2).
s_0(X) | t_2(X,NV_0,Y):- succ_atom(Y,NV_2), not _t_0(MAX_conj).
t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), not _s_0(NV_0), not max_conj(X), posc(X,NV_2), not _true(NV_2).
t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), not _s_0(NV_0), not max_conj(X), negc(X,NV_2), not _false(NV_2).
t_2(X,NV_0,Y):- succ_atom(Y,NV_2), not _t_0(MAX_conj), not _s_0(NV_0), not max_conj(X).
t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), not succ_conj(X,NV_0), not max_conj(X), posc(X,NV_2), not _true(NV_2).
t_2(X,NV_0,Y):- not okc, succ_atom(Y,NV_2), not succ_conj(X,NV_0), not max_conj(X), negc(X,NV_2), not _false(NV_2).
t_2(X,NV_0,Y):- succ_atom(Y,NV_2), not _t_0(MAX_conj), not succ_conj(X,NV_0), not max_conj(X).
t_2(X,NV_0,Y):- t_2(X,NV_0,NV_2), succ_atom(Y,NV_2).
:- not s_0(X), not t_2(X,NV_0,Y), succ_atom(Y,NV_2).
:- not max_conj(X), not t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _s_0(NV_0).
:- not max_conj(X), not succ_conj(X,NV_0), not t_2(X,NV_0,Y), succ_atom(Y,NV_2).
:- not okc, not t_2(X,NV_0,Y), succ_atom(Y,NV_2), posc(X,NV_2), not _true(NV_2).
:- not okc, not t_2(X,NV_0,Y), succ_atom(Y,NV_2), negc(X,NV_2), not _false(NV_2).
:- not t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _t_0(MAX_conj).
:- not t_2(X,NV_0,Y), succ_atom(Y,NV_2), not _t_2(X,NV_0,NV_2).
okc | t_0(NV_0):- posc(NV_0,Y), true(Y), t_0(X), succ_conj(X,NV_0).
okc | t_0(NV_0):- negc(NV_0,Y), false(Y), t_0(X), succ_conj(X,NV_0).
t_0(NV_0):- not okc, t_0(X), succ_conj(X,NV_0), posc(NV_0,Y), not _true(Y).
t_0(NV_0):- not okc, t_0(X), succ_conj(X,NV_0), negc(NV_0,Y), not _false(Y).
:- succ_conj(X,NV_0), not okc, not t_0(NV_0), not _true(Y), posc(NV_0,Y), not _t_0(X).
:- succ_conj(X,NV_0), not okc, not t_0(NV_0), not _false(Y), negc(NV_0,Y), not _t_0(X).
:- not s_3(X,NV_0,MIN_atom).
s_3(X,NV_0,Y):- succ_atom(Y,NV_3), s_3(X,NV_0,NV_3).
s_3(X,NV_0,Y):- not succ_conj(X,NV_0).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, not _true(Y), posc(NV_0,Y).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, not _false(Y), negc(NV_0,Y).
s_3(X,NV_0,Y):- not _t_0(X).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, posc(NV_0,Y), not _true(Y), not _t_0(X).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, negc(NV_0,Y), not _false(Y), not _t_0(X).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, posc(NV_0,Y), not _true(Y), not _t_0(X).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, negc(NV_0,Y), not _false(Y), not _t_0(X).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, not succ_conj(X,NV_0), posc(NV_0,Y), not _true(Y).
s_3(X,NV_0,Y):- not t_0(NV_0), not okc, not succ_conj(X,NV_0), negc(NV_0,Y), not _false(Y).
s_3(X,NV_0,Y):- not _t_0(X), not succ_conj(X,NV_0).
t_0(X) | t_3(X,NV_0,MIN_atom):- not negc(NV_0,MIN_atom), succ_conj(X,NV_0), not posc(NV_0,MIN_atom).
t_0(X) | t_3(X,NV_0,MIN_atom):- not false(MIN_atom), succ_conj(X,NV_0), not posc(NV_0,MIN_atom).
t_0(X) | t_3(X,NV_0,MIN_atom):- not negc(NV_0,MIN_atom), succ_conj(X,NV_0), not true(MIN_atom).
t_0(X) | t_3(X,NV_0,MIN_atom):- not false(MIN_atom), succ_conj(X,NV_0), not true(MIN_atom).
t_0(X) | t_3(X,NV_0,MIN_atom):- okc, succ_conj(X,NV_0).
t_0(X) | t_3(X,NV_0,MIN_atom):- succ_conj(X,NV_0), not negc(NV_0,MIN_atom), not posc(NV_0,MIN_atom), not _okc.
false(MIN_atom) | t_0(X) | t_3(X,NV_0,MIN_atom):- succ_conj(X,NV_0), not posc(NV_0,MIN_atom), not _okc.
t_0(X) | t_3(X,NV_0,MIN_atom) | true(MIN_atom):- succ_conj(X,NV_0), not negc(NV_0,MIN_atom), not _okc.
false(MIN_atom) | t_0(X) | t_3(X,NV_0,MIN_atom) | true(MIN_atom):- succ_conj(X,NV_0), not _okc.
t_0(X) | t_3(X,NV_0,MIN_atom):- t_0(NV_0), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not negc(NV_0,MIN_atom), not posc(NV_0,MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(NV_0,MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not negc(NV_0,MIN_atom), not true(MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not t_0(X), succ_conj(X,NV_0), not _okc.
t_3(X,NV_0,MIN_atom):- not t_0(X), succ_conj(X,NV_0), not _t_0(NV_0).
t_3(X,NV_0,MIN_atom):- not negc(NV_0,MIN_atom), not posc(NV_0,MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not false(MIN_atom), not posc(NV_0,MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not negc(NV_0,MIN_atom), not true(MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not false(MIN_atom), not true(MIN_atom), not t_0(X), succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not t_0(X), not _okc, succ_conj(X,NV_0).
t_3(X,NV_0,MIN_atom):- not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0).
t_0(X):- not negc(NV_0,Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not posc(NV_0,Y).
t_0(X):- not false(Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not posc(NV_0,Y).
t_0(X):- not negc(NV_0,Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not true(Y).
t_0(X):- not false(Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not true(Y).
t_0(X):- okc, succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not negc(NV_0,Y), not posc(NV_0,Y), not _okc.
false(Y) | t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not posc(NV_0,Y), not _okc.
true(Y) | t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not negc(NV_0,Y), not _okc.
false(Y) | true(Y) | t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not _okc.
t_0(X):- t_0(NV_0), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
:- not negc(NV_0,Y), not posc(NV_0,Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
:- not false(Y), not posc(NV_0,Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
:- not negc(NV_0,Y), not true(Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
:- not false(Y), not true(Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
:- not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not _okc.
:- not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not _t_0(NV_0).
:- not negc(NV_0,Y), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0).
:- not false(Y), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0).
:- not negc(NV_0,Y), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0).
:- not false(Y), t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0).
:- t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not _okc, succ_conj(X,NV_0).
:- t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0).
:- not negc(NV_0,Y), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not false(Y), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not negc(NV_0,Y), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not false(Y), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not _okc, succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
t_0(X):- not negc(NV_0,Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not posc(NV_0,Y).
t_0(X):- not false(Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not posc(NV_0,Y).
t_0(X):- not negc(NV_0,Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not true(Y).
t_0(X):- not false(Y), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not true(Y).
t_0(X):- okc, succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not negc(NV_0,Y), not posc(NV_0,Y), not _okc.
false(Y) | t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not posc(NV_0,Y), not _okc.
true(Y) | t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not negc(NV_0,Y), not _okc.
false(Y) | true(Y) | t_0(X):- succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not _okc.
t_0(X):- t_0(NV_0), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
:- not negc(NV_0,Y), not posc(NV_0,Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
:- not false(Y), not posc(NV_0,Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
:- not negc(NV_0,Y), not true(Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
:- not false(Y), not true(Y), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
:- not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not _okc.
:- not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not _t_0(NV_0).
:- not negc(NV_0,Y), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0).
:- not false(Y), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0).
:- not negc(NV_0,Y), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0).
:- not false(Y), t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0).
:- t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not _okc, succ_conj(X,NV_0).
:- t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0).
:- not negc(NV_0,Y), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not posc(NV_0,Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not negc(NV_0,Y), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- not false(Y), max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not true(Y), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not _okc, succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
:- max_atom(Y), s_3(X,NV_0,Y), not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0), not _t_3(X,NV_0,MAX_atom).
t_3(X,NV_0,MAX_atom):- not succ_conj(X,NV_0), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
t_3(X,NV_0,MAX_atom):- not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not okc, not t_0(NV_0), not _true(Y), posc(NV_0,Y).
t_3(X,NV_0,MAX_atom):- not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not okc, not t_0(NV_0), not _false(Y), negc(NV_0,Y).
t_3(X,NV_0,MAX_atom):- t_0(X), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
okc | t_3(X,NV_0,MAX_atom) | t_0(NV_0):- posc(NV_0,Y), true(Y), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not _t_0(X).
okc | t_3(X,NV_0,MAX_atom) | t_0(NV_0):- negc(NV_0,Y), false(Y), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not _t_0(X).
t_3(X,NV_0,MAX_atom) | t_0(NV_0):- not okc, not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), posc(NV_0,Y), not _true(Y), not _t_0(X).
t_3(X,NV_0,MAX_atom) | t_0(NV_0):- not okc, not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), negc(NV_0,Y), not _false(Y), not _t_0(X).
t_3(X,NV_0,MAX_atom):- not t_0(NV_0), not okc, not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not succ_conj(X,NV_0), posc(NV_0,Y), not _true(Y).
t_3(X,NV_0,MAX_atom):- not t_0(NV_0), not okc, not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not succ_conj(X,NV_0), negc(NV_0,Y), not _false(Y).
t_3(X,NV_0,MAX_atom):- not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not succ_conj(X,NV_0), not _t_0(X).
:- not succ_conj(X,NV_0), not t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y).
:- not t_0(NV_0), not okc, not t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), posc(NV_0,Y), not _true(Y).
:- not t_0(NV_0), not okc, not t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), negc(NV_0,Y), not _false(Y).
:- not t_3(X,NV_0,MAX_atom), not s_3(X,NV_0,NV_3), succ_atom(Y,NV_3), s_3(X,NV_0,Y), not _t_0(X).
t_3(X,NV_0,MAX_atom):- not succ_conj(X,NV_0), max_atom(Y), s_3(X,NV_0,Y).
t_3(X,NV_0,MAX_atom):- max_atom(Y), s_3(X,NV_0,Y), not okc, not t_0(NV_0), not _true(Y), posc(NV_0,Y).
t_3(X,NV_0,MAX_atom):- max_atom(Y), s_3(X,NV_0,Y), not okc, not t_0(NV_0), not _false(Y), negc(NV_0,Y).
t_3(X,NV_0,MAX_atom):- t_0(X), max_atom(Y), s_3(X,NV_0,Y).
okc | t_3(X,NV_0,MAX_atom) | t_0(NV_0):- posc(NV_0,Y), true(Y), max_atom(Y), s_3(X,NV_0,Y), not _t_0(X).
okc | t_3(X,NV_0,MAX_atom) | t_0(NV_0):- negc(NV_0,Y), false(Y), max_atom(Y), s_3(X,NV_0,Y), not _t_0(X).
t_3(X,NV_0,MAX_atom) | t_0(NV_0):- not okc, max_atom(Y), s_3(X,NV_0,Y), posc(NV_0,Y), not _true(Y), not _t_0(X).
t_3(X,NV_0,MAX_atom) | t_0(NV_0):- not okc, max_atom(Y), s_3(X,NV_0,Y), negc(NV_0,Y), not _false(Y), not _t_0(X).
t_3(X,NV_0,MAX_atom):- not t_0(NV_0), not okc, max_atom(Y), s_3(X,NV_0,Y), not succ_conj(X,NV_0), posc(NV_0,Y), not _true(Y).
t_3(X,NV_0,MAX_atom):- not t_0(NV_0), not okc, max_atom(Y), s_3(X,NV_0,Y), not succ_conj(X,NV_0), negc(NV_0,Y), not _false(Y).
t_3(X,NV_0,MAX_atom):- max_atom(Y), s_3(X,NV_0,Y), not succ_conj(X,NV_0), not _t_0(X).
:- not succ_conj(X,NV_0), not t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y).
:- not t_0(NV_0), not okc, not t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), posc(NV_0,Y), not _true(Y).
:- not t_0(NV_0), not okc, not t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), negc(NV_0,Y), not _false(Y).
:- not t_3(X,NV_0,MAX_atom), max_atom(Y), s_3(X,NV_0,Y), not _t_0(X).
t_0(X) | t_3(X,NV_0,NV_3):- not negc(NV_0,NV_3), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not posc(NV_0,NV_3).
t_0(X) | t_3(X,NV_0,NV_3):- not false(NV_3), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not posc(NV_0,NV_3).
t_0(X) | t_3(X,NV_0,NV_3):- not negc(NV_0,NV_3), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not true(NV_3).
t_0(X) | t_3(X,NV_0,NV_3):- not false(NV_3), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not true(NV_3).
t_0(X) | t_3(X,NV_0,NV_3):- okc, succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3).
t_0(X) | t_3(X,NV_0,NV_3):- succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not negc(NV_0,NV_3), not posc(NV_0,NV_3), not _okc.
false(NV_3) | t_0(X) | t_3(X,NV_0,NV_3):- succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not posc(NV_0,NV_3), not _okc.
true(NV_3) | t_0(X) | t_3(X,NV_0,NV_3):- succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not negc(NV_0,NV_3), not _okc.
false(NV_3) | true(NV_3) | t_0(X) | t_3(X,NV_0,NV_3):- succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not _okc.
t_0(X) | t_3(X,NV_0,NV_3):- t_0(NV_0), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3).
t_3(X,NV_0,NV_3):- not negc(NV_0,NV_3), not posc(NV_0,NV_3), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3).
t_3(X,NV_0,NV_3):- not false(NV_3), not posc(NV_0,NV_3), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3).
t_3(X,NV_0,NV_3):- not negc(NV_0,NV_3), not true(NV_3), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3).
t_3(X,NV_0,NV_3):- not false(NV_3), not true(NV_3), not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3).
t_3(X,NV_0,NV_3):- not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not _okc.
t_3(X,NV_0,NV_3):- not t_0(X), succ_conj(X,NV_0), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not _t_0(NV_0).
t_3(X,NV_0,NV_3):- not negc(NV_0,NV_3), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not t_0(X), not posc(NV_0,NV_3), succ_conj(X,NV_0).
t_3(X,NV_0,NV_3):- not false(NV_3), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not t_0(X), not posc(NV_0,NV_3), succ_conj(X,NV_0).
t_3(X,NV_0,NV_3):- not negc(NV_0,NV_3), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not t_0(X), not true(NV_3), succ_conj(X,NV_0).
t_3(X,NV_0,NV_3):- not false(NV_3), t_3(X,NV_0,Y), succ_atom(Y,NV_3), not t_0(X), not true(NV_3), succ_conj(X,NV_0).
t_3(X,NV_0,NV_3):- t_3(X,NV_0,Y), succ_atom(Y,NV_3), not t_0(X), not _okc, succ_conj(X,NV_0).
t_3(X,NV_0,NV_3):- t_3(X,NV_0,Y), succ_atom(Y,NV_3), not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0).
:- not negc(NV_0,NV_3), succ_atom(Y,NV_3), not t_3(X,NV_0,NV_3), not t_0(X), not posc(NV_0,NV_3), succ_conj(X,NV_0), not _t_3(X,NV_0,Y).
:- not false(NV_3), succ_atom(Y,NV_3), not t_3(X,NV_0,NV_3), not t_0(X), not posc(NV_0,NV_3), succ_conj(X,NV_0), not _t_3(X,NV_0,Y).
:- not negc(NV_0,NV_3), succ_atom(Y,NV_3), not t_3(X,NV_0,NV_3), not t_0(X), not true(NV_3), succ_conj(X,NV_0), not _t_3(X,NV_0,Y).
:- not false(NV_3), succ_atom(Y,NV_3), not t_3(X,NV_0,NV_3), not t_0(X), not true(NV_3), succ_conj(X,NV_0), not _t_3(X,NV_0,Y).
:- succ_atom(Y,NV_3), not t_3(X,NV_0,NV_3), not t_0(X), not _okc, succ_conj(X,NV_0), not _t_3(X,NV_0,Y).
:- succ_atom(Y,NV_3), not t_3(X,NV_0,NV_3), not t_0(X), not _t_0(NV_0), succ_conj(X,NV_0), not _t_3(X,NV_0,Y).
t_3(X,NV_0,Y):- not succ_conj(X,NV_0), succ_atom(Y,NV_3).
t_3(X,NV_0,Y):- succ_atom(Y,NV_3), not okc, not t_0(NV_0), not _true(NV_3), posc(NV_0,NV_3).
t_3(X,NV_0,Y):- succ_atom(Y,NV_3), not okc, not t_0(NV_0), not _false(NV_3), negc(NV_0,NV_3).
t_3(X,NV_0,Y):- t_0(X), succ_atom(Y,NV_3).
okc | t_3(X,NV_0,Y) | t_0(NV_0):- posc(NV_0,NV_3), true(NV_3), succ_atom(Y,NV_3), not _t_0(X).
okc | t_3(X,NV_0,Y) | t_0(NV_0):- negc(NV_0,NV_3), false(NV_3), succ_atom(Y,NV_3), not _t_0(X).
t_3(X,NV_0,Y) | t_0(NV_0):- not okc, succ_atom(Y,NV_3), posc(NV_0,NV_3), not _true(NV_3), not _t_0(X).
t_3(X,NV_0,Y) | t_0(NV_0):- not okc, succ_atom(Y,NV_3), negc(NV_0,NV_3), not _false(NV_3), not _t_0(X).
t_3(X,NV_0,Y):- not t_0(NV_0), not okc, succ_atom(Y,NV_3), not succ_conj(X,NV_0), posc(NV_0,NV_3), not _true(NV_3).
t_3(X,NV_0,Y):- not t_0(NV_0), not okc, succ_atom(Y,NV_3), not succ_conj(X,NV_0), negc(NV_0,NV_3), not _false(NV_3).
t_3(X,NV_0,Y):- succ_atom(Y,NV_3), not succ_conj(X,NV_0), not _t_0(X).
t_3(X,NV_0,Y):- t_3(X,NV_0,NV_3), succ_atom(Y,NV_3).
:- not succ_conj(X,NV_0), not t_3(X,NV_0,Y), succ_atom(Y,NV_3).
:- not t_0(NV_0), not okc, not t_3(X,NV_0,Y), succ_atom(Y,NV_3), posc(NV_0,NV_3), not _true(NV_3).
:- not t_0(NV_0), not okc, not t_3(X,NV_0,Y), succ_atom(Y,NV_3), negc(NV_0,NV_3), not _false(NV_3).
:- not t_3(X,NV_0,Y), succ_atom(Y,NV_3), not _t_0(X).
:- not t_3(X,NV_0,Y), succ_atom(Y,NV_3), not _t_3(X,NV_0,NV_3).
:- not s_4(X2,MIN_atom).
s_4(X2,Y):- succ_atom(Y,NV_4), s_4(X2,NV_4).
s_4(X2,Y):- not true(Y), posd(X2,Y).
s_4(X2,Y):- not false(Y), negd(X2,Y).
s_4(X2,Y):- not _okd.
s_4(X2,Y):- not true(Y), posd(X2,Y), not _okd.
s_4(X2,Y):- not true(Y), posd(X2,Y), not _okd.
s_4(X2,Y):- not false(Y), negd(X2,Y), not _okd.
s_4(X2,Y):- not false(Y), negd(X2,Y), not _okd.
okd | t_4(X2,MIN_atom):- not negd(X2,MIN_atom), not posd(X2,MIN_atom).
okd | t_4(X2,MIN_atom):- false(MIN_atom), not posd(X2,MIN_atom).
okd | t_4(X2,MIN_atom):- not posd(X2,MIN_atom), not negd(X2,MIN_atom), not _false(MIN_atom).
okd | t_4(X2,MIN_atom):- not negd(X2,MIN_atom), true(MIN_atom).
okd | t_4(X2,MIN_atom):- false(MIN_atom), true(MIN_atom).
okd | t_4(X2,MIN_atom):- true(MIN_atom), not negd(X2,MIN_atom), not _false(MIN_atom).
okd | t_4(X2,MIN_atom):- not negd(X2,MIN_atom), not posd(X2,MIN_atom), not _true(MIN_atom).
okd | t_4(X2,MIN_atom):- false(MIN_atom), not posd(X2,MIN_atom), not _true(MIN_atom).
okd | t_4(X2,MIN_atom):- not negd(X2,MIN_atom), not _false(MIN_atom), not posd(X2,MIN_atom), not _true(MIN_atom).
t_4(X2,MIN_atom):- not negd(X2,MIN_atom), not posd(X2,MIN_atom), not okd.
t_4(X2,MIN_atom):- not posd(X2,MIN_atom), not okd, not _false(MIN_atom).
t_4(X2,MIN_atom):- not negd(X2,MIN_atom), not okd, not _true(MIN_atom).
t_4(X2,MIN_atom):- not okd, not _false(MIN_atom), not _true(MIN_atom).
okd:- not negd(X2,Y), t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y).
okd:- false(Y), t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y).
okd:- t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y), not negd(X2,Y), not _false(Y).
okd:- not negd(X2,Y), t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), true(Y).
okd:- false(Y), t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), true(Y).
okd:- t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), true(Y), not negd(X2,Y), not _false(Y).
okd:- not negd(X2,Y), t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y), not _true(Y).
okd:- false(Y), t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y), not _true(Y).
okd:- t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not negd(X2,Y), not _false(Y), not posd(X2,Y), not _true(Y).
:- not negd(X2,Y), not posd(X2,Y), not okd, t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y).
:- not posd(X2,Y), not okd, t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not _false(Y).
:- not negd(X2,Y), not okd, t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not _true(Y).
:- not okd, t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not _false(Y), not _true(Y).
:- not negd(X2,Y), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y), not okd, not _t_4(X2,MAX_atom).
:- not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not posd(X2,Y), not okd, not _false(Y), not _t_4(X2,MAX_atom).
:- not negd(X2,Y), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not okd, not _true(Y), not _t_4(X2,MAX_atom).
:- not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not okd, not _false(Y), not _true(Y), not _t_4(X2,MAX_atom).
okd:- not negd(X2,Y), t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not posd(X2,Y).
okd:- false(Y), t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not posd(X2,Y).
okd:- t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not posd(X2,Y), not negd(X2,Y), not _false(Y).
okd:- not negd(X2,Y), t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), true(Y).
okd:- false(Y), t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), true(Y).
okd:- t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), true(Y), not negd(X2,Y), not _false(Y).
okd:- not negd(X2,Y), t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not posd(X2,Y), not _true(Y).
okd:- false(Y), t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not posd(X2,Y), not _true(Y).
okd:- t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not negd(X2,Y), not _false(Y), not posd(X2,Y), not _true(Y).
:- not negd(X2,Y), not posd(X2,Y), not okd, t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y).
:- not posd(X2,Y), not okd, t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not _false(Y).
:- not negd(X2,Y), not okd, t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not _true(Y).
:- not okd, t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not _false(Y), not _true(Y).
:- not negd(X2,Y), max_atom(Y), s_4(X2,Y), not posd(X2,Y), not okd, not _t_4(X2,MAX_atom).
:- max_atom(Y), s_4(X2,Y), not posd(X2,Y), not okd, not _false(Y), not _t_4(X2,MAX_atom).
:- not negd(X2,Y), max_atom(Y), s_4(X2,Y), not okd, not _true(Y), not _t_4(X2,MAX_atom).
:- max_atom(Y), s_4(X2,Y), not okd, not _false(Y), not _true(Y), not _t_4(X2,MAX_atom).
t_4(X2,MAX_atom):- not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not true(Y), posd(X2,Y).
t_4(X2,MAX_atom):- not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not false(Y), negd(X2,Y).
t_4(X2,MAX_atom):- okd, not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y).
true(Y) | t_4(X2,MAX_atom):- posd(X2,Y), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not _okd.
t_4(X2,MAX_atom):- not true(Y), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), posd(X2,Y), not _okd.
false(Y) | t_4(X2,MAX_atom):- negd(X2,Y), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not _okd.
t_4(X2,MAX_atom):- not false(Y), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), negd(X2,Y), not _okd.
:- not true(Y), not t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), posd(X2,Y).
:- not false(Y), not t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), negd(X2,Y).
:- not t_4(X2,MAX_atom), not s_4(X2,NV_4), succ_atom(Y,NV_4), s_4(X2,Y), not _okd.
t_4(X2,MAX_atom):- max_atom(Y), s_4(X2,Y), not true(Y), posd(X2,Y).
t_4(X2,MAX_atom):- max_atom(Y), s_4(X2,Y), not false(Y), negd(X2,Y).
t_4(X2,MAX_atom):- okd, max_atom(Y), s_4(X2,Y).
true(Y) | t_4(X2,MAX_atom):- posd(X2,Y), max_atom(Y), s_4(X2,Y), not _okd.
t_4(X2,MAX_atom):- not true(Y), max_atom(Y), s_4(X2,Y), posd(X2,Y), not _okd.
false(Y) | t_4(X2,MAX_atom):- negd(X2,Y), max_atom(Y), s_4(X2,Y), not _okd.
t_4(X2,MAX_atom):- not false(Y), max_atom(Y), s_4(X2,Y), negd(X2,Y), not _okd.
:- not true(Y), not t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), posd(X2,Y).
:- not false(Y), not t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), negd(X2,Y).
:- not t_4(X2,MAX_atom), max_atom(Y), s_4(X2,Y), not _okd.
okd | t_4(X2,NV_4):- not negd(X2,NV_4), t_4(X2,Y), succ_atom(Y,NV_4), not posd(X2,NV_4).
okd | t_4(X2,NV_4):- false(NV_4), t_4(X2,Y), succ_atom(Y,NV_4), not posd(X2,NV_4).
okd | t_4(X2,NV_4):- t_4(X2,Y), succ_atom(Y,NV_4), not posd(X2,NV_4), not negd(X2,NV_4), not _false(NV_4).
okd | t_4(X2,NV_4):- not negd(X2,NV_4), t_4(X2,Y), succ_atom(Y,NV_4), true(NV_4).
okd | t_4(X2,NV_4):- false(NV_4), t_4(X2,Y), succ_atom(Y,NV_4), true(NV_4).
okd | t_4(X2,NV_4):- t_4(X2,Y), succ_atom(Y,NV_4), true(NV_4), not negd(X2,NV_4), not _false(NV_4).
okd | t_4(X2,NV_4):- not negd(X2,NV_4), t_4(X2,Y), succ_atom(Y,NV_4), not posd(X2,NV_4), not _true(NV_4).
okd | t_4(X2,NV_4):- false(NV_4), t_4(X2,Y), succ_atom(Y,NV_4), not posd(X2,NV_4), not _true(NV_4).
okd | t_4(X2,NV_4):- t_4(X2,Y), succ_atom(Y,NV_4), not negd(X2,NV_4), not _false(NV_4), not posd(X2,NV_4), not _true(NV_4).
t_4(X2,NV_4):- not negd(X2,NV_4), not posd(X2,NV_4), not okd, t_4(X2,Y), succ_atom(Y,NV_4).
t_4(X2,NV_4):- not posd(X2,NV_4), not okd, t_4(X2,Y), succ_atom(Y,NV_4), not _false(NV_4).
t_4(X2,NV_4):- not negd(X2,NV_4), not okd, t_4(X2,Y), succ_atom(Y,NV_4), not _true(NV_4).
t_4(X2,NV_4):- not okd, t_4(X2,Y), succ_atom(Y,NV_4), not _false(NV_4), not _true(NV_4).
:- not negd(X2,NV_4), succ_atom(Y,NV_4), not posd(X2,NV_4), not okd, not t_4(X2,NV_4), not _t_4(X2,Y).
:- succ_atom(Y,NV_4), not posd(X2,NV_4), not okd, not t_4(X2,NV_4), not _false(NV_4), not _t_4(X2,Y).
:- not negd(X2,NV_4), succ_atom(Y,NV_4), not t_4(X2,NV_4), not okd, not _true(NV_4), not _t_4(X2,Y).
:- succ_atom(Y,NV_4), not t_4(X2,NV_4), not okd, not _false(NV_4), not _true(NV_4), not _t_4(X2,Y).
t_4(X2,Y):- succ_atom(Y,NV_4), not true(NV_4), posd(X2,NV_4).
t_4(X2,Y):- succ_atom(Y,NV_4), not false(NV_4), negd(X2,NV_4).
t_4(X2,Y):- okd, succ_atom(Y,NV_4).
true(NV_4) | t_4(X2,Y):- posd(X2,NV_4), succ_atom(Y,NV_4), not _okd.
t_4(X2,Y):- not true(NV_4), succ_atom(Y,NV_4), posd(X2,NV_4), not _okd.
false(NV_4) | t_4(X2,Y):- negd(X2,NV_4), succ_atom(Y,NV_4), not _okd.
t_4(X2,Y):- not false(NV_4), succ_atom(Y,NV_4), negd(X2,NV_4), not _okd.
t_4(X2,Y):- t_4(X2,NV_4), succ_atom(Y,NV_4).
:- not true(NV_4), not t_4(X2,Y), succ_atom(Y,NV_4), posd(X2,NV_4).
:- not false(NV_4), not t_4(X2,Y), succ_atom(Y,NV_4), negd(X2,NV_4).
:- not t_4(X2,Y), succ_atom(Y,NV_4), not _okd.
:- not t_4(X2,Y), succ_atom(Y,NV_4), not _t_4(X2,NV_4).
true(Y):- ok, un(Y).
false(Y):- ok, un(Y).
ok:- okc, okd.
:- not ok.
