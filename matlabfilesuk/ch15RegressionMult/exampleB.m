%% Data loading
XX=readtable("exampleB.xlsx",'ReadRowNames',true);
vNames=XX.Properties.VariableNames;

%% Two univariate regressions
% Perform the first regression
model1 = fitlm(XX, 'PRICE ~ PROMO');

% Perform the second regression
model2 = fitlm(XX, 'PRICE ~ ASSOR');

nr=1;
nc=2;
subplot(nr, nc, 1);
plot(model1,'LineWidth',3);
title('Regression Model 1: PRICE ~ PROMO');
xlabel('PROMO');
ylabel('PRICE');

subplot(nr, nc, 2);
plot(model2,'LineWidth',3);
title('Regression Model 2: PRICE ~ ASSOR');
xlabel('ASSOR');
ylabel('PRICE');

%% Set line widths

lwdBands = 2; % Define line width for confidence bounds
% Increase all dashed lines 
dottedLines = findobj(groot,'Type','Line','LineStyle',':');
set(dottedLines,'LineWidth',lwdBands);

% Increase all continuous lines 
lwdLine = 2.5; % Define line width for confidence bounds
dashedLines = findobj(groot,'Type','Line','LineStyle','-');
set(dashedLines,'LineWidth',lwdLine);

% exportgraphics(gcf,'Punivreg.pdf')

%% Alternative way using Named objects 
% Increase all dashed lines (commonly used for bounds)
% lb = findobj(gca,'DisplayName','95% conf. bounds');
% lwdBands=4;
% set(lb,'LineWidth',lwdBands);
% lb = findobj(gca,'DisplayName','Fit');
% lwdBands=4;
% set(lb,'LineWidth',lwdBands);


%% Multiple regression model
mdl=fitlm(XX,'PRICE ~ PROMO + ASSOR' );
disp('Display the summary of the multiple regression model')
disp(mdl)


%% Estimate of beta_PROMO with univariate regression through the origin
InputRes=model2.Residuals{:,"Raw"};

model3 = fitlm(XX, 'PROMO ~ ASSOR');

OutputRes =model3.Residuals{:,"Raw"};

VarNames=["Output residuals" "Input residuals"];
mdlSimpleRegression=fitlm(OutputRes, InputRes,'linear','VarNames',VarNames,'Intercept',false);
disp(mdlSimpleRegression)


%% Rpartial in table format
Rp = partialcorr(XX{:,:});   % Partial correlation matrix

Rp_table = array2table(Rp, 'VariableNames', vNames, 'RowNames', vNames);
disp("Partial correlation matrix")
disp(Rp_table);


%% Analysis of leverage points
plotDiagnostics(mdl,"leverage")
% exportgraphics(gcf,'levplot.pdf')

%% Scatter of ASSOR agaoinst PROMO
n=size(XX,1);
scatter(XX,"PROMO","ASSOR")
text(XX{:,"PROMO"},XX{:,"ASSOR"},num2str((1:n)'))


%% Analysis of residuals: plot residuals against fitted values and histogram
figure;
subplot(1, 2, 1);
plotResiduals(mdl, "fitted", "ResidualType", "raw", 'LineWidth', 2);
subplot(1, 2, 2);
hh=plotResiduals(mdl, "histogram");
% exportgraphics(gcf,'plResiduals.pdf')


%% Analysis of residuals: studentized and deletion
figure;
subplot(1, 2, 1);
plotResiduals(mdl,'caseorder','ResidualType','standardized', 'LineWidth', 2);
title('Internally studentized residuals')

subplot(1, 2, 2);
plotResiduals(mdl,'caseorder','ResidualType','studentized', 'LineWidth', 2);
title('Deletion residuals')
% exportgraphics(gcf,'studResiduals.pdf')


