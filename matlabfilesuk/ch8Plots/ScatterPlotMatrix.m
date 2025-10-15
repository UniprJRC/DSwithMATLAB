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

% edu = variabile di raggruppamento
edu=XALLtable.Education;
gplotmatrix(Xd,[],edu)

%% spmplot with grouping variable
overlay=struct;
overlay.type='ellipse';
spmplot(Xt,'dispopt','box','overlay',overlay,'group',edu)

% print -depsc spmplotG.eps;



%% fisheriris with grouping variable
load fisheriris;
% Definisco i nomi delle variabili e li inserisco nella struct plo
plo=struct;
plo.nameY={'SL','SW','PL','PW'};
overlay=struct;
overlay.type='contour';
% Questa volta a spmplot viene passato un'array e non una table di
% conseguenza è necessario dentro plo specificare i nomi delle variabili
spmplot(meas,'group',species,'overlay',overlay,'plo',plo)
% print -depsc spmplotIRIS.eps;

% Osservazione: i gruppi possono essere nascosti/mostrati facendo click
% sulla legenda

%  spmplot(meas,species,plo,'hist');
 
%% Nuovo 'Name',Value typespm dentro spmplot

%% spm triangolare inferiore e numeri sopra la diagonale
typespm=struct;
typespm.upper="number";
spmplot(Xt,"typespm",typespm);

%% spm triangolare superiore e cerchi sotto la diagonale
typespm=struct;
typespm.lower="circle";
spmplot(Xt,"typespm",typespm);

%% spm without diagrams and squares below the main diagonal
typespm=struct;
typespm.upper="none";
typespm.lower="square";
spmplot(Xt,"typespm",typespm);

%% spm  
tipoSPM=struct;
tipoSPM.lower="circle";
spmplot(Xt,'group',edu,'typespm',tipoSPM);



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


%% Con variabile di raggruppamento
load fisheriris;
% Definisco i nomi delle variabili e li inserisco nella struct plo
plo=struct;
plo.nameY={'SL','SW','PL','PW'};
tipoSPM=struct;
tipoSPM.upper="number";

spmplot(meas,'group',species,'plo',plo,'typespm',tipoSPM);

