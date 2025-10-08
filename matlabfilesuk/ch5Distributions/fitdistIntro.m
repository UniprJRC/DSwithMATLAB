%% Esempio di utilizzo di fitdist

rng default
nu = 5;          % degrees of freedom
n  = 100;        % sample size
sigma = 3;       % scale parameter
mu    = 2;       % location parameter
X = sigma * trnd(nu, n, 1) + mu;
stime = fitdist(X, "tLocationScale");
disp(stime)

%% Using t
stime=fitdist(X,"tLocationScale");
disp(stime)

%% using a normal model o un modello Normale
stimeN=fitdist(X,"Normal");
disp(stimeN)

%% Using  Weibull model
stimeW=fitdist(abs(X),"Weibull");
disp(stimeW)


%% Using a lognormal model
stimeLogN=fitdist(X,"Lognormal");
disp(stimeLogN);

%% Example of use of histfit

h=histfit(abs(randn(1000,1)),10,"gamma");

