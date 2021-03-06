clear all;
close all;
%
% Read and visualize instance
% ---------------------------
[E,n,P,c,r,Pi]          = RdInst('G03.ist');
c                       = zeros(1,length(E));
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'directed','GrColr','k','NdNum',1:n,'ETxt','min.capacity',c);
% Min. Capacity: see second for loop (c(k)=...))
set(NHdl(1),'markerfacecolor','r');
for v = 1:n,
    set(NTHdl(v),'string',int2str(Pi(v))); % "...each node has a demand of Pi(v)"
end;
%
% DFS with root r = 1
% -------------------
[d,p,f] = DFS(E,n,1); % my DFS routine
%
% compute minimum capacity of edges
% ---------------------------------
for k = 1:length(E),
    e = E(k); % go through the edge array
    w = mod(e,n);
    if w==0
        w = n;
    end;
    u = (e-w)/n+1;
    v = find(d(u) < d & f < f(u)); 
    c(k) = Pi(u)+ sum(Pi(v)); % Min. capacity
    set(ETHdl(k),'string',int2str(c(k))); % inscribing min. capacity as edge text
end;
