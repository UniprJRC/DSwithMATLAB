%% Starting matrix
X=[1 1 1 1 1;   
    1 1 1 1 0;   
    0 1 0 1 0;
    1 1 0 1 0;   
    0 0 0 0 0;    
    0 0 0 1 0];
[n,p]=size(X);
rowlab=string(('A':'F')');

disp('Jaccard similarity matrix')
SJ=1-squareform(pdist(X,"jaccard"));
StableJ=array2table(SJ,"RowNames",rowlab,'VariableNames',rowlab);
disp(StableJ)

disp('Sokal-Michener (Hamming) similarity matrix')
SSM=1-squareform(pdist(X,"hamming"));
SSMtable=array2table(SSM,"RowNames",rowlab,'VariableNames',rowlab);
disp(SSMtable)

%% Russel-Rao similarity indices
SRR=zeros(n,n);
for i=1:n
    SRR(i,:)=sum(X(i,:)==1 & X==1,2)/p;
end

% Insert the values 1 in the main diagonal
SRR(logical(eye(n)))=1;

disp('Russel-Rao similarity matrix')
SRRtable=array2table(SRR,"RowNames",rowlab,'VariableNames',rowlab);
disp(SRRtable)


%% pdist with custom function
SRRini=pdist(X,@simfun);
SRRchk=squareform(SRRini);
SRRchk(logical(eye(n)))=1;

function RR = simfun(x1,X)
    p=size(x1,2);
    % RR = column vector of length n, containing the similarity between
    % the vector x1 and the n rows of matrix X
    RR=sum(x1==1 & X==1,2)/p;
end