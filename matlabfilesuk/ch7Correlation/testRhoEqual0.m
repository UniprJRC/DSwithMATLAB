%% Input data
alpha = 0.01;    % significance level
r     = 0.54;    % sample correlation
n     = 12;

% Compute the test statistic t_r
t_r = (r / sqrt(1 - r^2)) * sqrt(n - 2);

% Critical value for two-sided test
t_crit = tinv(1 - alpha/2, n-2);

disp(['At significance level alpha=' num2str(alpha) ','])
if abs(t_r) > t_crit
    disp('reject the null hypothesis of zero correlation')
else
    disp('fail to reject the null hypothesis of zero correlation')
end

% Compute two-sided p-value
pval = tcdf(abs(t_r), n-2, 'upper') * 2;
disp(['The p-value is: ' num2str(pval)])

% Reminder of assumptions
disp(['This conclusion is valid if the ' num2str(n) ...
      ' observations form a random sample from'])
disp('a bivariate normal distribution.')