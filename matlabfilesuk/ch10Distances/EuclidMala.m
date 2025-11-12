%% Generation of a 300x2 matrix from a bivariate normal distribution
n = 300;
mu = [2;3];
Sigma = [1.2 0.93; 0.93 0.95];
rng(1);
X = mvnrnd(mu, Sigma, n);

% Centroid
cent = mean(X);

% Squared Euclidean distances
d2_Euclidean = sum((X - cent).^2, 2);

% Squared Mahalanobis distances
d2_mahal = mahal(X, X).^2;

% Alternatively using FSDA
S = cov(X);
d2_mahalFSDA = (mahalFS(X, cent, S)).^2;

%% Scatter plot with color depending on d2_Euclidean
scatter(X(:,1), X(:,2), 50, d2_Euclidean, 'o', 'filled');
hb = colorbar;
ylabel(hb, 'Squared Euclidean Distance');
colormap jet;

%% Scatter plot with color depending on d2_Euclidean and equiprobability contours
figure;
scatter(X(:,1), X(:,2), 50, d2_Euclidean, 'o', 'filled');
hb = colorbar; ylabel(hb, 'Squared Euclidean Distance');
colormap jet;
prob = [0.50 0.75 0.95];
hold on;
for j = 1:3
    ellipse(cent, eye(2), prob(j));
end
axis equal;
% print -depsc figs\EuclidMala2.eps;

%% Scatter plot with color depending on d2_mahal
figure
scatter(X(:,1),X(:,2),50,d2_mahal,'o','filled')
hb = colorbar;
ylabel(hb,'Squared Mahalanobis distance')
colormap jet

%% Scatter plot with color depending on d2_mahal and equiprobability contours
figure
scatter(X(:,1),X(:,2),50,d2_mahal,'o','filled')
hb = colorbar;
ylabel(hb,'Squared Mahalanobis distance')
colormap jet

% Overlay ellipses
hold('on')
for j=1:3
    ellipse(cent,S,prob(j))
end
axis equal

% print -depsc figs\EuclidMala4.eps;

%% Correlation between the rankings of the distances
corr([d2_Euclidean d2_mahal],'type','Spearman')
