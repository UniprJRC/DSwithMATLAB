%% Load the data in matrix format
y=readmatrix("regrSeaso.xlsx","Range","C6:C25");

vdate=(datetime(2021,1,1):calquarters:datetime(2025,12,1))';
yTT=array2timetable(y,"RowTimes",vdate);
% Create the plot of original values
plot(vdate,y,'LineWidth',2)
ylabel('Quarterly sales')

% set(gca,'XTickLabelRotation',90)
% exportgraphics(gcf,'vendite.pdf')

%% Create table Xt trend+ dummy variables
% quart= vector which contains the quarter number
% for each observation
quart=quarter(vdate); 
D=dummyvar(quart);
T=length(y);
trend=(1:T)';

X=[array2table(trend),array2table(D)];

%% First parametrization (without intercept)
mdl1=fitlm(X,y,'Intercept',false);

% Display the summary of the fitted model
disp('First parametrization')
disp(mdl1);


%% Second parametrization (without D4)
mdl2=fitlm(X(:,1:end-1),y);

% Display the summary of the fitted model
disp('Second parametrization')
disp(mdl2);

%% Third parametrization (sum to zero of seasonal coeff)
CoeffSeaso=mdl1.Coefficients.Estimate(2:end);
Intercept=mean(CoeffSeaso);
% Adjust seasonal coefficients to sum to zero
CoeffSeasoSum2zero = CoeffSeaso - Intercept;

%% Check the null hypothises of no seasonality
mdlr = fitlm(trend,y);            % restricted
F = ((mdlr.SSE - mdl2.SSE)/3) / (mdl2.SSE/(mdl2.NumObservations - mdl2.NumEstimatedCoefficients));
pval = 1 - fcdf(F, 3, mdl2.NumObservations - mdl2.NumEstimatedCoefficients);


%% Alternative way of obtaining the parameter estimates

outCAT=fitlm([trend quart],y,"linear","CategoricalVars",2,"VarNames",["trend" "Q" "y"]);

C=[zeros(3,2) eye(3)];
[pValueSeasonalCHK, FtestSeasonalCHK,numDF] = coefTest(outCAT,C);
% Show pvalue and F test pValueSeasonalCHK, FtestSeasonalCHK
disp(['F test for seasonality ', num2str(FtestSeasonalCHK)]);
disp(['p-value of the test for sesonality: ', num2str(pValueSeasonalCHK)]);



%% 
yTT=array2timetable(y,"RowTimes",vdate);


%% Estimate of the trend component
trendCoefficient=mdl1.Coefficients.Estimate(1);
yTT.Trend = Intercept+trendCoefficient*trend;

%% Estimate of the seasonal component
yTT.Seasonal=D*CoeffSeasoSum2zero;

%% predicted = trend component+ seasonal component
predicted = yTT.Trend + yTT.Seasonal; % Combine trend and seasonal components for predictions
yTT.Predicted = predicted; % Store predicted values in the timetable

%% Detrended series
% Calculate the detrended series by subtracting predicted values from original data
% Store the detrended values in the timetable
yTT.Detrended = y - yTT.Trend; 

%% Deseasonalized series series
% Calculate the deseasonalized series by subtracting the seasonal component
% from original data
% Store the deseasonalized values in the timetable
yTT.Deseasonalized = y - yTT.Seasonal; 

%% Residuals = (y-trend - seasonal component)
% Calculate residuals and store in the timetable
yTT.Residuals = y - predicted; 

%% Plots
s=stackedplot(yTT,{["y" "Predicted"]},'LineWidth',1)

%% Real and predicted
plot(vdate,y,'-',vdate,predicted,'--','LineWidth',2)
legend(["Real values" "Predicted values"],'Location','best')

% set(gca,'XTickLabelRotation',90)
exportgraphics(gcf,'venditefitted.pdf')

%% Deasesonalized time series
plot(vdate,yTT.Deseasonalized,'-','LineWidth',2,'Marker','o','MarkerFaceColor','auto')
ylabel('Deseasonalised time series')
exportgraphics(gcf,'venditedeseas.pdf')
% legend(["Real values" "Predicted values"],'Location','best')

%% Detrended time series
plot(vdate,yTT.Detrended,'-','LineWidth',2,'Marker','o','MarkerFaceColor','auto')
ylabel('Detrended time series')
% exportgraphics(gcf,'venditedetrend.pdf')

%% Detrended and deseasonalized time series (residuals)
plot(vdate,yTT.Residuals,'-','LineWidth',2,'Marker','o','MarkerFaceColor','auto')
ylabel('Detrended and deaseasonalized time series')
% exportgraphics(gcf,'venditeresidui.pdf')

%% Plot of the original series
nam=yTT.Properties.VariableNames;
stackedplot(yTT,[{nam([1 4])} nam([2:3 5:end])],'FontSize',14);



% Perform Durbin-Watson test on the residuals of the fitted model
 [pvalDW,DW] = dwtest(mdl2,'exact','right');

% Construct the residuala and the matrix X which (which had been used for
% fitting)
residuals=mdl2.Residuals{:,"Raw"};
[pvalDWchk,DWchk]=dwtest(residuals,[ones(T,1) X{:,1:end-1}],"Tail","right");
disp(['Durbin-Watson statistic: ', num2str(DW)]);
disp(['p-value for Durbin-Watson test: ', num2str(pvalDW)]);