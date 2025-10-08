%% Probability calculations in N(mu,sigma^2)
mean = 3;
variance = 4;
sigma = sqrt(variance);

% P(X < 1.2)
disp('--------------')
disp('P(X < 1.2) in N(3,4)')
disp(normcdf(1.2, mean, sigma))

% P(5 < X < 6)
disp('--------------')
disp('P(5 < X < 6) in N(3,4)')
prob56 = normcdf(6, mean, sigma) - normcdf(5, mean, sigma);
disp(prob56)

%% Plotting P(5 < X < 6)
x = (-9:0.0001:9)';
ypdf = normpdf(x, mean, sigma);
plot(x, ypdf);
title(['Density: N(' num2str(mean) ',' num2str(variance) ')'])
hold('on')
a = find(x <= 5, 1, 'last');
b = find(x >= 6, 1);
fill(x(a:b), [0; ypdf(a+1:b-1); 0], 'g')
ylabel(['Pr(5 < X < 6) = ' num2str(prob56)])

%%  Shading using normspec
normspec([5 6],mean,sigma,'inside')
title(['N('  num2str(mean) ',' num2str(variance) ')'])
ylabel(['Pr(5<X<6)=' num2str(prob56)])


%%  Shading using fill
figure
x=(-9:0.0001:9)';
ypdf=normpdf(x,media,sigma);
plot(x,ypdf);
title(['Density: N('  num2str(media) ',' num2str(varianza) ')'])

hold('on')

a=find(x<=5,1,'last');
b=find(x>=6,1);
fill(x(a:b),[0;ypdf(a+1:b-1);0],'g')
ylabel(['Pr(5<X<6)=' num2str(prob56)])
% print -depsc figs\normfill.eps;

%% Quantile in N(3,4)
% 0.975 quantile (leaves 2.5% to the right) in N(3,4)
disp('Quantile 0.975 in N(3,4)')
disp(norminv(0.975, mean, sigma))


%% Quantiles in N(0,1)
% Vector of requested probabilities
quant = [0.005, 0.025, 0.975, 0.995];
quantNames = "z" + quant;
xz = norminv(quant);                     % Standard normal
xzt = array2table(xz, "VariableNames", quantNames);
disp("Quantiles in N(0,1)")
disp(xzt)

