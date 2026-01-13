XX=readtable("meat.xlsx","Range","C1:F21","Sheet","data", ...
    'VariableNamingRule','preserve');
out=fitlm(XX);
disp(out)
%% Heteroskedasticity test 

n = height(XX);
model1=fitlm(XX,'Exclude',((n/2)+1):n);
model2=fitlm(XX,'Exclude',1:(n/2));

rssFirstHalf = sum(model1.Residuals.Raw(1:(n/2)).^2);
rssSecondHalf = sum(model2.Residuals.Raw(((n/2)+1):n).^2);
F=rssFirstHalf/rssSecondHalf;
% Compute p value of F stat
pValue = 1 - fcdf(F, model1.DFE, model2.DFE);

% Display the results of the heteroskedasticity test
fprintf('F-statistic: %.4f\n', F);
fprintf('p-value: %.4f\n', pValue);

%% Durbin Watson test
[pvalDW,testDW]=dwtest(out,'exact');
% Display the results of the Durbin-Watson test
fprintf('Durbin-Watson test statistic: %.4f\n', testDW);
fprintf('p-value for Durbin-Watson test: %.4f\n', pvalDW);

%% Linear restriction
C = [0 -1 0 1]; % Define the restriction matrix
c=2;
[pvalH0,FtestH0]=coefTest(out,C,c);
% Display the results of the linear restriction test
fprintf('F-test for linear restriction beta3-beta1=2: %.4f\n', FtestH0);
fprintf('p-value for linear restriction beta3-beta1=2: %.4f\n', pvalH0);



    

