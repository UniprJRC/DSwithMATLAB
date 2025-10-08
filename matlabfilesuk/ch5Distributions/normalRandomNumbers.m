seed = 12345;
rng(seed)
n = 10000;
p = 1;
sigma = 10;
mu = 6;
X = sigma*randn(n,p) + mu;
% Reinitialize random seed
rng(seed)
X1 = normrnd(mu, sigma, n, p);
assert(isequal(X, X1), "Random samples differ")
histogram(X)
title(['Histogram of ' num2str(n) ' random numbers from N(' num2str(mu) ',' num2str(sigma^2) ')'])
