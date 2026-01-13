%% Data loading
Y=readtable("DailySeriesGas.xlsx","Sheet","data",'Range','B1:C29');
n=size(Y,1);

% DayOfWeek is a categorical variable
RowTimes=(datetime(2024,2,1):datetime(2024,2,28))';
DayOfWeek=weekday(RowTimes);
% Note that fitlm uses the first category as a reference level, 
% so it does not include the indicator variable for the reference level. 
% In this case the levels are ordered putting Wed in the first position
DayOfWeek=categorical(DayOfWeek, [4:7 1:3], { 'Wed', 'Thu', 'Fri', 'Sat' 'Sun', 'Mon', 'Tue',});

%% Add to table Y the variables Trend and DayOfWeek
Y.Trend=(1:n)';
Y.DayOfWeek=DayOfWeek;

%% Full model with linear trend + sesonality + temperature
out=fitlm(Y,"GasCons","linear");

%% Output of the fit
disp(out)


%% Linear model after excluding the Trend
out1=removeTerms(out,"Trend");
disp(out1)

%% F Test to check for significance of the seasonal component 
% based on difference in residual sum of squares
out2=removeTerms(out1,"DayOfWeek");

numF= (out2.SSE-out1.SSE)/6;
denF=out1.SSE/(n-out1.NumEstimatedCoefficients);
FtestSeasonal=numF/denF;

% p-value of F test  for significance of the seasonal component
pValueSeasonal =fcdf(FtestSeasonal, 6, n - out1.NumEstimatedCoefficients,"upper");

% Display the results of the F-test
fprintf('F-statistic for seasonal component: %.4f\n', FtestSeasonal);
fprintf('p-value for seasonal component: %.4f\n', pValueSeasonal);

%% Alternative way based to compute F test based on function coefTest
C=[zeros(6,2) eye(6)];
[pValueSeasonalCHK, FtestSeasonalCHK,numDF] = coefTest(out1,C);

% Check pValueSeasonal  is equal to pValueSeasonalCHK with assert
tol=1e-10;
assert(abs(pValueSeasonal - pValueSeasonalCHK) < tol, 'p-values do not match');

% Check pValueSeasonal  is equal to FtestSeasonalCHK with assert
assert(abs(FtestSeasonal - FtestSeasonalCHK) < tol, 'F-statistics do not match');


%% Fitted values in the model with temperature and seasonal component
yhat=predict(out1);


% x0 must have the same characteristics 
x0=Y(3,[2 4]);
x0.Temp=15;
yhatx0=predict(out1,x0);

%% Plot of Y.GasCons with predicted values yhat
% Real and predicted values
figure;
plot(RowTimes, Y.GasCons, 'b-', 'DisplayName', 'Original Gas Consumption');
hold on;
plot(RowTimes, yhat, 'r--', 'DisplayName', 'Predicted values');
xlabel('Date');
ylabel('Gas Consumption');
% title('Gas Consumption and Seasonal Adjustment');
legend show;
grid on;
% exportgraphics(gcf,"es1fig.pdf")



%% Seasonal coefficients with sum to zero constraint
% Extract seasonal coefficients with sum to zero constraint
bWED=out1.Coefficients.Estimate(1);

gammahat = [bWED; bWED+out1.Coefficients.Estimate(3:end)]; 
% Adjust seasonal coefficients to ensure they sum to zero
Intercept=mean(gammahat);
% gammastar is bSeasonal of length s with mean(bSeasonal)=0
gammastar = gammahat - Intercept;
% First if bWED and last is bTUE

Temp=zeros(28,1);
X0=table(Temp, DayOfWeek);
Seaso=predict(out1,X0)-mean(gammahat);
% Calculate the seasonal adjusted values after imposing the constraint that
% within each week the sum of the values of the original series equals that
% of the deseasonalised series.
seasonalAdjusted = Y.GasCons - Seaso;

% Alternative way of finding the seasonal component
% using matrix multiplication
Seasochk=dummyvar(DayOfWeek)*gammastar;

%% Plot the original gas consumption series and the seasonal adjusted series
figure;
plot(RowTimes, Y.GasCons, 'b-', 'DisplayName', 'Original Gas Consumption');
hold on;
plot(RowTimes, seasonalAdjusted, 'r--', 'DisplayName', 'Seasonally Adjusted');
xlabel('Date');
ylabel('Gas Consumption');
% title('Gas Consumption and Seasonal Adjustment');
legend show;
grid on;
% exportgraphics(gcf,"es1dest.pdf")