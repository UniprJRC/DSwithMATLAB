%% Parametric density estimate
load head.mat
p=size(head,2);
close all

for i=1:p
    nexttile
    histfit(head{:,i})
    title(head.Properties.VariableNames{i},'Interpreter','none')
end
% print -depsc histdens.eps;
pd = fitdist(head{:,1},'Normal')


%% Kernel density estimate
Xt=readtable("Firm.xlsx","ReadRowNames",true);
nomiq=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
Xt=Xt(:,nomiq);
p=size(Xt,2);
figure
tiledlayout
for i=1:p
    nexttile
    histfit(Xt{:,i},[],'Kernel')
    title(Xt.Properties.VariableNames{i},'Interpreter','none')
end

% print -depsc histdensNONPAR.eps;