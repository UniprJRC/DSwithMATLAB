% Data generation
rng default
n1=10;
n2=20;
p=2;
X1=randn(n1,p);
dx=5;
X2=dx+randn(n2,p);

% Combine the two groups into a matrix of size (n1+n2)-by-p
X=[X1; X2];
n=n1+n2;


%% One iteration with  k-means
index = [5 15 25];

% k is fixed a priori
k=3;

% cini = 3-by-p matrix containing
% the initial centroids of the 3 clusters
cini=X(index,:);

D=zeros(n,k);

for j=1:k
    D(:,j)=sum((X-cini(j,:)).^2,2);
end

[dist,ind]=min(D,[],2);

sumd=0;
for j=1:k
    Xj=X(ind==j,:);
    cini(j,:)=mean(Xj);
    sumd=sumd+sum(sum((Xj-cini(j,:)).^2,2));
end

disp('Value of the objective function at the first iteration')
disp(sumd)

%% 10 iterazioni
% index = vettore che contiene gli indici da utilizzare come valori iniziali dei centroidi
index = [5 15 25];
k=length(index);
n=size(X,1);
cini=X(index,:);
D=zeros(n,k);

niter=10;
% Obj = vector containing the value of the objective function at each
% iteration
Obj=zeros(niter,1);

for iter =1:niter
    for j=1:k
        D(:,j)=sum((X-cini(j,:)).^2,2);
    end
    [dist,ind]=min(D,[],2);
    % Recompute the new k centroids
    for j=1:k
        cini(j,:)=mean(X(ind==j,:));
    end

    % sumd = value of the objective function (to be minimized)
    sumd= sum(sum((X-cini(ind,:)).^2,2));
    % The objective function value at iteration iter is stored
    % in position iter of vector Obj
    Obj(iter)=sumd;

end

plot(Obj)
xlabel('Iterations')
ylabel('Value of the objective function')
% print -depsc kmeansINI.eps;


%% Utilizzo funzione kmeans
[idx,cent,sumdj]=kmeans(X,3,"Replicates",100);
% Verify that the second output argument of kmeans
% contains the arithmetic means of the 3 clusters
Centroids=grpstats(X,idx);
assert(max(abs(cent-Centroids),[],"all")<1e-08,'Programming error')
sumd=sum(sumdj);
disp(['The value of the minimized objective function is=' num2str(sumd)])

disp("Cluster centroids")
disp(cent)

% Final classification and centroids
gscatter(X(:,1),X(:,2),idx,'brk','xos',15)
hold('on')
gscatter(Centroids(:,1),Centroids(:,2),1:k,'brk','p',15)
title('Final classification and centroids')
% print -depsc kmeansINI1.eps;

%% Fuction evalclusters
eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',1:6);
figure; plot(eva);
% Retrieve the assignment of units to the different clusters corresponding
% to the optimal value of k
idx=eva.OptimalY; k=eva.OptimalK;
% Compute the centroids
Centroids=grpstats(X,idx);
% Final classification and centroids
figure; gscatter(X(:,1),X(:,2),idx,'br','xo',15)
hold('on')
gscatter(Centroids(:,1),Centroids(:,2),1:k,'brk','p',15)
title('Final classification with optimal k and centroids')
% print -depsc kmeansINI3.eps;


%% Adjusted Rand Index
n1=10; n2=20;
% True partition
idxtrue=[ones(n1,1);2*ones(n2,1)];
Radj=RandIndexFS(idx,idxtrue);
disp("The value of the adjusted Rand index is: "+string(Radj))
