clear all, close all;

[E,n,P,c,r,Pi,I,J] = RdInst('ClgN1BoundI1-01.ist'); % Einlesen des Netzwerkes 'ClgN1BoundI1-01.ist'
% Aufzeichnen des Graphen, gerichtet
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'GrColr',[0.7,0.7,0.7]);
%
xlim = get(gca,'xlim');
xofs = diff(xlim)*0.001;
%
set(NHdl(r==0),'visible','off');
set(NHdl(r>0),'markersize',4,'markerfacecolor','r','color','r');
%
set(EHdl(ismember(E,I)),'color','k','linewidth',2);
set(NHdl(J),'visible','on','markersize',4,'markerfacecolor','k','color','k');

% Breitensuche

T = find(r>0); % Find in Frage kommende Knoten (verbindbare Netzwerkkunden)
for k = 1:length(T), % F�r alle Kunden ('Connection Objects')
    t     = T(k);
    [d,p] = FstSearch(E,n,t);
    %
    if any(d(J)~=inf),
        j = J(d(J)==min(d(J)));
        text(P(t,1)+xofs,P(t,2),['\leftarrow ',int2str(d(j))],'verticalalignment','middle');
        %
        while j~=t,
            set(EHdl(E==(max(j,p(j))-1)*n+min(j,p(j))),'color','r');
            j = p(j);
        end;
        %
        drawnow;
    end;
end;
