clear all;
close all;
%
% Create and visualize instances
% ------------------------------
[E,n,c,P] = GRand(10,0.2,[0 10]);
[Ed,nd,cd,Pd] = GRand(10,0.8,[0 10]);

[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'GrColr','k');
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(Ed,nd,Pd,'GrColr','k');
%
set(NHdl,'markersize',8);

%
% Kruskal-Methode
% k_tictoc_sparse = tic, SpnTr(E,n,d), toc; % Calculate Euclidean costs
 k_tictoc_sparse = tic, MSFKruskal(E,n,c), toc
% k_tictoc_dense = tic, SpnTr(E,n,c), toc; % Calculate 'normal' costs
 k_tictoc_dense = tic, MSFKruskal(Ed,nd,cd), toc

%Prim-Methode
m_tictoc_sparse = tic, [F3,cF3] = SpnTr(E,n,d,'Prim'), toc
m_tictoc_dense = tic, SpnTr(Ed,nd,cd,'Prim'), toc;
