%% Probability in U(3,8)
a = 3;
b = 8;

% P(5 < X < 6)
disp('--------------')
disp('P(5 < X < 6) in U(3,8)')
prob56 = unifcdf(6, a, b) - unifcdf(5, a, b);
disp(prob56)

%% Shading
x = (a-1 : 0.0001 : b+1)';
ypdf = unifpdf(x, a, b);
plot(x, ypdf, 'LineWidth', 2);
ylim([0 0.25])
title(['Density: U(' num2str(a) ',' num2str(b) ')'])

% Use hold('on') to overlay the next plot on the current one
hold('on')

% aa = index of the last x-value <= 5
aa = find(x <= 5, 1, 'last');
% bb = index of the first x-value >= 6
bb = find(x >= 6, 1);
% Use fill over the interval x(aa:bb)
fill(x(aa:bb), [0; ypdf(aa+1:bb-1); 0], 'g')
ylabel(['Pr(5 < X < 6) = ' num2str(prob56)])

%% Shading using distribspec
pd=makedist("Uniform","lower",a,"upper",b);
% Visualize the distribution with the specified parameters
distribspec(pd,[5 6],"inside");


%% Quantiles

% 0.80 and 0.90 quantiles (values leaving 0.20 and 0.10 probability to the right) in U(3,8)
quant = [0.80 0.90];
disp('Quantiles 0.8 and 0.9 in U(3,8)')
disp(unifinv(quant, a, b))

%% Generating n random numbers from U(3,8)
% Fix a random seed for reproducibility
seed = 123;
rng(seed)
n = 10000;
p = 1;
% rand generates values in U(0,1).
% Transform them from [0,1] to [a,b]
X = rand(n, p) * (b - a) + a;
% Reinitialize the random number generator
rng(seed)
X1 = unifrnd(a, b, n, p);
assert(max(abs(X - X1)) < 1e-15, "The random samples differ")
figure
histogram(X, 'Normalization', 'pdf')
title(['Generating ' num2str(n) ' random numbers from U(' num2str(a) ',' num2str(b) ')'])

