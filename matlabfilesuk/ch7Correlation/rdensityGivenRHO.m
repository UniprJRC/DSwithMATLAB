x=-1:0.01:1;
rho=[0:0.2:0.8 0.9]';
n=12;
rhos=num2str(rho);
ns=num2str(n);
close all
for i=1:length(rho)
    nexttile
    dens=corrpdf(x,rho(i),n);
    plot(x,dens)
    title(['$f(r|n=' ns ', \rho=' rhos(i,:) ')$'],'Interpreter','latex')
    xlabel("$r$",'Interpreter','latex')
end

sgtitle('Density of the sample correlation coefficient for different values of \rho')