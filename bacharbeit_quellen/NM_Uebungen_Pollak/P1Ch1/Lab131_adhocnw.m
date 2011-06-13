clear all, close all;

nodes=3;

[E,n,c,P]=GrCstrR01(nodes,[],'nodepos','randomized'); % 3-node graph constructed
% with output edges, number of nodes, costs and x,y positions

[EHdl,NHdl] = PlotGraph(E,n,P,'NdNum',1:n); % Draw the graph, output params: 
                                % edge handle, node handle

esize=size(E); % 1 times 'number of arcs' array

% Now use Pythagoras' Theorem to work out the euclidean distances between
% the nodes

for i=1:n % For all edges
    for j=1:n
        if i~=j  % I am working with arcs, not vertices (don't land teice on the same place)
            x(i,j)=P(i,1)-P(j,1); % X,Y separated, for clarity
            y(i,j)=P(i,2)-P(j,2);
            eucl_dist(i,j)=sqrt(x(i,j)^2+y(i,j)^2);
        end;
    end;
end;

disp('Euclidean distances between nodes');
eucl_dist

% Now see if they are close enough:
disp('My arcs');
E
for i=1:length(eucl_dist)
    for j=1:length(eucl_dist)
        if eucl_dist(i,j) > 30
        E(1,j)=0;
        end;
    end;
end;
disp('Far ones thrown out:');
E
