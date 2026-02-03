Xtable = readtable("SpesaFatt.xlsx");
X = Xtable{:,:};
meaX = mean(X);
S = cov(X);

plot(X(:,1),X(:,2),'o','LineWidth',3)
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
hold('on')
hold on
Ell = ellipse(meaX,S,0.95);
axis equal
legend("Scatter","95% confidence ellipse",'Location','southeast')

%% Area e perimeter of ellipse
ellp=polyshape(Ell);
AreaEll=area(ellp);
PerimeterEll=perimeter(ellp);
disp("Centroid of the ellipse (found numerically)")
[meaX1,meaX2]=centroid(ellp);
disp([meaX1, meaX2])

disp("Centroid (arithmetic means) of matrix X")
disp(meaX)

%% Points in and out of ellipse
insideBoo = inpolygon(X(:,1),X(:,2),Ell(:,1),Ell(:,2));

figure
hold('on')
plot(X(insideBoo,1),X(insideBoo,2),'bo','LineWidth',3)
plot(X(~insideBoo,1),X(~insideBoo,2),'rx','LineWidth',3)
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')
plot(Ell(:,1),Ell(:,2))
axis equal
a=52.7355; b= 1.4594;
refline(b,a)
legend("Inside ellipse","Outside ellipse","Ellipse","Major-axis line",'Location','southeast')

%% Polygon intersection
xcoo=[min(X(:,1))-20; max(X(:,1))+20];
ycoo=a+b*xcoo;
[Pointsin,Pointsout]=intersect(ellp,[xcoo ycoo]);

figure
hold('on')
plot(X(insideBoo,1),X(insideBoo,2),'bo')
plot(X(~insideBoo,1),X(~insideBoo,2),'rx')
xlabel('X1 = Advertising spend (million €)')
ylabel('X2 = Revenue (million €)')

plot(ellp)
plot(Pointsin(:,1),Pointsin(:,2),'b-.',Pointsout(:,1),Pointsout(:,2),'r')
legend("Inside ellipse","Outside ellipse","Ellipse", ...
       "Line inside","Line outside",'Location','southeast')
axis equal

%    print -depsc figs\intPoly3.eps;
