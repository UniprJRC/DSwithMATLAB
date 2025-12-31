%% Example with elliptical groups and no contamination
rng('default');
mu1    = [2 3];  Sigma1 = [1 1.5; 1.5 3]; n1=300;
Y1     = mvnrnd(mu1,Sigma1,n1);

mu2    = [6 4]; Sigma2 = [1 1.5; 1.5 3];  n2=200;
Y2     = mvnrnd(mu2,Sigma2,n2);

group = ones(n1+n2,1);
group(n1+1:n1+n2)  = 2;

Y = [Y1; Y2];
gscatter(Y(:,1),Y(:,2),group);

% Run k-means and tclust
alpha   = 0;        % trimming fraction
k       = 2;        % number of groups
c       = 10;       % restriction factor for TCLUST
out_Kmeans = tkmeans(Y,k,alpha,'plots',1);
out_Tclust = tclust(Y,k,alpha,c,'plots',1);

%% Example with spherical groups and contamination
% We simulate two circular groups in two variables
rng('default');

mu1    = [2 3]; Sigma1 = diag([0.4,0.4]);  n1=300;
Y1     = mvnrnd(mu1,Sigma1,n1);

Sigma2 = diag([0.6 0.6]);  mu2    = [6 4];   n2=200;
Y2     = mvnrnd(mu2,Sigma2,n2);

% Add concentrated contamination of 50 observations
Sigma0 = diag([0.01 0.01]); muCont = [3,5];  n3 = 50;  
Cont   = mvnrnd(muCont,Sigma0,n3);

group = ones(n1+n2+n3,1);
group((n1+1):(n1+n2)) = 2;
group((n1+n2+1):(n1+n2+n3)) = 0;
Y = [Y1; Y2; Cont];
gscatter(Y(:,1),Y(:,2),group);

% Contamination fraction, slightly inflated (denominator without n3)
alphareal = n3/(n1+n2);

% Classical k-means, but with three groups
out_TKmeans3 = tkmeans(Y,3,0,'plots',1);
% Trimmed k-means, with two groups
out_TKmeans2 = tkmeans(Y,2,alphareal,'plots',1);

% Classical k-means with two groups
out_Kmeans = tkmeans(Y,2,0,'plots',1);

%% Example of monitoring the trimming level
k = 2; c = 2; alpha_vec = 0.00:0.02:0.14;
tclusteda(Y,k,alpha_vec,c,'plots',1);

%% Example of monitoring the restriction factor and the number of groups
cc = [1 2 4 8 16];
outIC = tclustIC(Y,'plots',1,'alpha',0.1,'cc',cc);
