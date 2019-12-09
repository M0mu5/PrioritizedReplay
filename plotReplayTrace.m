function plotReplayTrace(st,planning_backups,params,arrowColor)
% arrowColor, if empty, uses the 'hot' scale

figure(3); clf
arrowSize = 10; % default=5

if ~exist('arrowColor','var')
    arrowColor = hot(size(planning_backups,1)+10);
end
if size(arrowColor,1)==1
    arrowColor = repmat(arrowColor,size(planning_backups,1),1);
end

% get the initial maze dimensions: 
[sideII,sideJJ] = size(params.maze);

% Plot maze;
Vmaze = zeros(sideII,sideJJ); Vmaze(params.maze==1) = -1;
Vmaze(params.s_end(1),params.s_end(2)) = 0.2;
Vmaze(params.s_start(1),params.s_start(2)) = 0.2;
h1 = imagesc( Vmaze ); caxis([-1 1]); hold on;
xlim([1 9]); ylim([1 6]); set(gca,'Ydir','reverse');
grid on;

% Adjust colorscale
thisColorMap = params.colormap;
thisColorMap(1:(median(1:length(b2r(-1,1)))-1),:) = repmat([0,0,0],median(1:length(b2r(-1,1)))-1,1);
colormap(thisColorMap);

% Plot agent location
plot( st(2), st(1), 'o', 'MarkerSize', 20, 'MarkerFaceColor', [0.5 0.5 0.5] );

% % Plot planning steps
for p=1:size(planning_backups,1)
    drawArrows(gcf, planning_backups(p,1), planning_backups(p,2), arrowSize, arrowColor(p+5,:), false)
end

% Plot Goal and Start state symbols
for i=1:size(params.s_start,1)
    Ssym=text(params.s_start(i,2),params.s_start(i,1),'S');
    set(Ssym,'FontSize',24,'FontWeight','bold','HorizontalAlignment','center','VerticalAlignment','middle');
end
for i=1:size(params.s_end,1)
    Gsym=text(params.s_end(i,2),params.s_end(i,1),'G');
    set(Gsym,'FontSize',24,'FontWeight','bold','HorizontalAlignment','center','VerticalAlignment','middle');
end

% Remove axes
set(gca,'xtick',[]); set(gca,'xticklabel',[]);
set(gca,'ytick',[]); set(gca,'yticklabel',[]);

axis equal
axis off

pause(params.delay);
