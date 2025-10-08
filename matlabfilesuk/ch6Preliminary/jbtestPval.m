n = 100;
rng(1234)
x = unifrnd(3,30,n,1);
[~,pvaldef,stat] = jbtest(x);
pvalchi2 = chi2cdf(stat,2,'upper');
disp(['asymptotic chi2 p = ' num2str(pvalchi2)])
disp(['default jbtest p = ' num2str(pvaldef)])
[~,pvalmc] = jbtest(x,0.05,1e-03);
disp(['Monte Carlo p = ' num2str(pvalmc)])