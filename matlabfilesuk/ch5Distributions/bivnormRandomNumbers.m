%% Random data from bivariate normal

mu = [1 2];  

Sigma = [0.8 0.7;0.7 1.3]; rng(234); n=1000;
X=mvnrnd(mu,Sigma,n);
scatterboxplot(X(:,1),X(:,2))
title('1000 pairs from a bivariate normal')
mea=mean(X);

xline(mea(1),'--');
yline(mea(2),'--')