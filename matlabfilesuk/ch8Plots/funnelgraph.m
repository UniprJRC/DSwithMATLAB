%% Initial example
x = [4300, 3800, 1400, 150, 100, 50];
categories = {'Initial Applicants', 'Screened Candidates',...
    'After evaluation', 'Offers', 'Hired', 'Onboarded'};
Xtable=array2table(x',"RowNames",categories);
funnelchart(Xtable);

%% Another example
X = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
funnelchart(X);
% print -depsc imbuto.eps;