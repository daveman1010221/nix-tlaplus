---- MODULE Counter ----
EXTENDS Naturals

CONSTANT Max

VARIABLE n

Init == n = 0

Next == n < Max /\ n' = n + 1

Done == n = Max /\ UNCHANGED n

Spec == Init /\ [][Next \/ Done]_n

FairSpec == Spec /\ WF_n(Next)

Bounded == n <= Max

TooSmall == n < Max

Reaches == <>(n = Max)
====
