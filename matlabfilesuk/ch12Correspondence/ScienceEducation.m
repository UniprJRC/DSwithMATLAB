%% Science and Education
X = readtable('science.xlsx','Sheet','data');

Lr={'1NotAtAll' '2SlightlyFav' '3Indiff' '4Fav' '5VeryFav'};
Lc={'1PrimSch' '2MidSch' '3Diploma' '4BachDeg' '5MasterDeg' '6PhD'};

% The 'Name',Value, 'datamatrix',true option makes it possible to specify
% that the input is a data matrix and therefore the routine must
% internally compute the contingency table
format bank
out=CorAna(X(:,1:2),'datamatrix',true,'Lr',Lr,'Lc',Lc);
% print -depsc scienceedu.eps;


%% Alternative way
% Costruzione della tabella pivot
PVT=pivot(X,"Rows","SCIENCE","Columns","EDUCATION",'RowLabelPlacement','rownames');
% Inserimento etichette di riga e colonna nella tabella pivot
PVT.Properties.RowNames=Lr;
PVT.Properties.VariableNames=Lc;
outchk=CorAna(PVT);

%% Moonplot
moonplot(out)
% print -depsc scienceeduMP.eps;

%% Personalized biplot
plots=struct;
plots.alpha='rowgreen';
CorAnaplot(out,'plots',plots)

%% Etichette con colore che dipende dal contributo dei punti alla spiegazione dell'inerzia
plots=struct;
plots.ColorMapLabelCols='CntrbPnt2In'; 
CorAnaplot(out,'plots',plots)
% print -depsc scienceeduCMAP.eps;


%% With conf. ellipses
confellipse=struct;
confellipse.selRows=[1:3 5];
confellipse.selCols=[];
confellipse.conflev=0.91;
CorAnaplot(out,'confellipse',confellipse)
% print -depsc scienzaeduCE.eps;

