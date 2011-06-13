function [d,p,T] = SSSP(Adj,g,s,t)

% Algorithm1:SSSPInit (Skript S.44)

n = length(Adj);
d = inf(1,n);
p = zeros(1,n);

d(s) = 0;

% Ende Algorithm 1

%Algorithm3 - SSSPDijkstra



W=Adj;

v = (d(W))==d(W);

while ~isempty(W)
    u = W(min(v));
    W = W - u;
    % Algorithm2 - CHECK
    for i=1:length(Adj)
        if d(v) >= d(u) + c(E(i))
            d(v) = d(u) + c(E(i));
            p(v) = u;
        end;
    end;
end;
