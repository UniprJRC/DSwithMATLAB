% Empirical Monte Carlo distribution of r
rho    = 0.4; n = 7; nsimul = 10000;
Rall   = zeros(nsimul,1);
Sigma  = [1 rho; rho 1];
for i = 1:nsimul
    X = mvnrnd([0 0], Sigma, n);
    Rall(i) = corr(X(:,1), X(:,2));
end
% Compare empirical vs theoretical
rseq    = -1:0.01:1;
densrho = corrpdf(rseq,rho,n);
histogram(Rall,'Normalization','pdf')
hold on
plot(rseq,densrho,'LineWidth',2)
xlabel('$r$','Interpreter','latex')
ylabel(['$f(r\mid \rho=' num2str(rho) ', n=' num2str(n) ')$'],'Interpreter','latex')
title('Empirical vs theoretical density of $r$','Interpreter','latex')

r = 0.7;
probTheo = corrcdf(r,rho,n,'upper');
disp(['Theoretical Pr(r>0.7|rho=0.4,n=7)=' num2str(probTheo)])
probEmp  = sum(Rall>r)/nsimul;
disp(['Empirical Pr(r>0.7|rho=0.4,n=7)=' num2str(probEmp)])