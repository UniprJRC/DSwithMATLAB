% caricamento dati
Xtable=readtable('writers.xlsx','ReadRowNames',1,'Sheet','dati', ...
    'Range','A2:G18','VariableNamingRule','preserve');
% Chiamata della funzione pcaFS
out=pcaFS(Xtable)
% print -depsc scricor.eps;
% print -depsc scriexp.eps;
% print -depsc scribip.eps;
% print -depsc scribip1.eps;
% print -depsc scrioutliermap.eps;
