XX=readtable("regr-piv.xlsx","ReadRowNames",true);

scatter(XX,"PRICES","SALES","filled")
X=XX{:,1};
y=XX{:,2};
text(X,y+2,XX.Properties.RowNames)

% exportgraphics(gca,"scatterSales.pdf")

%% Output with GUIregress

GUIregress(X,y)
% exportgraphics(gcf,"regr1.pdf")
% exportgraphics(gcf,"regr2.pdf")


GUIregress(X,y,'inferential',0.95)
% exportgraphics(gcf,"regr3.pdf")


%% Output with fitlm
mdl = fitlm(XX);

%% Methods and Properties on mdl
disp(mdl);
coefCI(mdl)

anova(mdl)


%% Prediction

x0=[1.52; 1.8];
[y0,conflev] = predict(mdl, x0,"Prediction","observation");
disp(conflev)


%% Method plotSlide applied to mdl
plotSlice(mdl)
h = findall(groot, '-class', 'matlab.ui.Figure');
exportapp(h(1), "plotSlice.pdf");

% exportgraphics(gcf,".pdf")


%% Plot with error bars
scatter(XX,"PRICES","SALES","filled")
hold on 
lwd=2;
errorbar(x0,y0,conflev(:,2)-y0,'vertical','o','LineWidth',lwd)
exportgraphics(gcf,"foreErrorBar.pdf")

%% Prediction curve
x0=[1.52; 1.8];
[y0,conflev] = predict(mdl, x0,"Prediction","curve");
disp(conflev)

%% Plot of residuals (not in the book)
plotResiduals(mdl,"caseorder","MarkerSize",10,'LineWidth',10)
plotResiduals(mdl,'probability')