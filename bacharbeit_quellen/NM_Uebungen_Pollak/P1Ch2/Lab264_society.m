clear all;
close all;
%
% initialize plot environment
fig  = figure('color','w');
ax11 = subplot(2,2,1); 
ax12 = subplot(2,2,2); 
ax21 = subplot(2,2,3); % next two: plot and bar of improvements
ax22 = subplot(2,2,4); 
%
% create society and possible support connections
% i.e. 500 individuals whereby each individual is theoretically in the position to support 10 neighbours which
% are the nearest w.r.t. Euclidean distances
[E,n,c,P] = GRand(500,40,[],'noise',0.4,'euclidean'); 
%
% initialize a support structure by a MST
% T = SpnTr(E,n,c);
T = MSFKruskal(E,n,c);

PatchGraph(T,n,P,...
    'toax',ax11,...
    'nodemarkersize',4,...
    'nodename','individual',...
    'edgename','initial support structure');
%
% analyze initial structure w.r.t. balance of effort
[I,g] = NetInc(T,n,zeros(size(T))); 
mxg   = max(g);
y     = zeros(1,mxg);
for k = 1:mxg,
    y(k) = sum(g==k); % support by others?
end;
bar(ax12,y,'displayname','initial support histogram');
axes(ax12);
xlabel('node degree');
ylabel('# individuals');
%
% try to find a balanced and connected structure
% on the basis of the initial one
F = MinGrdT(E,n,T);
PatchGraph(F,n,P,...
    'toax',ax21,...
    'nodemarkersize',4,...
    'nodename','individual',...
    'edgename','balanced support structure');
%
% analyze initial structure w.r.t. balance of effort
[I,g] = NetInc(F,n,zeros(size(F))); 
mxg   = max(g);
y     = zeros(1,mxg);
for k = 1:mxg,
    y(k) = sum(g==k);
end;
bar(ax22,y,'displayname','balanced support histogram'); 
axes(ax22);
xlabel('node degree');
ylabel('# individuals');
%
% adapt histogram axes for better comparison
ax12_xlim = get(ax12,'xlim');
ax12_ylim = get(ax12,'ylim');
ax22_xlim = get(ax22,'xlim');
ax22_ylim = get(ax22,'ylim');
xlim      = [min(ax12_xlim(1),ax22_xlim(1)),max(ax12_xlim(2),ax22_xlim(2))];
ylim      = [min(ax12_ylim(1),ax22_ylim(1)),max(ax12_ylim(2),ax22_ylim(2))];
set(ax12,'xlim',xlim,'ylim',ylim);
set(ax22,'xlim',xlim,'ylim',ylim);
%
% show plot browser
brws = findall(fig,'type','uimenu','label','Plot Browser');
if strcmp(get(brws,'checked'),'off'),
    viewmenufcn(fig,'PlotBrowser');
    set(brws,'checked','on');
end;
