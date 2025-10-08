%% Load data
X = readtable('tagliatelle.xlsx','Sheet','Dati','Range','A1:C41');
disp(head(X,5))

%% Missing-value analysis
Ismis = ismissing(X);
disp('Ismis Boolean matrix (first 5 rows)')
disp(Ismis(1:5,:))

nummissC = sum(Ismis,1);
disp('Missing per variable')
disp(nummissC)

nummissR = sum(Ismis,2);
disp('Missing per row (first 5 rows)')
disp(nummissR(1:5)')

% Listwise deletion
X1 = X;
X1(nummissR>0,:) = [];

% Drop columns with >3 missings
X2 = X;
X2(:,nummissC>3) = [];

disp('Number of rows with any missing')
disp(sum(nummissR>0))

%% Call to function rmmissing
[Rred,TF] = rmmissing(X,2,'MinNumMissing',10);

%% Missing values and outliers report

[n,p] = size(X);
Nmis   = zeros(p,1);
Me     = Nmis;
Stde   = Nmis;
OutLo  = Nmis;
OutHi  = Nmis;
for j=1:p
    xj = X{:,j};
    Nmis(j) = sum(ismissing(xj));
    Me(j)   = mean(xj,'omitnan');
    Stde(j) = std(xj,'omitnan');
    pr = prctile(xj,[25 75]);
    w  = 1.5*(pr(2)-pr(1));
    low = pr(1)-w;
    high= pr(2)+w;
    xnm = xj(~ismissing(xj));
    OutLo(j) = sum(xnm<low);
    OutHi(j) = sum(xnm>high);
end
PercMiss = 100*Nmis/n;
Ma = [Nmis, Me, Stde, Nmis, PercMiss, OutLo, OutHi];
VarNames={'Nmis','Avg','Devstd','Count_miss','Perc_miss','estMin','estMax'};
T = array2table(Ma,'VariableNames',VarNames);
disp(T)

%% mdpattern with tagliatelle.xlsx

X=readtable('tagliatelle.xlsx','Sheet','Dati','Range','A1:C41');
[Mispat,tMisAndOut]=mdpattern(X)
% print -depsc figs\mdpattern.eps;


%% mdpattern with Finance dataset
fn='mdpattern.xlsx'; rg='A1:K10001';
X=readtable(fn,'Sheet','Finance','ReadRowNames',true,'Range',rg);
[MispatF,tMisAndOutF]=mdpattern(X);
% print -depsc figs\mdpattern1.eps;


%% Boxplot and histograms
figure
k=5;
for j=1:k
    Xj=X{:,j};
    subplot(2,k,j)
    Xjsenzamissing=Xj(~ismissing(Xj));
    boxplot(Xjsenzamissing)
    title(X.Properties.VariableNames(j))
    subplot(2,k,j+k)
    histogram(Xjsenzamissing,8)
    title(X.Properties.VariableNames(j))
end


%% with normal curve
figure
k=3;
for j=1:k
    Xj=X{:,j};
    subplot(2,k,j)
    Xjsenzamissing=Xj(~ismissing(Xj));
    boxplot(Xjsenzamissing)
    title(X.Properties.VariableNames(j))
    subplot(2,k,j+k)
    histfit(Xjsenzamissing,10)
    title(X.Properties.VariableNames(j))
end
