function [d,p] = BFS(E,n,t)

    d = inf(1,n); % Discovery time (Zeit, bis Knoten grau)
    d(1,1)=0;
    p = zeros(1,n); % Vorgänger (predecessor) information
    ndlst = t;



    [I,g] = NetInc(E,n,zeros(1,length(E)),'directed'); % Finde Inzidenz und Grad der Knoten

    %AD (Adj.-Matrix) aus E (Kantenarray) erstellen (Ideen aus Seite 80).
    %id=E(i) - Index in E

    AD = inf(n,n);

    for i=1:length(E)
        u=mod(E(i),n);% "u = mod(id,n) if mod(id,n) > 0..."
        u(u==0)=n; % "...n otherwise"
        v=(E(i)-u)/n+1;
        AD(u,v)=1; % Nachdem man die AD ermittelt hat, kann man sie, in Truth-Table-Manier, auffüllen
    end;
    
    while ndlst~=0
            ndlst      
            u = ndlst(1);
            I(u)
            v = I(u).v(I(u).v>0); %Wohin kann ich von u aus gehen?
            v
            ndlst = [v,ndlst];
            minn = min(v);
            ndlst = ndlst - minn;
        
            for i=1:n
                for j=1:n
                    if AD(i,j)==inf
                        d(1,j)=d(1,j)+1;
                        p(1,j)=u;
                        ndlst=[v,ndlst];
                    end;
                end;
            end;
    end;
    