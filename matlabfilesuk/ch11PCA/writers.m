% Data loading 
Xtable=readtable('writers.xlsx','ReadRowNames',1,'Sheet','dati', ...
    'Range','A2:G18','VariableNamingRule','preserve');
% call to pcaFS
out=pcaFS(Xtable);
% print -depsc scricor.eps;
% print -depsc scriexp.eps;
% print -depsc scribip.eps;
% print -depsc scribip1.eps;
% print -depsc scrioutliermap.eps;


%% Parallel plot
rownam=Xtable.Properties.RowNames;
Xtt=addvars(Xtable,rownam,'Before',1);
parallelplot(Xtt)

%% 
scatter(Xtable,"X2=read","X5=reread")
text(Xtable{:,"X2=read"},Xtable{:,"X5=reread"},rownam)