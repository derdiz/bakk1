clear all;
close all;
%
% Generate problem instance for metric TSP
[E,n,c,P] = GRand(10,1,[],'noise',0.2,'euclidean'); 
%
% Compute near optimal solution
% [H,HLin] = TspMst(E,n,c);
[H,HLin] = TSP(E,n,c);
%
% Visualize solution
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P); 
set(EHdl,'visible','off'); 
set(EHdl(ismember(E,HLin)),'visible','on');