%% data loading
load loyalty.mat
loyalty.family(loyalty.family > 5) = 5;
nr = 2; nc = 1;
subplot(nr,nc,1)
scatter(loyalty,'family','amount_spent')
title('Scatter Plot')
xlim([0.5 5.5])
subplot(nr,nc,2)
swarmchart(loyalty,'family','amount_spent')
title('Swarm Chart')


%% violinplot
figure
violinplot(loyalty,'family','amount_spent')
title('Violinplot')

%% boxchart
figure
boxchart(loyalty,'family','amount_spent','Orientation','vertical')
title('Boxplot')

%% raincloudplot (just 2026a)
figure
raincloudplot(loyalty,'family','amount_spent','Orientation','vertical')
title('Rain cloud plot')