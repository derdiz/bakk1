function [H,HLin] = TSP(E,n,c)

[F,cF] = SpnTr(E,n,c); % Calculate Euclidean costs when computing the MST

F = [F,F];

HLin = F;

[I,g] = NetInc(E,n,c);

[C,CLin] = Euler(I,g);

H = 0;

i = 0;

while i < length(C)
    H = [H(i),C(i)];
    i = i + 1;
end;

H = [H,C(1)];
