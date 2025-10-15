% Generate six points along a line with positive slope
x = (1:6)';
y = 2 + 3*x;
% Alter one point to break exact linearity but keep perfect ranking
y(4)=12;
scatter(x,y,'red','filled')
xlabel('x')
ylabel('y')
% Spearman rank correlation
disp('Spearman rank correlation:')
disp(corr(x,y,'Type','Spearman'))
% Pearson linear correlation
disp('Pearson correlation:')
disp(corr(x,y))