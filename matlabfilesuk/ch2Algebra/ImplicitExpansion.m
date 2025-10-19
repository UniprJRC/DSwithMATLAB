n=20; p=3;
rng(123)
X = 10 + 3*randn(n,p);
X([5 8],:) = 100;

% Standard Z
Z = (X - mean(X)) ./ std(X);
Zchk = zscore(X);
bar(Z)
title("Bar plot of standardized values")

% Robust Z
Zrob = (X - median(X)) ./ (1.4826*mad(X,1));
Zrobchk = zscoreFS(X);
figure
bar(Zrob)
title("Bar plot of robust standardized values")

%% Implicit expansion in tables

load citiesItaly.mat
disp(citiesItaly - mean(citiesItaly,1))

disp(citiesItaly(:,2:4) ./ citiesItaly{:,1})