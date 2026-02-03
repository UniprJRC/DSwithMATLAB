load citiesItaly
Xtable=citiesItaly;
% X = numeric matrix without row or column names
X      = table2array(Xtable);
% nameXvars = cell array of variable names
nameXvars = Xtable.Properties.VariableNames;
[n,p]  = size(X);

%% Correlation matrix
Z = zscore(X);              % standardize
R = cov(Z);                 % correlation = covariance of Z
Rtable = array2table(R,'RowNames', nameXvars, 'VariableNames',nameXvars);
format bank
disp(Rtable)

%% Compute the eigenvalues and eigenvectors of R and Y (scores) Y=ZV

%% EIGENDECOMPOSITION OF R
[V,La] = eig(R);
la     = diag(La);
[~, inds] = sort(la,'descend');
V      = V(:,inds);           % reorder eigenvectors
lasor  = la(inds);            % sorted eigenvalues
La     = diag(lasor);

%% COMPUTE PC SCORES
Y = Z * V;                    % principal component scores

%% Now we examine the proportion of variance explained by each PC.
format default
Autoval = [ lasor,  100*(lasor)/p,  100*cumsum(lasor)/p ];
namecols = {'Eigenvalue', 'PctExplained', 'CumPct'};
namePCs  = "PC" + (1:p)';
Autovaltbl = array2table(Autoval, 'RowNames', namePCs, ...
    'VariableNames',namecols);
disp(Autovaltbl)

%% Pareto chart of explained variance :
figure
pareto(Autoval(:,1), namePCs)
xlabel('Principal components')
ylabel('Variance explained (%)')

%% INTERPRETATION OF PCs
Loadings = V * sqrt(La);
Loadings = Loadings(:,1:2);  % only PC1 and PC2
Loadtbl = array2table(Loadings, ...
    'RowNames',     nameXvars, ...
    'VariableNames', namePCs(1:2));
disp('Correlations between original vars and PCs')
disp(Loadtbl)

%% Bar chart of the correlations
figure
for j=1:2
    subplot(2,1,j)
    b=bar(nameXvars, Loadings(:,j),'g');
    title(['Correlations with PC' num2str(j)])
    xtips = b.XEndPoints;
    ytips = b.YEndPoints;
    barlabels = string(round(Loadings(:,j),2));
    text(xtips,ytips,barlabels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
end

%% SUM OF SUARES OF EACH COLUMN OF LOADINGS MATRIX
j = 1;
disp(['Sum of squares of column ' num2str(j) '=' num2str(sum(Loadings(:,j).^2))])
disp(['Eigenvalue ' num2str(j) ' = ' num2str(lasor(j))])


%% COMMUNALITY 
disp('Communalities (variance explained by first 2 PCs):')
Com = sum(Loadings.^2,2);
Comtbl=array2table(Com, 'RowNames',nameXvars, 'VariableNames', {'Communality'});
disp(Comtbl)

%% Loadings as arrows 
figure
% Graphical representation of the correlations between the original
% variables and the first two principal components via vectors (arrows).figure
zeroes = zeros(p,1);
quiver(zeroes,zeroes,Loadings(:,1),Loadings(:,2),0)
% Labels of the arrows
text(Loadings(:,1),Loadings(:,2),nameXvars,...
    'VerticalAlignment','bottom','HorizontalAlignment','center');
% Add axes
xline(0)
yline(0)
xlabel('First PC: Poverty index');
ylabel('Second PC: Business malaise index');
 % Stessa measurement unit on both axes
axis equal


%% Scores (not standardized)
figure
plot(Y(:,1),Y(:,2),'o')
xlabel('First PC: Poverty index');
ylabel('Second PC: Business malaise index');
text(Y(:,1),Y(:,2),Xtable.Properties.RowNames)
xline(0); yline(0)
% print -depsc figs\benessere4.eps;

%% Scores (standardized)

figure
% Yst= componenti principali standardizzate cov(Yst) = matrice identità
Yst=Y*sqrt(inv(La));
plot(Yst(:,1),Yst(:,2),'o')
xlabel('First PC: Poverty index');
ylabel('Second PC: Business malaise index');
 text(Yst(:,1),Yst(:,2),Xtable.Properties.RowNames)
xline(0); yline(0)
% print -depsc figs\benessere5.eps;

%% Biplot (not in the book)
close all
hold('on')
% Rows points using standardized PCA  
plot(Yst(:,1),Yst(:,2),'o')
xlabel('First PC: Poverty index');
ylabel('Second PC: Business malaise index');
 text(Yst(:,1),Yst(:,2),Xtable.Properties.RowNames)
xline(0)
yline(0)

% Arrows to show correlations between variables and PCs
zeroes = zeros(p,1);
quiver(zeroes,zeroes,Loadings(:,1),Loadings(:,2),0)

% Add labels
dx=0.01;
dy=0.01;
text(Loadings(:,1)+dx,Loadings(:,2)+dy,nameXvars,'Color','Blue');

xlabel('First PC: Poverty index');
ylabel('Second PC: Business malaise index');

