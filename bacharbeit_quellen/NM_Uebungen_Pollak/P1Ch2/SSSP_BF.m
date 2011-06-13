function [d,p,T] = SSSP_BF(Adj,g,s)

% Algorithm1:SSSPInit (Skript S.44)

n = length(Adj);
d = inf(1,n);
p = zeros(1,n);

d(s) = 0;

u = E(1,1);

v= E(1,length(E));

for i = length(Adj)
    if v ~= s
        for i=1:length(Adj)
        if d(v) >= d(u) + c(E(i))
            d(v) = d(u) + c(E(i));
            p(v) = u;
        end;
    end;
    end;
end;
