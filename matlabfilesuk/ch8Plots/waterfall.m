close all
%% Data loading
T = readtable("Waterfall.xlsx",'Sheet','Balance',...
              'ReadRowNames',true,'Range','A1:B14');
waterfallchart(T,'SetAsTotal',[1 3 7 11 13]);
ax = gca;
ax.YRuler.Exponent = 0; % disable scientific notation
title('From Gross Revenue to Net Income')

% print -depsc waterfall.eps;