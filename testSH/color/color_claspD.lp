%MIN and MAX domain
#domain min_vtx(MIN_vtx).
#domain max_vtx(MAX_vtx).

%Variable domain
#domain vtx(X).
#domain vtx(Y).
#domain vtx(NV_0).
#domain vtx(NV_1).
#domain vtx(NV_2).

%Nega nega predicate define
_ok:- not ok.
_set_(X):- not set_(X).
_t_0(X,Y):- not t_0(X,Y).
_t_1(X,Y):- not t_1(X,Y).

%Extension predicate define
_eq(X,Y):- not eq(X,Y).
_edge(X,Y):- not edge(X,Y).
_succ_vtx_vtx(X,Y,NV_0,NV_1):- not succ_vtx_vtx(X,Y,NV_0,NV_1).
_max_vtx(X):- not max_vtx(X).
_succ_vtx(Y,NV_2):- not succ_vtx(Y,NV_2).

%Succ predicate definition
succ_vtx_vtx(A,B1,A,B2):- succ_vtx(B1,B2), vtx(A), vtx(B1), vtx(B2).
succ_vtx_vtx(A1,MAX_vtx,A2,MIN_vtx):- succ_vtx(A1,A2), vtx(A1), vtx(A2).
succ_vtx(A1,A2):- A1==A2-1, vtx(A1), vtx(A2).
eq(X,Y) :- X = Y.

