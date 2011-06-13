function [TS,acyclic] = myTopsort(AD) % Grundprinzip: bedeutende Ordnung.
% Vorgehen: entferne alle Knoten ohne Vorgänger (abgearbeitete Vorg.), bis
% alles abgearbeitet ist (keine Knoten ).

[I,g] = NetInc(E,n,c,'directed'); % Berechne Inzidenzinformation aus Graph im Hauptprogramm

TS = zeros(1,length(I)); % Sortierte Liste

for i=1:n
Indeg(i) = g(2,i); % Speichere In-Degree
Outdeg(i) = g(1,i); % Speichere Out-Degree
end;

no_in = find(Indeg == 0); % Knoten ohne Vorgänger (In-Degree 0)

no_in = TS;

    if ~isempty(no_in)
        acyclic = true;
    else
        acyclic = false;
    end;

while ~isempty(no_in) && acyclic == true
   
    first = TS(1); % Der Erste ohne Vorgänger kommt dran
    TS=TS(2:end); % no_in umdefinieren: es geht vom 2. Platz bis zu Ende (1. Platz gelöscht)   
    next = find(AD(first,:)==1); % Wie viele Nachfolger hat 'first'?
        
    for i = 1:length(next)
       
        no_in(i) = no_in - 1; % Wir wollen abgearbeitete Listen (= keine Vorgänger)... 
        
        if no_in(i) == 0
            TS = [TS,i]; % ..und da haben wir so ein Freudenbringer
        end;
        
    end;
    
end;

end