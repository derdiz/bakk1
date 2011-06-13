clear all;
close all;

% Read and plot network 'G02'
[E,n,P,c]               = RdInst('G02.ist');
[EHdl,NHdl] = PlotGraph(E,n,P,'directed','GrColr',[0.7,0.7,0.7]);

% Perform DFS on that network
[d,p,f] = FstSearch(E,n,[],'depth','directed');

% Compute inverse graph
u       = mod(E,n); 
u(u==0) = n; % Inverted root is at end of traversal
v       = (E-u)/n+1; % Nodes on inverted graph
E       = (u-1)*n+v; % Edges om inverted graph

% Sort, flip (because of inversion) and perform DFS (n:1 - another reason 
% to flip) on network
[f,r]   = sort(f);
r       = fliplr(r);
[d,p,f] = FstSearch(E,n,r,'depth','directed');

% Initialisations for getting strong connectivity components
r = find(p==0); % Array indexes where p==0
C = cell(1,length(r)); % A cell array is an array of matrices, not values
V = 1:n; % Nodes

% Get strong connectivity components
for k = 1:length(r)
    C{k} = r(k);
    Q    = r(k);
    while ~isempty(Q)
        h    = Q(1);
        Q    = Q(2:end);
        w    = V(p==h);
        C{k} = [C{k},w];
        Q    = [Q,w];
    end;
    if length(C{k})>1
        for j = 1:length(u)
            if any(C{k}==u(j))&&any(C{k}==v(j))
                set(EHdl(j),'color','k','linewidth',2);
            end;
        end;
    end;
end;
