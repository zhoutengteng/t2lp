%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k: num of clauses of the CNF
% n: num of variables

%posc(1,1). posc(2,2). negc(2,2).
%posd(1,2). negd(2,2).

atom(1..n).
un(m..n).
conj(1..k).
disj(1..l).

true (X) :- not false(X), atom(X), not un(X).
false(X) :- not true (X), atom(X), not un(X).
 :- true (X), false(X), atom(X), not un(X).

true (X) | false(X) :- un(X).
true (X) :- un(X), ok.
false(X) :- un(X), ok.
ok :- okc, okd.
 :- not ok.

 :- not tc(X), conj(X).
 :- not tg(X), atom(X).
 :- not tl(X,Y), conj(X), atom(Y).
 :- not td(X,Y), disj(X), atom(Y).


%thetac(X) = [!Y] ( ((posc(X,Y) & true (Y)) | (negc(X,Y) & false(Y))) -> okc )

%tc(k) -> thetac(1)

okc :- tc(k), posc(1,Y), true (Y).
okc :- tc(k), negc(1,Y), false(Y).

%thetac(1) -> tc(k)

%gamma(Y) = ( ((posc(1,Y) & true (Y)) | (negc(1,Y) & false(Y))) -> okc ) -> tc(k)

%tg(n) -> gamma(1)

tc(k) :- tg(n), okc.
tc(k) :- tg(n), not posc(1,1), not negc(1,1).
tc(k) | false(1) :- tg(n), not posc(1,1).
tc(k) | true (1) :- tg(n), not negc(1,1).
%tc(k) | false(1) | true (1) :- tg(n).

%gamma(1) -> tg(n)

tg(n) :- tc(k).
tg(n) | okc :- posc(1,1), true (1).
tg(n) | okc :- negc(1,1), false(1).

%tg(Y) & succ(Y,Z)-> tg(Z) | gamma(Z)

tg(Z) | tc(k) :- tg(Y), okc, atom(Z), Z=Y+1.
tg(Z) | tc(k) :- tg(Y), not posc(1,Z), not negc(1,Z), atom(Z), Z=Y+1.
tg(Z) | tc(k) | false(Z) :- tg(Y), not posc(1,Z), atom(Z), Z=Y+1.
tg(Z) | tc(k) | true (Z) :- tg(Y), not negc(1,Z), atom(Z), Z=Y+1.
%tg(Z) | tc(k) | false(Z) | true(Z) :- tg(Y), atom(Z), Z=Y+1.

%gamma(Z) & succ(Y,Z) -> tg(Y)

tg(Y) :- tc(k), atom(Y), atom(Z), Z=Y+1.
tg(Y) | okc :- posc(1,Z), true (Z), atom(Y), Z=Y+1.
tg(Y) | okc :- negc(1,Z), false(Z), atom(Y), Z=Y+1.

%tg(Z) & succ(Y,Z) -> tg(Y)

tg(Y) :- tg(Z), atom(Y), Z=Y+1.

%tg(1) | gamma(1)

tg(1) | tc(k) :- okc.
tg(1) | tc(k) :- not posc(1,1), not negc(1,1).
tg(1) | tc(k) | false(1) :- not posc(1,1).
tg(1) | tc(k) | true (1) :- not negc(1,1).
%tg(1) | tc(k) | false(1) | true(1) :- .

%%

%tc(X) & succ(X,Z) -> tc(Z) | thetac(Z)

tc(Z) | okc :- tc(X), posc(Z,Y), true (Y), Z=X+1.
tc(Z) | okc :- tc(X), negc(Z,Y), false(Y), Z=X+1.

%thetac(X+1) & conj(X) -> tc(X)

%lambda(X,Y) = ( ((posc(X+1,Y) & true (Y)) | (negc(X+1,Y) & false(Y))) -> okc ) & conj(X) -> tc(X)

%tl(X,n) <-> tc(k)

tl(X,n) :- tc(k), conj(X).
tc(k) :- tl(_,n).

%tl(X,Y) & succ(Y,Z) -> tl(X,Z) | lambda(X,Z)

