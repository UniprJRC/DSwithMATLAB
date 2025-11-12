%% Q vs. theta via plot
thx = 0:0.1:20;
Q   = (thx-1)./(thx+1);
plot(thx,Q)
xlabel('$\theta$','Interpreter','latex')
ylabel('$Q=\frac{\theta-1}{\theta+1}$','Interpreter','latex')
title('Relation between Q and \theta')

%% Q vs. theta via fplot
fplot(@(th)(th-1)./(th+1),[0 20])
xlabel('$\theta$','Interpreter','latex')
ylabel('$Q=\frac{\theta-1}{\theta+1}$','Interpreter','latex')
title('Relation between Q and \theta')

%% Using symbolic calculation
syms th
Q=(th-1)./(th+1);
fplot(Q,[0 20])
xlabel('$\theta$','Interpreter','latex')
ylabel('$Q= \frac{\theta-1}{\theta+1}$','Interpreter','latex')
title('Relation between Q and \theta')% print -depsc figs\thetaQ.eps;

%% Relation between theta and U (not present in the book) 
figure
thx=0:0.1:20;
U=(sqrt(thx)-1)./(sqrt(thx)+1);
plot(thx,U)
xlabel('$\theta$','Interpreter','latex')
ylabel('$U= \frac{\sqrt \theta-1}{\sqrt \theta+1}$','Interpreter','latex')
title('Relation between U and \theta')

% print -depsc figs\thetaQ.eps;

