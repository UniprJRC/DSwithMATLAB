%% Scatter with confidence ellipse
Xtable=readtable("SpesaFatt.xlsx");
% X=data matrix
X=Xtable{:,:};
n=size(X,1); X1=X(:,1); X2=X(:,2);
% meaX= row vector with means
meaX=mean(X);
% Matrix of deviations from means
Xtilde=X-meaX;
% S = covariance matrix 
S=Xtilde'*Xtilde/(n-1);
plot(X1,X2,'o','LineWidth',3)
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
hold('on')

%% Add confidence ellipses
confLevEllipses=[0.5 0.75 0.90 0.99];
for i=1:length(confLevEllipses)
    ellipse(meaX,S,confLevEllipses(i));
end
axis equal


%% Eigenvalues and eigenvectors of S
[Vini,Lambdaini] = eig(S);
[~,ord]         = sort(diag(Lambdaini),'descend');
Lambda = Lambdaini(ord,ord);
V      = Vini(:,ord);

%% Scatter diagram and principal line 
figure
plot(X1,X2,'o')
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
bprinc=-V(1,2)/V(2,2);
aprinc=meaX(2)-bprinc*meaX(1);
refline(bprinc,aprinc);
axis equal
title(['Principal axis: X2 = ' num2str(aprinc) ' + ' num2str(bprinc) ' X1'])


%% Scatter with orthogonal projections
hold('on')
% y1 = point coordinates in the space of the first PC
% y1 has dimension 1
v1=V(:,1);
y1=Xtilde*v1;

% Xtildehat = point coordinates of projected coordinated in the original
% bivariate space
Xtildehat=y1.*v1';
Xhat=Xtildehat+meaX;

plot([Xhat(:,1) X1]',[Xhat(:,2) X2]','k')
axis equal

title({'Scatter,''Principal axis and projected points'...
 'along the principal axis'})


%% Part not in the book
% X1 X2 = original poiunts
figure
plot(X1,X2,'x')
hold('on')
plot(Xhat(:,1),Xhat(:,2),'x')

% Xhat(:,1) Xhat(:,2) coordinates of the projected points
% along the principal line
axis equal

%% Computation of residuals
Residuals=X-Xhat;
disp('Sum of squared residuals')
disp(sum(Residuals.^2,'all')/(n-1));

%% Check that Residuals is equal to the output of call to pcares
[ResidualsCHK,XhatCHK]=pcares(X,1);
maxdiffRES=max(abs(Residuals-ResidualsCHK),[],'all')<1e-12;
assert(maxdiffRES,"Err in the computation of residuals")
maxdiffX=max(abs(Xhat-XhatCHK),[],'all')<1e-12;
assert(maxdiffX,"Programming error  " + ...
    "in the reconstructoin of X")

%% Regression line
% Find the least-squares regression line minimizing
% sum of (y_i - yhat_i)^2
figure
% X2 = Revenue (dependent), X1 = Advertising spend (predictor)
out   = fitlm(X1,X2);                          % MATLAB's regression routine
areg  = out.Coefficients.Estimate(1);         % intercept
breg  = out.Coefficients.Estimate(2);         % slope
yhat  = out.Fitted;                           % fitted values

plot(X1,X2,'o')                               % original data
hold on

hOLS  = lsline;                               % adds regression line
hOLS.Color = 'r';                             % red regression line

% draw vertical lines from points to the regression line
plot([X1 X1]', [yhat X2]','k')

xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
title(['Regression line: X2 = ' num2str(areg) ' + ' num2str(breg) ' X1'])
axis equal
% print -depsc figs\proiez4.eps;
