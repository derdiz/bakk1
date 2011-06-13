function [EF,cF] = MSFKruskal(E,n,c)

% Initialisierungen
EF = zeros(1,n-1); % Kanten im Baum speichern: 1 weniger Knoten (1-n) als Kanten
cF = zeros(1,n-1); % Kosten speichern
K = zeros(1,n); % MSF

for i = 1:n
    K(i) = i;
end;

[c,i] = sort(c); % Sortiere die Kosten 
            % Aus Hilfe: [geordnet, Indexvektor] = sortiere(ungeordnet)
E=E(i); % Sortiere die Kanten des Graphen mit

% Die schon bekannte AD-Matrix (leicht modifiziert, um eine aufsteigende Sortierung der Kosten der Knoten zu erzielen)

    for l=1:length(E)
        u=mod(E(l),n);
        u(u==0)=n;
        u1(l)=u;
       
        v=(E(l)-u)/n+1;
        v1(l)=v;
   %     AD(u,v)=1; brauch ma hier net
    end;
   
    EF= zeros(1,n-1);     %Punkt2: EF und cF zunächst mit Nullen füllen, also leere Mengen
    cF= zeros(1,n-1);
    
    K= 1:n;

k=0; % Im while: aktueller Verbindungskomponent
i=0; 

while max(K) > 1
    k = k + 1;
    Ku = K(u1(k));  %Punkt 5(b):den Knoten, die aufsteigend nach Verbindungskosten geordnet sind, werden jetzt
    Kv = K(v1(k));  %noch Connectivity component-indexe zugewiesen.
        
        if Ku~=Kv,      % Keine Selfloops von Verbindungskomponenten (wird hier verhindert)
            i= i+1;
            EF(i)= E(k); % Erstellen des MSF
            cF(i)= c(k); % aktuelle Kosten
          
            % Zusammenhangskomponenten zusammenführen - bis
            % K nur noch aus Einsern besteht.
            % In der For-Schleife wird einfach die höhere Zahl durch die
            % niegrigere Zahl ausgetauscht.
            for w=1:n
                if K(w)==max(Ku,Kv)
                    K(w)=min(Ku,Kv);
                end;
            end; 
    end;
end;
