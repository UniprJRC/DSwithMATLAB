% N is the 2x2 frequency matrix for the contingency table
N = [87 188;
    42 406];
% Observed frequency in cell (1,1)
n11 = N(1,1);

% Compute expected frequency for cell (1,1): (row sum * column sum) / total
n11star = sum(N(:,1)) * sum(N(1,:)) / sum(N,"all");

% Difference between observed and expected
diff = n11 - n11star;
diffStr = num2str(diff);

if diff > 0
    disp('Positive association')
    disp(['Difference n11 - n11* = ' diffStr])
else
    disp('Negative association')
    disp(['Difference n11 - n11* = ' diffStr])
end