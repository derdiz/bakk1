clear all;
close all;
%
% Read and visualize instance
% ---------------------------
[E,n,P,c]          = RdInst('G02.ist');

[d,f,p] = DFS(E,n,1);

for k = 1:length(E),
    u = mod(E(k),n); if u==0, u = n; end;
    v = (E(k)-u)/n+1;
    %
    % <u,v> is a tree arc (v is white)
    if p(v)==u,
        arc='tree';
    %
    % <u,v> is a back arc if u is a descendant of v or u==v (v is gray)
    elseif (u==v)||(d(u)>d(v)&&f(u)<f(v)),
        arc='back';
    %
    % <u,v> is a forward arc p(v)~=u and v is a descendant of u (v is black and d(u) < d(v))
    elseif (p(v)~=u)&&(d(v)>d(u)&&f(v)<f(u)),
        arc='forward';
    %
    % otherwise <u,v> has to be a cross arc (v is black and d(u) > d(v) - v not descended from u)
    else
        arc='cross';
    end;
    arc
end;