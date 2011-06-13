% initialize environment
clear all;
close all;
%
% set graph construction flags and construct graph
flag.type      = 'directed'; 
flag.nodepos   = {'grid',0};
flag.Econstr   = {'nearest',5};
flag.cconstr   = 'euclidean';
flag.Efilter   = {'parallel','selfloop'};
flag.Gmanip    = {'decross'};
[E,n,c,P,flag] = GrCstrR01(100,flag);
%
% visualize graph
ptrG = PatchGraph(E,n,P,...
    'directed',...
    'archdstat',1,...
    'edgename','directed graph'); 
set(ptrG.V,'markersize',6);
%
% solve the SSSP-problem, compute shortest path tree
[Adj,g]        = AdjList(E,n,c,'directed');
s              = 37;
t              = [];
[d,p,T,report] = SSSPBellFord(Adj,g,s);
%[d,p,T] = SSSP_BF(Adj,g,s);
%
% visualize shortest path tree
ptrT = PatchGraph(T,n,P,...
    'directed',...
    'archdstat',1,...
    'nodenum',s,...
    'edgecolor','r',...
    'edgename','shortest path tree',...
    'toax',gca); 
set(ptrT.V,'markersize',6);
%
% activate plot browser
viewmenufcn(ptrG.fig,'PlotBrowser');
