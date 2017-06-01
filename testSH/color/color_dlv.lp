%#maxint=20.
%#const n=3.

%vtx(1..n).

%edge(1,2). edge(2,1).
%edge(1,3). edge(3,1).


clr(X) | ncl(X) :- vtx(X).
%ncl(X) :- not clr(X), vtx(X).
vse(X) | nvs(X) :- vtx(X).
vse(X) :- ok, vtx(X).
nvs(X) :- ok, vtx(X).
ok :- vse(X), vse(Y), X!=Y, not edge(X,Y).
ok :- vse(X), vse(Y), clr(X), ncl(Y).
 :- clr(X), ncl(X), vtx(X).
 :- not ok.

%t(X,n) -> theta(X,1)

ok :- t(X,n), nvs(X), nvs(1).
ok :- t(X,n), nvs(X), edge(X,1).

%theta(X,1) -> t(X,n)

t(X,n) :- ok, vtx(X).
t(X,n) | nvs(X) :- vtx(X).
%t(X,n) :- vse(1), not edge(X,1), vtx(X).
t(X,n) | nvs(1) :- not edge(X,1), vtx(X).

%t(X,Y) & #succ(Y,Z) -> t(X,Z) | theta(X,Z)

t(X,Z) | ok :- t(X,Y), nvs(X), nvs(Z), vtx(Z), #succ(Y,Z).
t(X,Z) | ok :- t(X,Y), nvs(X), edge(X,Z), vtx(Z), #succ(Y,Z).

%theta(X,Z) & #succ(Y,Z) -> t(X,Y)

t(X,Y) :- ok, vtx(X), vtx(Y), vtx(Z), #succ(Y,Z).
t(X,Y) | nvs(X) :- vtx(X), vtx(Y), vtx(Z), #succ(Y,Z).
%t(X,Y) :- vse(Z), not edge(X,Z), vtx(X), vtx(Y), vtx(Z), #succ(Y,Z).
t(X,Y) | nvs(Z) :- not edge(X,Z), vtx(X), vtx(Y), vtx(Z), #succ(Y,Z).

%t(X,Z) & #succ(Y,Z) -> t(X,Y)

t(X,Y) :- t(X,Z), vtx(Y), #succ(Y,Z).

%t(X,1) | theta(X,1)

t(X,1) | ok :- nvs(X), nvs(1).
t(X,1) | ok :- nvs(X), edge(X,1).

 :- not t(X,Y), vtx(X), vtx(Y).
