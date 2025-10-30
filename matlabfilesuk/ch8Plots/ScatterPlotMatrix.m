% XALLtable = table with all variables
XALLtable = readtable("Firm.xlsx","ReadRowNames",true);
varDaEstrarre = ["Wage" "CommutingTime" "SmartWorkHours" "Seniority"];
% Xd = array with only the quantitative variables
Xd = XALLtable{:,varDaEstrarre};
% Xt = table with only the quantitative variables
Xt = XALLtable(:,varDaEstrarre);

%% 
gplotmatrix(Xd)

%% Call to spmplot
overlay=struct;
overlay.type='ellipse';
spmplot(Xt,'dispopt','box','overlay',overlay)
% Other options of  overlay.type are
% 'contour', 'boxplotb' or 'contourf'

%% Call to corrplot
[R,Pval]=corrplot(Xt,'TestR','on');
% 'corrplot' requires Econometrics Toolbox.

%% spmplot with grouping variable

% edu = grouping variable
edu=XALLtable.Education;
gplotmatrix(Xd,[],edu)

%% spmplot with grouping variable
overlay=struct;
overlay.type='ellipse';
spmplot(Xt,'dispopt','box','overlay',overlay,'group',edu)

% print -depsc spmplotG.eps;



%% fisheriris with grouping variable
load fisheriris;

plo=struct;
plo.nameY={'SL','SW','PL','PW'};
overlay=struct;
overlay.type='contour';
% Note that meas is not a table
% therefore it is necessary to specify the names of the variables
spmplot(meas,'group',species,'overlay',overlay,'plo',plo)

% Remark: show/hide groups clicking on the legends

%  spmplot(meas,species,plo,'hist');
 
%% 'Name',Value typespm dentro spmplot

%% spm with scatter (below the diagonal) and numbers (above the diagonal)
typespm=struct;
typespm.upper="number";
spmplot(Xt,"typespm",typespm);

%% spm with scatter (above the diagonal) and circles below the diagonal
typespm=struct;
typespm.lower="circle";
spmplot(Xt,"typespm",typespm);

%% spm without diagrams and squares below the main diagonal
typespm=struct;
typespm.upper="none";
typespm.lower="square";
spmplot(Xt,"typespm",typespm);

%% spm  
typeSPM=struct;
typeSPM.lower="circle";
spmplot(Xt,'group',edu,'typespm',typeSPM);



%% 
typespm=struct;
typespm.upper='cnumber';
typespm.lower='none';
spmplot(citiesItaly,'typespm',typespm);

%%  with background color 
load citiesItaly2024.mat
citiesItaly2024.Properties.Description
typespm=struct;
typespm.upper='number';
typeepm.lower='scatter';
spmplot(citiesItaly2024,'typespm',typespm,'colorBackground',true, ...
    'order','AOE','nameYlength',5);


%% Con grouping variable
load fisheriris;
plo=struct;
plo.nameY={'SL','SW','PL','PW'};
typeSPM=struct;
typeSPM.upper="number";

spmplot(meas,'group',species,'plo',plo,'typespm',typeSPM);

