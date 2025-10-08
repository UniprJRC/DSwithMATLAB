% For N(0,1)
pdINI=makedist('Normal');

%% For a normal N(1,4)

pd=makedist("Normal","mu",1,"sigma",2);
% L'intervallo di valori x è scelto in automatico
subplot(2,1,1)
plot(pd)

subplot(2,1,2)
% specify the interval 
x = -4:.1:8;
pdf_normal = pdf(pd,x);
plot(x,pdf_normal)

%% Weibull (W(1,1))
% Use default parameters lambda e k
figure
pd=makedist('Weibull');
plot(pd)

%% Distribuzione Weibull($\lambda, k$) con parametri con $\lambda$ e  $ k$ specificati dall'utente

figure
lambda=0.2; % scale parameter
k=10; % shape parameter
pd=makedist('Weibull','a',lambda,'b',k);
plot(pd)

%% In order to compute the mean and the variance
meanValue = mean(pd);
varianceValue = var(pd);
% Display the computed mean and variance
disp(['Mean: ', num2str(meanValue)]);
disp(['Variance: ', num2str(varianceValue)]);