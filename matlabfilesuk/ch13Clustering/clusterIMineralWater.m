% d = vector containing the upper triangular part of matrix D
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 ...
    0.28 0.31 0.04 0.07 0.31 0.28 0.09];
D=squareform(d);
n=size(D,1);
names=string((1:n)');
Dt=array2table(D,"RowNames",names,"VariableNames",names);

% I insert NaN values on the main diagonal because I need to search
% for the minimum among the values of matrix D excluding the zeros on
% the main diagonal. Boo is a Boolean matrix that contains true for the
% values located on the main diagonal.
Boo=logical(eye(size(D)));
D(Boo)=NaN;

% Find the smallest value of matrix D
minimo = min(D,[],'all');

% indi and indj contain the row and column indices of the distance matrix
% corresponding to the smallest value of D
[indi,indj]=find(D==minimo);
unitAggregated=[indi(1) indj(1)];

disp('At the first step the unit is aggregated')
disp(Dt.Properties.RowNames(unitAggregated(1)))
disp('with the unit')
disp(Dt.Properties.RowNames(unitAggregated(2)))
disp(['at distance level ' num2str(minimo)])

% uniNotAggre is the vector containing the units that have not been aggregated
seq=1:size(D,1);
uniNotAggre=setdiff(seq,unitAggregated);

% D1t = table of size (n-1)x(n-1) that will contain the distances after
% the first aggregation
D1t=Dt;
D1t(unitAggregated(1),:)=[];
D1t(:,unitAggregated(1))=[];
unitCheSiAggreganoLab=string(unitAggregated(2))+...
            ","+string(unitAggregated(1));
D1t.Properties.RowNames(unitAggregated(2))=unitCheSiAggreganoLab;
D1t.Properties.VariableNames(unitAggregated(2))=unitCheSiAggreganoLab;
D1t{unitAggregated(2),:}=0;
D1t{:,unitAggregated(2)}=0;

for i=1:length(uniNotAggre)
    % Take the maximum of the distances between the i-th
    % not-yet-aggregated unit and the pair that has been aggregated
    maxdist=max(D(uniNotAggre(i),unitAggregated));
    % maxdist is inserted into Dtable
    if i<unitAggregated(2)
        D1t{unitAggregated(2),i}=maxdist;
    else
        D1t{unitAggregated(2),i+1}=maxdist;
    end
end
D1t{:,unitAggregated(2)}=D1t{unitAggregated(2),:}';

disp('Distance matrix of size 5x5 after the first aggregation')
disp(D1t)

D3=D1t{:,:};
D3(Boo(1:end-1,1:end-1))=NaN;
minimo = min(D3,[],'all');
[indi,indj]=find(D3==minimo);
unitAggregated=[indi(1) indj(1)];

disp('At the second step the units are aggregated')
disp(D1t.Properties.RowNames(unitAggregated(1)))
disp('with the units')
disp(D1t.Properties.RowNames(unitAggregated(2)))
disp(['at distance level ' num2str(minimo)])

%% Complete linkage method (fully automated)
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 0.28 0.31 0.04 0.07 0.31 0.28 0.09];
names=["1=San Pellegrino" "2=Panna" "3=Rocchetta" "4=Vera"  "5=Levissima" ...
    "6=Fiuggi"];
out=linkage(d,'complete');
dendrogram(out,'Labels',names);
%     print -depsc figs\dendroINI.eps;

%% Average linkage method (fully automated)
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 0.28 0.31 0.04 0.07 0.31 0.28 0.09];
names=["1=San Pellegrino" "2=Panna" "3=Rocchetta" "4=Vera"  "5=Levissima" "6=Fiuggi"];
out=linkage(d,'average');
dendrogram(out,'Labels',names,'Orientation','left');
%     print -depsc figs\dendroINI1.eps;

