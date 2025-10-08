n       = 10;
nsimul  = 100000;
quant   = [0.001; 0.01; (0.05:0.05:0.95)'; 0.99; 0.999];
rng(20);

Testall = zeros(nsimul,1);
Rall    = zeros(nsimul,1);
for i = 1:nsimul
    x = randn(n,1);
    y = randn(n,1);
    r = corr(x,y);
    Testall(i) = (r/sqrt(1-r^2)) * sqrt(n-2);
    Rall(i)    = r;
end

%% Quantile comparison
Empirici   = quantile(Testall, quant);
TeoriciT   = tinv(quant, n-2);
TeoriciN   = norminv(quant);

subplot(1,2,1)
plot(Empirici, TeoriciT)
xlabel('Empirical quantiles')
ylabel('Theoretical T(n-2) quantiles')
subplot(1,2,2)
plot(Empirici, TeoriciN)
xlabel('Empirical quantiles')
ylabel('Theoretical N(0,1) quantiles')

%% p-values for observed t_r = -2.6
t_obs = -2.6;

% a) two-sided
p_emp_bil  = sum(abs(Testall) > abs(t_obs)) / nsimul;
p_theo_bil = tcdf(abs(t_obs), n-2, 'upper') * 2;
disp('Two-sided p-values (theoretical vs empirical):')
disp([p_theo_bil, p_emp_bil])

% b) right-sided H1: rho > 0
p_emp_dx   = sum(Testall > t_obs) / nsimul;
p_theo_dx  = tcdf(t_obs, n-2, 'upper');
disp('Right-sided p-values (theoretical vs empirical):')
disp([p_theo_dx, p_emp_dx])

% c) left-sided H1: rho < 0
p_emp_sx   = sum(Testall < t_obs) / nsimul;
p_theo_sx  = tcdf(t_obs, n-2);
disp('Left-sided p-values (theoretical vs empirical):')
disp([p_theo_sx, p_emp_sx])

