close all, clear all;

nodes=10;
percEdges=1; % 100% of edges randomly laid
costRange=[10 100]; % Range of cost entries, gen. randomly betw. 0-20

[E,n,c,P] = GRand(nodes,percEdges,costRange,'noise',0.2,'euler','directed'); % 10-node graph constructed
[I,g] = NetInc(E,n,c,'directed'); % Get incidence information (where the edges go)
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'NdNum',1:n,'directed','ETxt','Euler walk',zeros(size(E))); % walk along n arcs, text: elements of E
set(EHdl,'linestyle',':'); % at first, arcs look like this: ---
set(ETHdl,'visible','off');

% Compute Euler cycle (it is not enough just to switch on option 'euler' when creating the graph)
[C,CLin] = Euler(I,g);
% [C,CLin] = myEuler(I,g);

% show Euler walk
eIter = E; % CLin is fixed - need extra var. to manipulate

for i = 1:length(CLin) % walk along every arc...
 j = find(eIter == CLin(i)); % ...but where are they?
 j=j(1); % start here
 eIter(j) = inf; % no self-loops - infinite path
 set(ETHdl(j),'string',int2str(i),'fontweight','bold','visible','on'); % as the walk progresses, successively embolden (and 'inscribe') 'done' arcs
 set(EHdl(j),'linewidth',2,'linestyle','-');
 pause(0.5);
end;
