%% without xregion
load stars.mat
plot(stars{:,1},stars{:,2},'o','Marker','p','MarkerEdgeColor','r', ...
    'MarkerFaceColor','k','MarkerSize',12)
set(gca,'XDir','reverse') % To reverse the direction of the x-axis
xlabel('Surface Temperature')
ylabel('Light Intensity')
title('Hertzsprung-Russell Diagram')
% print -depsc starsscatterboxplotb.eps;


%% with xregion
figure
load stars.mat
plot(stars{:,1},stars{:,2},'o','Marker','p','MarkerEdgeColor','r', ...
    'MarkerFaceColor','k','MarkerSize',12)
set(gca,'XDir','reverse') % To reverse the direction of the x-axis
xlabel('Surface Temperature')
ylabel('Light Intensity')
title('Hertzsprung-Russell Diagram')
% print -depsc starsscatterboxplotb.eps;


xregion([3.45; 4.6],[3.6; 4.7])

%%  scatterboxplot + bivariate boxplot
figure
load stars.mat
scatterboxplot(stars{:,1},stars{:,2});
boxplotb(stars{:,:})
xlabel('Surface Temperature')
ylabel('Light Intensity')

%% scatterhistogram with grouping variable
figure
load fisheriris.mat
labels = {'Sepal Length','Sepal Width',...
    'Petal Length','Petal Width'};
i = 2; j = 3;
scatterhistogram(meas(:,i),meas(:,j),'GroupData',species,'LineWidth',1.2);
xlabel(labels{i}); 
ylabel(labels{j})
% print -depsc irisscatterhist.eps;




%% scatterboxplot with grouping variable
load fisheriris.mat
figure
i = 2; j = 3;
scatterboxplot(meas(:,i),meas(:,j),'Group',species)
labels = {'Sepal Length','Sepal Width',...
    'Petal Length','Petal Width'};
xlabel(labels(i))
ylabel(labels(j))

% print -depsc irisscatterboxplot.eps;

