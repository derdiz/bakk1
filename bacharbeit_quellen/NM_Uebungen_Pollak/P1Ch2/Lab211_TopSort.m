clear all, close all;

[E,n,c,P,flag,report] = GrCstrR01(5,[],'type','directed','Econstr','topsort');

%[I,g] = NetInc(E,n,c,'directed'); % Berechne Inzidenzinformation aus Graph im Hauptprogramm

AD = zeros(n,n);

%AD (Adj.-Matrix) aus E (Kantenarray) erstellen (Ideen aus Seite 80).
%id=E(i) - Index in E
    for i=1:length(E)
        u=mod(E(i),n)% "u = mod(id,n) if mod(id,n) > 0..."
        u(u==0)=n % "...n otherwise"
        v=(E(i)-u)/n+1
        AD(u,v)=1 % Nachdem man die AD ermittelt hat, kann man sie, in Truth-Table-Manier, auffüllen
    end;

PatchGraph(E,n,P,'directed','archdstat',2,'nodenum',1:n);

%[L,AD_T,acyclic] = topsort(AD);
[TS,acyclic] = myTopsort(AD);

AD_TS
