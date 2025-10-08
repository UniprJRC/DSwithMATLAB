%% Input data
x = (-9:0.1:9)';
mean = 3;
variance = 4;
sigma = sqrt(variance);

% Compute density using normpdf
ypdf = normpdf(x, mean, sigma);
% Manual implementation of the density
ypdfCHK = exp(-0.5 * ((x - mean)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
disp('Checking equality of implementations')
assert(max(abs(ypdf - ypdfCHK)) < 1e-10, 'Error in manual implementation of the density')

% Plotting
subplot(2,1,1)
plot(x, ypdf);
meanStr = num2str(mean);
varStr  = num2str(variance);
title(['Density function: N(' meanStr ',' varStr ')'])
ylabel('f(x)')

subplot(2,1,2)
ycdf = normcdf(x, mean, sigma);
plot(x, ycdf);
title(['CDF: N(' meanStr ',' varStr ')'])
ylabel('F(x)=Pr(X<x)')

%% Plot using comet
close all
% Using comet
subplot(2,1,1)
comet(x,ypdf);

title(['Density function: N(' meanStr ',' varStr ')'])
ylabel('f(x)')

subplot(2,1,2)
comet(x,ycdf);
title(['CDF: N(' meanStr ',' varStr ')'])
ylabel('F(x)=Pr(X<x)')

