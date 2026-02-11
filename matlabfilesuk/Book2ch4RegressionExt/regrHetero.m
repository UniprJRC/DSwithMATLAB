
XX=readtable("regrHetero.xlsx");

%% plot of XX
scatter(XX,"X","y")
xlabel('Income (X)')
ylabel('Expenditure (y)')
exportgraphics(gcf,"etero.pdf")
%%
% Sort rows of XX using "X"
XXsor=sortrows(XX,"X");


% Perform heroskedastic test
n = height(XXsor); % Determine the number of observations
mdl1=fitlm(XXsor,'linear','Exclude',(n/2+1):n);
mdl2=fitlm(XXsor,'linear','Exclude',1:(n/2));
% Compute the ration between sum of squares of residuals
F=mdl2.SSE/mdl1.SSE;

% Compute the p-value of the F test
pValue = fcdf(F, mdl2.DFE, mdl1.DFE,'upper');
