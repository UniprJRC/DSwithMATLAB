close all
% Load workspace with precomputed variables
load workspacePreliminareEllisse.mat

%% Poins in the original space with ellipse

plot(X1,X2,'o')
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
hold('on')

Ell= ellipse(meaX,S,1);
axis equal


%% Convert ellipse coordinates to a polygon
ellp = polyshape(Ell);

% Generate x,y coordinates along principal line
xcoo = (min(X1):0.01:max(X1))';
ycoo = aprinc + bprinc*xcoo;

% Find intersection points between line and ellipse
[in,out] = intersect(ellp, [xcoo ycoo]);

disp("Length of the principal semi-axis (numerical)")
% Last intersection point inside the ellipse:
lunSemiAxis = norm(in(end,:) - meaX);
disp(lunSemiAxis)

%% Length of the major semiaxis of the ellipse and first eigenvalue

% gamma1 = lunghezza asse maggiore ellisse
gamma1=sqrt(Lambda(1,1));

disp("Length of the semiaxis of the ellipse")
disp("Square root of first eigenvalue")
disp(gamma1)

% gamma2= lunghezza asse minore ellisse
gamma2=sqrt(Lambda(2,2));

%% Area and perimeter of the ellipse (numeric)
disp(['Area of ellipse: '      num2str(area(ellp))])
disp(['Perimeter of ellipse: ' num2str(perimeter(ellp))])


%% Area and perimeter of the ellipse (exact)
disp("Area of the ellipse (exact value): pi*gamma1*gamma2")
disp(pi*gamma1*gamma2);

disp('Perimeter of the ellipse (Ramanujan formula)')
disp(pi*(3*(gamma1+gamma2)-sqrt((3*gamma1+gamma2)*(gamma1+3*gamma2))))

%% Poins in the original space with ellipse

plot(X1,X2,'o')
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
hold('on')

Ell= ellipse(meaX,S,1);
axis equal
[in]=inpolygon(X1,X2,Ell(:,1),Ell(:,2));
seq=1:n;
textOut=string(seq(~in));
text(X(~in,1),X(~in,2),textOut)

%% Points in the original space (deviation from the means)
figure
Xtilde1=Xtilde(:,1);
Xtilde2=Xtilde(:,2);

plot(Xtilde1,Xtilde2,'o')
xlabel('$\tilde X_1= X_1-\overline x_1$','Interpreter','latex')
ylabel('$\tilde X_2=X_2-\overline x_2$','Interpreter','latex')
hold('on')
Ell= ellipse(0,S,1);
axis equal
[in]=inpolygon(Xtilde1,Xtilde2,Ell(:,1),Ell(:,2));
seq=1:n;
textOut=string(seq(~in));
text(Xtilde1(~in),Xtilde2(~in),textOut)
% print -depsc figs\rotazione2.eps;

%% Points in the new reference system (PC)
figure
Y=Xtilde*V;
plot(Y(:,1),Y(:,2),'o')
hold('on')
Ellr= ellipse(0,Lambda,1);
xlabel('$Y_1$ = First principal component','Interpreter','latex')
ylabel('$Y_2$ = Second principal component','Interpreter','latex')

[in]=inpolygon(Y(:,1),Y(:,2),Ellr(:,1),Ellr(:,2));
seq=(1:size(X,1))';
textOut=string(seq(~in));
text(Y(~in,1),Y(~in,2),textOut)
axis equal
% print -depsc figs\rotazione3.eps;
%% Points in the space of standardized PC
figure
Yst=zscore(Y);
plot(Yst(:,1),Yst(:,2),'o')
hold('on')
Ellr= ellipse(0,eye(2),1);
xlabel(['$Y_1/ \sqrt \lambda_1 $=First standardized principal component ' ...
    ''],'Interpreter','latex')
ylabel(['$Y_2/  \sqrt \lambda_2$=Second standardized principal component' ...
    ''],'Interpreter','latex')
[in]=inpolygon(Yst(:,1),Yst(:,2),Ellr(:,1),Ellr(:,2));
textOut=string(seq(~in));
text(Yst(~in,1),Yst(~in,2),textOut)
axis equal
% print -depsc figs\rotazione4.eps;


