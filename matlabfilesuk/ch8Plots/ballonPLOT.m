load housetasks.mat
balloonplot(housetasks);

% print -depsc balloonPLOT.eps;

%% Second example
X = readtable("graphuniv2series.xlsx",'Sheet','data','ReadRowNames',true);
Xd=X{:,1:2};

figure
balloonplot(X);
title('Balloonplot')

