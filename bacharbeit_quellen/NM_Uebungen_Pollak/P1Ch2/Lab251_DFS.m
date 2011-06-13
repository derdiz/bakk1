clear all, close all;

[E,n,P,c] = RdInst('G01.ist'); % Einlesen des Netzwerkes 'G01'
% Aufzeichnen des Graphen, gerichtet, 1:n Knoten
[EHdl, NHdl] = PlotGraph(E,n,P, 'directed','NdNum',[1:n],'GrColr','k');

% Discovery- und Finishing-Time nach der Tiefensuche berechnen
%[d,p,f] = FstSearch(E,n,[],'depth','directed'); % Tiefensuche.
[d,f,p] = DFS(E,n,1);

xlim = get(gca,'xlim');
ylim = get(gca,'ylim');
xofs = diff(xlim)*0.05;
yofs = diff(ylim)*0.05;

% Zeige die Discovery- (d(k)) und Finishing-Time (f(k)) von jedem Knoten an
% P(k,1)+xofs und P(k,2)+yofs bezeichnet einfach die Position des Textes
for k = 1:n,
    text(P(k,1)+xofs,P(k,2)+yofs,['[',int2str(d(k)),',',int2str(f(k)),']'],'backgroundcolor','w')
end;

% Zeige den Tiefensuchenwald
for v = 1:n
    u = p(v);
    if u~=0,
        set(EHdl(E==(v-1)*n+u),'color','r');
    end;
end;
