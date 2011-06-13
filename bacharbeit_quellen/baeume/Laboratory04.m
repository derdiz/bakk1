clear all;
close all;
%
% Generate problem instance
[E,n,c,P] = GRand(20,1,[],'noise',0.2,'euclidean'); 
r         = 1;
%
% Check existence of a spanning rooted tree
[I,g] = NetInc(E,n,c,'directed');
[d,p,f] = FstSearch(I,n,r,'directed');
if any(isinf(d)),
    disp('Notice: current graph does not contain a rooted spanning tree');
    disp('        Trying to find a minimum spanning branching instead!')
else
    disp('Notice: current graph contains a rooted spanning tree');
end;   
%
% Compute minimum spanning branching
F = MxBr(I,g,'MinRtArb',r,max(c));
%
% Visualize solution
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'directed','NdNum',1:n); 
set(EHdl,'visible','off');
set(EHdl(ismember(E,F)),'visible','on');