tl(X,Z) | tc(X) :- tl(X,Y), okc, conj(X), atom(Z), Z=Y+1.
tl(X,Z) | tc(X) :- tl(X,Y), conj(X), not posc(U,Z), not negc(U,Z), conj(U), atom(Z), U=X+1, Z=Y+1.
tl(X,Z) | tc(X) | false(Z) :- tl(X,Y), conj(X), not posc(U,Z), conj(U), atom(Z), U=X+1, Z=Y+1.
tl(X,Z) | tc(X) | true (Z) :- tl(X,Y), conj(X), not negc(U,Z), conj(U), atom(Z), U=X+1, Z=Y+1.
%tl(X,Z) | tc(X) | false(Z) | true (Z) :- tl(X,Y), conj(X), atom(Z), Z=Y+1.

%lambda(X,Z) & succ(Y,Z) -> tl(X,Y)

tl(X,Y) :- tc(X), atom(Y), atom(Z), Z=Y+1.
tl(X,Y) | okc :- posc(U,Z), true (Z), atom(Y), conj(X), U=X+1, Z=Y+1.
tl(X,Y) | okc :- negc(U,Z), false(Z), atom(Y), conj(X), U=X+1, Z=Y+1.

%tl(X,Z) & succ(Y,Z) -> tl(X,Y)

tl(X,Y) :- tl(X,Z), atom(Y), Z=Y+1.

%tl(X,1) | lambda(X,1)

tl(X,1) | tc(X) :- okc, conj(X).
tl(X,1) | tc(X) :- conj(X), not posc(U,1), not negc(U,1), conj(U), U=X+1.
tl(X,1) | tc(X) | false(1) :- not posc(U,1), conj(X), conj(U), U=X+1.
tl(X,1) | tc(X) | true (1) :- not negc(U,1), conj(X), conj(U), U=X+1.
%tl(X,1) | tc(X) | false(1) | true (1) :- conj(X).

%%

%succ(X,Z) & tc(Z) -> tc(X)

tc(X) :- tc(Z), conj(X), Z=X+1.

%tc(1) | thetac(1)

tc(1) | okc :- posc(1,Y), true (Y).
tc(1) | okc :- negc(1,Y), false(Y).

%thetad(X,Y) = (posd(X,Y)->true (Y)) & (negd(X,Y)->false(Y)) -> okd

%td(X,n) -> thetad(X,1)

okd :- td(X,n), not posd(X,1), not negd(X,1).
okd :- td(X,n), false(1), not posd(X,1).
okd :- td(X,n), true (1), not negd(X,1).
okd :- td(X,n), false(1), true (1), un(1).

%thetad(X,1) -> td(X,n)

td(X,n) :- okd, disj(X).
td(X,n) | true (1) :- posd(X,1).
td(X,n) | false(1) :- negd(X,1).

%td(X,Y) & succ(Y,Z) -> td(X,Z) | thetad(X,Z)

td(X,Z) | okd :- td(X,Y), not posd(X,Z), not negd(X,Z), atom(Z), Z=Y+1.
td(X,Z) | okd :- td(X,Y), false(Z), not posd(X,Z), atom(Z), Z=Y+1.
td(X,Z) | okd :- td(X,Y), true (Z), not negd(X,Z), atom(Z), Z=Y+1.
td(X,Z) | okd :- td(X,Y), false(Z), true (Z), un(Z), Z=Y+1.

%thetad(X,Z) & succ(Y,Z) -> td(X,Y)

td(X,Y) :- okd, disj(X), atom(Y), atom(Z), Z=Y+1.
td(X,Y) | true (Z) :-  posd(X,Z), atom(Y), Z=Y+1.
td(X,Y) | false(Z) :-  negd(X,Z), atom(Y), Z=Y+1.

%td(X,Z) & succ(Y,Z) -> td(X,Y)

td(X,Y) :- td(X,Z), atom(Y), Z=Y+1.

%td(X,1) | thetad(X,1)

td(X,1) | okd :- not posd(X,1), not negd(X,1), disj(X).
td(X,1) | okd :- false(1), not posd(X,1), disj(X).
td(X,1) | okd :- true (1), not negd(X,1), disj(X).
td(X,1) | okd :- false(1), true (1), disj(X), un(1).
