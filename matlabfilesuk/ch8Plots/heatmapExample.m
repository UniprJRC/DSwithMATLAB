%% X mm of rain
% Call to heatmap input X is a double
% The heatmap has one cell for each value in X.
load rain.mat
heatmap(colNam,rowNam,X)


%% Returns on investments
% call to heatmap input is a table
% The resulting x-axis and y-axis show unique values from the xvar and yvar variables respectively.

load Rend.mat; 
titsel=["ENI" "ASSICURAZIONIGENERALI" "FINECOBANKSPA"];
Rsel=Rt{:,titsel}; % Rsel=array di doubles 
[n,p]=size(Rsel);
% classes for discretize
classi=[-Inf, -0.05 -0.03:0.01:0.03 0.05 +Inf];
T = table('Size',size(Rsel),'VariableTypes',repelem("categorical",p),'VariableNames',titsel);
for j=1:p
    etibin=discretize(Rsel(:,j),classi,'categorical');
    T.(titsel(j))=etibin;
end

i=2;
j=3; 
heatmap(T,i,j)



% print -depsc heatmapTAB.eps;


