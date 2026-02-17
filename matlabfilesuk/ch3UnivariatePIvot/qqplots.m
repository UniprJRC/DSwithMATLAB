miofile="Firm.xlsx"; % Data loading 
X=readtable(miofile,"ReadRowNames",true);

%% Compare empirical quantiles to those of N(mu,sigma)
n = 10000;
% xnorm = data from N with mean 5678 and sigma 1234
xnorm = randn(n,1)*1234 + 5678;
% nu = degrees of freedom
nu = 5;
% xstudentt = data from T(5)
xstudentt = trnd(nu, n, 1);

subplot(2,2,1)
qqplot(xnorm);
title('QQ-plot for data from N(\mu,\sigma^2)')
subplot(2,2,2)
qqplot(xstudentt);
title('QQ-plot for data from T(5)')
subplot(2,2,3:4)
qqplot(X.Wage);
title('QQ-plot of the Wage variable')




%% Part not in the book
subplot(2,2,1)
qqplot(xnorm);
title('QQ-plot for data from N(\mu,\sigma^2)')
subplot(2,2,2)
qqplot(xstudentt);
title('QQ-plot for data from T(5)')
subplot(2,2,3)
xchi2=chi2rnd(5,n,1);
qqplot(xchi2);
title('QQ-plot for chi2(5)')

subplot(2,2,4)
qqplot(X.Wage);
title('QQ-plot of the Wage variable')
