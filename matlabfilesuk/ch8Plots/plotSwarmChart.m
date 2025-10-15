%% data laoding
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
% print -depsc figs\swarmchart.eps;