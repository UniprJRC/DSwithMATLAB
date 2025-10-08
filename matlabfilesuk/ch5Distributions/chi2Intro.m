%% Density of chi2 as df vary
x=0:0.1:30;
for j=1:20
    subplot(4,5,j)
    denschi2=chi2pdf(x,j);
    plot(x,denschi2)
    title(['$\chi^2(' num2str(j) ')$'],'Interpreter','latex')
    xlim([0 30])
end

%% CDF and quantiles for chi2
nu = 12;
b = 11.3;
probLessb = chi2cdf(b, nu);
disp(['Pr (chi2(12) <' num2str(b) ') = ' num2str(probLessb)])
a = 10; b = 11;
disp(['Pr(' num2str(a)  '< chi2(12) < ' num2str(b) ') = ' num2str(chi2cdf(b,nu) - chi2cdf(a,nu))])
b = 20;
disp(['Pr(chi2(12) > ' num2str(b) ') = ' num2str(1 - chi2cdf(b,nu))])

disp(['0.90-quantile of chi2(12) = ' num2str(chi2inv(0.9,nu))])



%% Random sampling from chi2
rng(100)
n = 1e6;
y = chi2rnd(12, n, 1);
disp('---------------')
disp(['Empirical Pr(y<11.3) = ' num2str(sum(y<11.3)/n)])
disp(['Empirical Pr(10<y<11) = ' num2str(sum(y>10 & y<11)/n)])
disp(['Empirical Pr(y>20) = ' num2str(sum(y>20)/n)])
disp(['Empirical 0.90-quantile = ' num2str(prctile(y,90))])

