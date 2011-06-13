%DFS1 Kurt Horvath lab 251
clear all; close all;

%non recursive implementation
  
[E,n,P,c] = RdInst('M:\CEIT\NM\G01.ist',[]);
[EHdl,ETHdl,NHdl,NTHdl] = PlotGraph(E,n,P,'directed','NdNum',[1:n],'GrColr','k');
set(NHdl,'markersize',10);

x=1;    %start node
dep=0;  %depth of path


%for I=1:3
[N1,N2] = getNODE(E, n);



    next = N1(find(N2==x))
    ML(find(N2==x))='g';
    dep=dep+1;N2

  
x=next
pre=next;
ML
pause(2)

for i=1:length(x)
    ML(x(i))
    if ML(x(i))~='g'
      next(i) = N1(find(N2==x(i)));
    ML(find(N2==x(i)))='g';
    else
        disp('cant go deeper');
    end
end
dep=dep+1;
x=next
ML
pause(2)

for i=1:length(x)
    ML(x(i))
    if ML(x(i))~='g'
      next(i) = N1(find(N2==x(i)));
    ML(find(N2==x(i)))='g';
    else
        disp('cant go deeper');
    end
end

dep=dep+1;
x=next
ML
pause(2)

for i=1:length(x)
    ML(x(i))
    if ML(x(i))~='g'
      next(i) = N1(find(N2==x(i)));
    ML(find(N2==x(i)))='g'; %new discovered
    else
        disp('cant go deeper');
    ML(find(N2==x(i)))='b';
    end
end

dep=dep+1;
x=next
ML
pause(2)

%end