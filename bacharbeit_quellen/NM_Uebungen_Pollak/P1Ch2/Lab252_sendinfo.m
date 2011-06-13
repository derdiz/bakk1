clear all;
close all;
%
% Read and visualize instance
% ---------------------------
[E,n,P,c]               = RdInst('G02.ist');
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'directed','GrColr','k');
%
% DFS - compute discovery- and finishing time
% -------------------------------------------
nrR = 0;
r   = [];
d   = []; % discovery time
p   = []; % predecessor
f   = []; % finishing time
for tr = 1:n,
    [td,tp,tf] = DFS(E,n,tr); % my DFS routine
    if length(find(td~=0))>nrR,
        r   = tr;
        d   = td;
        p   = tp;
        f   = tf;
        nrR = length(find(td~=0));
    end;
end;
%
% show depth first search forest
% ------------------------------
set(NHdl(r),'markerfacecolor','r'); % setze Knotenfarbe auf rot
for v = 1:n
    u = p(v); % gehe Vorgängerarray durch
    if u~=0, % wenn ohne Vorgänger
        set(NHdl(v),'color','r'); % setze Knotenfarbe auf rot
        set(EHdl(E==(v-1)*n+u),'color','r'); % setze Kantenfarbe auf rot
    end;
end;
