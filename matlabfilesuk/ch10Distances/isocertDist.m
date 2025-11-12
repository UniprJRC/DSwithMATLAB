%% Original matrix
X = [1.2 2.1; 
    3.4 5.1; 
    1.9 2.2; 
    4.1 2.3; 
    4.2 2.9];
disp(pdist(X))

%% Matrix of Euclidan distances
D=squareform(pdist(X));
nomirighe=string(('A':'E')');

Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)

%% cityblock distances
D=squareform(pdist(X,"cityblock"));
nomirighe=string(('A':'E')');
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)

%% Minkowski with k=3
D=squareform(pdist(X,"minkowski",3));
nomirighe=string(('A':'E')');
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)



