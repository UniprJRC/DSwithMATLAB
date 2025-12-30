% Esempi di clustering gerarchico con dataset simulato
rng('default')
% Define the number of units in each group and the dimension p
n1=10; n2=20;
p=2;
X1=randn(n1,p);
dx=5;
X2=dx+randn(n2,p);
% The two groups are combined in a (n1+n2)-by-p matrix;
X=[X1; X2];

subplot(2,2,1)
% Scatter plot with different symbols for the two groups
hold('on')
plot(X1(:,1),X1(:,2),'bx','MarkerFaceColor','b')
plot(X2(:,1),X2(:,2),'rs','MarkerFaceColor','r')

subplot(2,2,2)
% Scatter plot of the two columns of matrix X with
% the addition of the index of each unit
lab=num2str((1:n1+n2)');
plot(X(:,1),X(:,2),'o')
text(X(:,1),X(:,2),lab)

% print -depsc figs\cluster.eps;

%% Hierarchical clustering using Ward method
% Note that this time the input of linkage is the data matrix
% The third argument euclidean could have been omitted
tree = linkage(X,'ward','euclidean');
% cutoff specifies where to cut the dendrogram
cutoff=7;
dendrogram(tree,0,'ColorThreshold',cutoff)
id=cluster(tree,"criterion","distance","cutoff",cutoff);
% Display the frequency distribution of the assignments of the
% units to the different clusters
disp(['Clusters'   '        n_i'     '       100*f_i'])
disp(tabulate(id))
% Display the scatterplot matrix with the indication
% of the group membership for each unit
figure
spmplot(X,id)
%print -depsc figs\cluster1.eps;
%print -depsc figs\cluster2.eps;

%% Part not in the book
% Apply the hierarchical clustering methodology (using the
% average linkage method and the Euclidean distance metric). Build
% the corresponding dendrogram, showing all steps of the
% agglomeration procedure.
% Customize the orientation of the dendrogram and/or the 'ColorThreshold'.
% Hierarchical average linkage method.
figure

% Example: average linkage method ('average')
% Metric used: Euclidean distance
tree = linkage(X,'average');

% Create the dendrogram
% The second argument equal to 0
% specifies that all nodes are displayed
dendrogram(tree,0)
% dendrogram(tree,0,'ColorThreshold',3.5)

% Cut the dendrogram at distance threshold 3.5
group = cluster(tree,'cutoff',3.5,'Criterion','distance');

% FSDA spmplot to visualize the obtained groups
figure
spmplot(X,group);

%% Customized dendrograms
figure
% Customize the orientation of the dendrogram and/or the 'ColorThreshold'.
tree = linkage(X,'average');
H = dendrogram(tree,'Orientation','left','ColorThreshold','default');

% Set the dendrogram line width
set(H,'LineWidth',2)

