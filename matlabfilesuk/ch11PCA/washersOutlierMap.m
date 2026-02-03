%% Creation of outlier map plot
Xt = readtable('washers.xlsx','ReadRowNames',1,'Sheet','data');
Z  = zscore(table2array(Xt));
[U,Gammastar,V] = svd(Z,'econ'); % SVD
la = (diag(Gammastar).^2/(size(Z,1)-1))';

%% Orthogonal distances from PCA subspace of dimension k
k  = 2;
V2 = V(:,1:k);
Score = Z*V2;
Res   = Z - Score*V2';
OD    = sqrt(sum(Res.^2,2));

% Score distances in PCA subspace of dimension k
lak = la(1:k);
SD  = sqrt(sum(Score.^2 ./ lak, 2));

DD     = [OD, SD];
distM  = mahalFS(DD, zeros(1,2), cov(DD));
[~,indsor] = sort(distM, 'descend');
selu   = indsor(1:5);
figure('Name','OutlierMap')
scatterboxplot(SD, OD)
xlabel('Score distance')
ylabel('Orth. dist. from PCA subspace')
names = Xt.Properties.RowNames;
text(SD(selu), OD(selu), names(selu), ...
     'HorizontalAlignment','left', 'VerticalAlignment','bottom');

nl=newline;
text(1.01,0,['Good' nl 'leverage' nl 'points'],'Units','normalized')
text(-0.05,0,['Normal' nl 'units'],'Units','normalized','HorizontalAlignment','right')
text(0.05,-0.05,['Normal' nl 'units'],'Units','normalized','HorizontalAlignment','left')
text(-0.05,1.05,'Orthogonal outliers','Units','normalized','HorizontalAlignment','left')
text(0.95,1.05,'Bad leverage points','Units','normalized','HorizontalAlignment','right')
text(1.01,0.95,['Bad' nl 'leverage' nl 'points'],'Units','normalized','HorizontalAlignment','left')
