%% Data loading
XX=readtable("beer.xlsx","Range","A1:F31","Sheet","data","ReadRowNames",true);
head(XX,2)

%% yXplot
XX.DayOfTheWeek=categorical(XX.DayOfTheWeek);
XX.Location=categorical(XX.Location);
yXplot(XX(:,1),XX(:,2:end))
% exportgraphics(gcf,"beeryXplot.pdf")
%% Multiple regression model
mdl=fitlm(XX,"LitersOfBeer");
disp(mdl)

%% Remove Location
mdl1=removeTerms(mdl,"Location");
disp(mdl1)

%% Test that beta size and beta taps are zero
C=zeros(2,4);
C(1,2)=1;
C(2,3)=1;

[pval,Ftest]=coefTest(mdl1,C);

% Display the p-value and F-test statistic
fprintf('p-value: %.16f\n', pval);
fprintf('F-test statistic: %.4f\n', Ftest);

%% Application of stepwise procedure
stepwiselm(XX,"LitersOfBeer")


%% Plot of residuals against fitted values
% Simple: residuals vs fitted using plotResiduals
plotResiduals(mdl1,'fitted','ResidualType','studentized');
xlabel('Fitted values');
ylabel('Deletion residuals');

% exportgraphics(gcf,"appesaprpom6.pdf")

%% Prediction
% Define new data for prediction
x0=XX(4,2:4);
x0.Size_m_2_=2000;
x0.NumberOfTaps=5;
% Make predictions using the fitted model
[predictedLiters,predCI] = predict(mdl1, x0,"Alpha",0.01,"Prediction","Observation");
fprintf('Predicted Liters of Beer: %.4f\n', predictedLiters);
% Display the prediction confidence intervals
fprintf('99 per cent pediction Confidence Interval:\n [%.4f, %.4f]\n', predCI(1), predCI(2));

