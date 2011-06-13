close all, clear all;

[E,n,P,c]               = RdInst('G01.ist');

% Zeigen vom Graphen ohne Kosten
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'GrColr','k','NDNum',1:n);
set(NHdl,'markersize',8);

% Compute minimum spanning trees
u       = mod(E,n); 
u(u==0) = n;
v       = (E-u)/n+1;
d       = sqrt((P(u,1)-P(v,1)).^2+(P(u,2)-P(v,2)).^2);
d       = d';

%[F1,cF1] = SpnTr(E,n,d); % Calculate Euclidean costs
 [F1,cF1] = MSFKruskal(E,n,d);
%[F2,cF2] = SpnTr(E,n,c); % Calculate 'normal' costs
 [F2,cF2] = MSFKruskal(E,n,c);

stop = false;
while ~stop,
    disp('... in pause mode; press any key');
    pause;
    set(EHdl(ismember(E,F1)),'color','r'); % Jetzt werden die Eukl. Kosten auch gezeigt
    set(NHdl,'color','r');
    set(gcf,'name',['euclidean MST, costs = ',num2str(sum(cF1))]);
    disp('... in pause mode; press any key');
    pause;
    set(EHdl,'color','k');
    set(NHdl,'color','k');
    %
    set(EHdl(ismember(E,F2)),'color','r'); % Jetzt die 'normalen' Kosten
    set(NHdl,'color','r');
    set(gcf,'name',['predefined costs MST, costs = ',num2str(sum(cF2))]);
    disp('... in pause mode; press any key; press Ctrl+C to terminate');
    pause;
    set(EHdl,'color','k');
    set(NHdl,'color','k');
end;
    