color(X) | color_(X).
set(X) | set_(X).
:- not s_0(MIN_vtx,MIN_vtx).
s_0(X,Y):- succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(NV_0,NV_1).
s_0(X,Y):- not eq(X,Y), not set_(X), not set_(Y).
s_0(X,Y):- not _ok.
s_0(X,Y):- not set_(Y), not set_(X), not eq(X,Y), not _ok.
s_0(X,Y):- not eq(X,Y), not set_(X), not set_(Y), not _ok.
ok | t_0(MIN_vtx,MIN_vtx):- eq(MIN_vtx,MIN_vtx).
ok | t_0(MIN_vtx,MIN_vtx):- set_(MIN_vtx).
ok | t_0(MIN_vtx,MIN_vtx):- set_(MIN_vtx).
ok | t_0(MIN_vtx,MIN_vtx):- not _set_(MIN_vtx), eq(MIN_vtx,MIN_vtx).
ok | t_0(MIN_vtx,MIN_vtx):- not _set_(MIN_vtx), eq(MIN_vtx,MIN_vtx).
t_0(MIN_vtx,MIN_vtx):- not ok, eq(MIN_vtx,MIN_vtx).
t_0(MIN_vtx,MIN_vtx):- not ok, not _set_(MIN_vtx).
t_0(MIN_vtx,MIN_vtx):- not ok, not _set_(MIN_vtx).
ok:- t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), eq(X,Y).
ok:- set_(X), t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y).
ok:- set_(Y), t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y).
ok:- t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), eq(X,Y), not _set_(X).
ok:- t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), eq(X,Y), not _set_(Y).
:- not ok, t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), eq(X,Y).
:- not ok, t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not _set_(X).
:- not ok, t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not _set_(Y).
:- not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not ok, eq(X,Y), not _t_0(MAX_vtx,MAX_vtx).
:- not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not ok, not _set_(X), not _t_0(MAX_vtx,MAX_vtx).
:- not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not ok, not _set_(Y), not _t_0(MAX_vtx,MAX_vtx).
ok:- t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), eq(X,Y).
ok:- set_(X), t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y).
ok:- set_(Y), t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y).
ok:- t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), eq(X,Y), not _set_(X).
ok:- t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), eq(X,Y), not _set_(Y).
:- not ok, t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), eq(X,Y).
:- not ok, t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), not _set_(X).
:- not ok, t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), not _set_(Y).
:- max_vtx(X), max_vtx(Y), s_0(X,Y), not ok, eq(X,Y), not _t_0(MAX_vtx,MAX_vtx).
:- max_vtx(X), max_vtx(Y), s_0(X,Y), not ok, not _set_(X), not _t_0(MAX_vtx,MAX_vtx).
:- max_vtx(X), max_vtx(Y), s_0(X,Y), not ok, not _set_(Y), not _t_0(MAX_vtx,MAX_vtx).
t_0(MAX_vtx,MAX_vtx):- not eq(X,Y), not set_(X), not set_(Y), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y).
t_0(MAX_vtx,MAX_vtx):- ok, not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y).
set_(X) | set_(Y) | t_0(MAX_vtx,MAX_vtx):- not eq(X,Y), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not _ok.
t_0(MAX_vtx,MAX_vtx):- not eq(X,Y), not set_(X), not set_(Y), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not _ok.
:- not set_(Y), not set_(X), not eq(X,Y), not t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y).
:- not t_0(MAX_vtx,MAX_vtx), not s_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), s_0(X,Y), not _ok.
t_0(MAX_vtx,MAX_vtx):- not eq(X,Y), not set_(X), not set_(Y), max_vtx(X), max_vtx(Y), s_0(X,Y).
t_0(MAX_vtx,MAX_vtx):- ok, max_vtx(X), max_vtx(Y), s_0(X,Y).
set_(X) | set_(Y) | t_0(MAX_vtx,MAX_vtx):- not eq(X,Y), max_vtx(X), max_vtx(Y), s_0(X,Y), not _ok.
t_0(MAX_vtx,MAX_vtx):- not eq(X,Y), not set_(X), not set_(Y), max_vtx(X), max_vtx(Y), s_0(X,Y), not _ok.
:- not set_(Y), not set_(X), not eq(X,Y), not t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y).
:- not t_0(MAX_vtx,MAX_vtx), max_vtx(X), max_vtx(Y), s_0(X,Y), not _ok.
ok | t_0(NV_0,NV_1):- t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), eq(NV_0,NV_1).
ok | t_0(NV_0,NV_1):- set_(NV_0), t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1).
ok | t_0(NV_0,NV_1):- set_(NV_1), t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1).
ok | t_0(NV_0,NV_1):- t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), eq(NV_0,NV_1), not _set_(NV_0).
ok | t_0(NV_0,NV_1):- t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), eq(NV_0,NV_1), not _set_(NV_1).
t_0(NV_0,NV_1):- not ok, t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), eq(NV_0,NV_1).
t_0(NV_0,NV_1):- not ok, t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), not _set_(NV_0).
t_0(NV_0,NV_1):- not ok, t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), not _set_(NV_1).
:- succ_vtx_vtx(X,Y,NV_0,NV_1), not ok, not t_0(NV_0,NV_1), eq(NV_0,NV_1), not _t_0(X,Y).
:- succ_vtx_vtx(X,Y,NV_0,NV_1), not ok, not t_0(NV_0,NV_1), not _set_(NV_0), not _t_0(X,Y).
:- succ_vtx_vtx(X,Y,NV_0,NV_1), not ok, not t_0(NV_0,NV_1), not _set_(NV_1), not _t_0(X,Y).
t_0(X,Y):- not eq(NV_0,NV_1), not set_(NV_0), not set_(NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1).
t_0(X,Y):- ok, succ_vtx_vtx(X,Y,NV_0,NV_1).
set_(NV_0) | set_(NV_1) | t_0(X,Y):- not eq(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), not _ok.
t_0(X,Y):- not eq(NV_0,NV_1), not set_(NV_0), not set_(NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1), not _ok.
t_0(X,Y):- t_0(NV_0,NV_1), succ_vtx_vtx(X,Y,NV_0,NV_1).
:- not set_(NV_1), not set_(NV_0), not eq(NV_0,NV_1), not t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1).
:- not t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), not _ok.
:- not t_0(X,Y), succ_vtx_vtx(X,Y,NV_0,NV_1), not _t_0(NV_0,NV_1).
ok:- set(X), set(Y), not eq(X,Y), not edge(X,Y).
:- not s_1(X,MIN_vtx).
s_1(X,Y):- succ_vtx(Y,NV_2), s_1(X,NV_2).
s_1(X,Y):- not set_(X).
s_1(X,Y):- not set_(Y), not edge(X,Y).
s_1(X,Y):- not _ok.
s_1(X,Y):- not set_(X), not _ok.
s_1(X,Y):- not set_(Y), not _ok, not edge(X,Y).
ok | t_1(X,MIN_vtx):- set_(X), set_(MIN_vtx).
ok | t_1(X,MIN_vtx):- set_(X), edge(X,MIN_vtx).
t_1(X,MIN_vtx):- not ok, not _set_(MIN_vtx), not _set_(X).
t_1(X,MIN_vtx):- not ok, edge(X,MIN_vtx), not _set_(X).
ok:- set_(Y), set_(X), t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
ok:- edge(X,Y), set_(X), t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
:- not ok, t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not _set_(X), not _set_(Y).
:- not ok, t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not _set_(X), edge(X,Y).
:- not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not ok, not _set_(Y), not _set_(X), not _t_1(X,MAX_vtx).
:- not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not ok, edge(X,Y), not _set_(X), not _t_1(X,MAX_vtx).
ok:- set_(Y), set_(X), t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y).
ok:- edge(X,Y), set_(X), t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y).
:- not ok, t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y), not _set_(X), not _set_(Y).
:- not ok, t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y), not _set_(X), edge(X,Y).
:- max_vtx(Y), s_1(X,Y), not ok, not _set_(Y), not _set_(X), not _t_1(X,MAX_vtx).
:- max_vtx(Y), s_1(X,Y), not ok, edge(X,Y), not _set_(X), not _t_1(X,MAX_vtx).
t_1(X,MAX_vtx):- not set_(X), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
t_1(X,MAX_vtx):- not set_(Y), not edge(X,Y), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
t_1(X,MAX_vtx):- ok, not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
set_(X) | t_1(X,MAX_vtx):- not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not _ok.
set_(Y) | t_1(X,MAX_vtx):- not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not edge(X,Y), not _ok.
:- not set_(X), not t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
:- not edge(X,Y), not set_(Y), not t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y).
:- not t_1(X,MAX_vtx), not s_1(X,NV_2), succ_vtx(Y,NV_2), s_1(X,Y), not _ok.
t_1(X,MAX_vtx):- not set_(X), max_vtx(Y), s_1(X,Y).
t_1(X,MAX_vtx):- not set_(Y), not edge(X,Y), max_vtx(Y), s_1(X,Y).
t_1(X,MAX_vtx):- ok, max_vtx(Y), s_1(X,Y).
set_(X) | t_1(X,MAX_vtx):- max_vtx(Y), s_1(X,Y), not _ok.
set_(Y) | t_1(X,MAX_vtx):- max_vtx(Y), s_1(X,Y), not edge(X,Y), not _ok.
:- not set_(X), not t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y).
:- not edge(X,Y), not set_(Y), not t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y).
:- not t_1(X,MAX_vtx), max_vtx(Y), s_1(X,Y), not _ok.
ok | t_1(X,NV_2):- set_(NV_2), set_(X), t_1(X,Y), succ_vtx(Y,NV_2).
ok | t_1(X,NV_2):- edge(X,NV_2), set_(X), t_1(X,Y), succ_vtx(Y,NV_2).
t_1(X,NV_2):- not ok, t_1(X,Y), succ_vtx(Y,NV_2), not _set_(X), not _set_(NV_2).
t_1(X,NV_2):- not ok, t_1(X,Y), succ_vtx(Y,NV_2), not _set_(X), edge(X,NV_2).
:- succ_vtx(Y,NV_2), not t_1(X,NV_2), not ok, not _set_(NV_2), not _set_(X), not _t_1(X,Y).
:- succ_vtx(Y,NV_2), not t_1(X,NV_2), not ok, edge(X,NV_2), not _set_(X), not _t_1(X,Y).
t_1(X,Y):- not set_(X), succ_vtx(Y,NV_2).
t_1(X,Y):- not set_(NV_2), not edge(X,NV_2), succ_vtx(Y,NV_2).
t_1(X,Y):- ok, succ_vtx(Y,NV_2).
set_(X) | t_1(X,Y):- succ_vtx(Y,NV_2), not _ok.
set_(NV_2) | t_1(X,Y):- succ_vtx(Y,NV_2), not edge(X,NV_2), not _ok.
t_1(X,Y):- t_1(X,NV_2), succ_vtx(Y,NV_2).
:- not set_(X), not t_1(X,Y), succ_vtx(Y,NV_2).
:- not edge(X,NV_2), not set_(NV_2), not t_1(X,Y), succ_vtx(Y,NV_2).
:- not t_1(X,Y), succ_vtx(Y,NV_2), not _ok.
:- not t_1(X,Y), succ_vtx(Y,NV_2), not _t_1(X,NV_2).
ok:- set(X), set(Y), color(X), color_(Y).
set(X):- ok.
set_(X):- ok.
:- not ok.
