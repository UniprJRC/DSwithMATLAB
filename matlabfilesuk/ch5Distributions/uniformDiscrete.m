% Fix seed
rng(100)
disp("4x4 matrix of random integers from the set (1,2,...,8)")
disp(randi(8,4))

%% Random integers from the set 11,12,...,20
imin = 11; imax = 20;
n = 10000;
x = randi([imin,imax],[n,1]);
% The FSDA toolbox function tabulateFS
% creates the frequency distribution of the values in x
TB = tabulateFS(x);
bar(TB(:,1), TB(:,2))
i1 = num2str(imin);
i2 = num2str(imin+1);
in = num2str(imax);
titleText = ['Bar chart of ' num2str(n) ' random numbers'];
subtitleText = ['from a discrete uniform distribution on {' i1 ',' i2 ', ...,' in '}'];
title(titleText, subtitleText)
% print -depsc figs\uniformeDisc.eps;

%% Using pivot
% pivot(array2table(x),'Rows','x','RowsBinMethod',imin:(imax+1))