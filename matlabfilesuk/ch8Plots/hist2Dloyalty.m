%% Scatter + bivariate histograms

load('loyalty.txt');
y = loyalty(:,4);
X = loyalty(:,1:3);
figure;
scatter(X(:,1),y)
xlabel("Number of Supermarket Visits")
ylabel("Amount Spent")
figure
histogram2(X(:,1),y,20)
xlabel("Number of Supermarket Visits")
ylabel("Amount Spent")
zlabel("Frequencies")
% print -depsc LOYhist2D.eps;
% print -depsc LOYscatter.eps;
