%% toothpaste example

N=[49	111	13	49
    16	551	241	7
    34	358	30	117];
[I,J]=size(N);

Lr=["A=Commercial brand" "B=Industrial brand" "C=Indifferent"];
Lc=["Liguria" "Lombardia" "Piemonte" "Veneto"];

Ntable=array2table(N,"RowNames",Lr,"VariableNames",Lc);
out=CorAna(Ntable);

CorAnaplot(out)

%% Call to moonplot
moonplot(out)

%% Analisi partendo direttamente dal file di Excel
X=readtable('toothpaste.xlsx','Range','A1:B1177','Sheet','data');
CorAna(X,'datamatrix',true)


%% JRC dataset 
load clothes.mat
out=CorAna(clothes)

%% car dataset
load car
CorAna(car)


