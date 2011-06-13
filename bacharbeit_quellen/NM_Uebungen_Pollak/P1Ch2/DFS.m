function [d,f,p] = DFS(E,n,u,varargin) % Vom Skript, Seiten 24-25

time = 0;

colour=zeros(1,n); % Weiß, grau oder schwarzer Knoten
d = zeros(1,n); % Discovery time (Zeit, bis Knoten grau)
f = zeros(1,n); % Finishing time (Zeit, bis Knoten schwarz)
p = zeros(1,n); % Vorgänger (predecessor) information

[I,g] = NetInc(E,n,zeros(1,length(E)),'directed'); % Finde Inzidenz und Grad der Knoten
    
        if colour(u)==0   %wenn ein Knoten noch unentdeckt: colour=weiß
                            % daher: DFS ausführen
            %Ab hier: Algorith DFS im Skript auf S. 21
            colour(u) = 1;
            d(u) = time;%1. Durchlauf: d(1)=0
            time = time+1;
            ndlst = u; % Initialisierung der Nachfolgerliste
            while ndlst~=0
                      ndlst      
                u = ndlst(1);
                I(u)
                v = I(u).v(I(u).v>0); %Wohin kann ich von u aus gehen?
                v
                if any(colour(v)==0)   %Wenn noch irgendein Knoten nicht endtdeckt (weiß) ist
                    v = min(v(colour(v)==0)); % Der nächste Knoten kriegt den kleinsten Zeitstempel (ist am Nächsten)
                    
                    colour(v) = 1;
                    p(v) = u;   % von u aus wurde v entdeckt: u Vorgänger von v
                    d(v) = time; % Entdeckzeit von v
                    time = time+1; % Zeit erhöhen, bevor es zum Nachfolger geht
                    ndlst = [v,ndlst];       %Liste aufbauen, da es Nachfolger gibt
                else
                    ndlst = ndlst(2:end);    %Liste abbauen, da der erste Knoten in der Liste keinen unentdeckten Nachfolger mehr hat.
                    colour(u) = 2;
                    f(u) = time;
                    time = time+1;
                end; 
            end;
        end;