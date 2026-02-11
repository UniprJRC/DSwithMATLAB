% Starting contingency table
N=[49	111	13	49; 16	551	241	7; 34	358	30	117];    [I,J]=size(N);

%% Compute matrix P
% n = sample size
n=sum(N,'all');
P = (1/n) * N;

% Verify, via matrix multiplications, that the sum of the elements of $P$
% is equal to 1.
onesI1=ones(I,1); 
onesJ1=ones(J,1); 
sumelP=onesI1'*P*onesJ1;
assert(abs(sumelP-1)<1e-12,"sum not equal to  1")

%%  Compute the matrices of row and column profiles 
ProfilesRows = N./sum(N,2);
ProfilesCols = N./sum(N,1);

%% Compute vectors r and c
r=sum(N,2)/n;
c=(sum(N,1)/n)';

%% Build matrices Dr and Dc
Dr = diag(r);
Dc = diag(c);

%% Alternative computation
cchk=(ProfilesRows')*r;
rchk=ProfilesCols*c;
assert(max(abs(r-rchk))<1e-12,"Error in the computation of r")
assert(max(abs(c-cchk))<1e-12,"Error in the computation of c")

%% Square distance from average profile
distI=mahalFS(ProfilesRows,c',Dc);
distJ=mahalFS(ProfilesCols',r',Dr);

% manual computation of distI without calling mahalFS
distIchk=zeros(I,1);
for i=1:I
    distIchk(i)=sum(  (ProfilesRows(i,:)-c').^2./(c')  );
end
assert(max(abs(distI-distIchk))<1e-12,"Error: the two " + ...
    "inertias are not equal")

%% Total inertica check
inI=sum(distI.*r);
inJ=sum(distJ.*c);
assert(abs(inI-inJ)<1e-12,"Error: the two inertias are not equal")

%% Construction of Z 

% zij = sqrt( (p_{ij} - r_ic_j)^2 /r_ic_j ) =(p_{ij} - r_ic_j)/sqrt(r_ic_j)
Z     =  Dr^(-1/2) * (P - r * c') * Dc^(-1/2);
Zchk   = Dr^(1/2) * (ProfilesRows - onesI1 * c') * Dc^(-1/2); 

assert(max(abs(Z-Zchk),[],'all')<1e-12,"Error in the computation of Z")

intot=sum(Z.^2,'all');
assert(abs(intot-inJ)<1e-12,"Errore di programmazione: le due inerzie non coincidono")

%% SVD of Z

[U,Gam,V] = svd(Z,'econ');

% k = maximum number of latent dimensions
k = min(I-1,J-1);
Gam = Gam(1:k,1:k);
U   = U(:,1:k);
V   = V(:,1:k);





%% Tot in
Gam2 = Gam.^2;

TotalInertia     =  trace(Gam2);
assert(abs(TotalInertia-inI)<1e-12,"Error in the computation of Inertia")

% % TotalInertia = sum_i sum_j (pij - ricj)^2 / ricj = X^2/n
% Chi2stat     = n*TotalInertia;
% 
% Cramer V 
% CramerV = sqrt(Chi2stat/(n*(min(I,J)-1)));

%% Analysis of inertia explained by latent dimensions
cumsumTotalInertia = cumsum(diag(Gam2))/TotalInertia;

InertiaExplained=[diag(Gam) diag(Gam2) diag(Gam2 / TotalInertia) cumsumTotalInertia];
ColNamesSummary={'Singular_values' 'Eigenvalues' 'Var_explained' 'Cum_Var_explained'};
RowNamesSummary="dim_"+(1:k)';
InertiaExplainedtable=array2table(InertiaExplained,'VariableNames', ...
    ColNamesSummary, 'RowNames',RowNamesSummary);
disp(InertiaExplainedtable)

%% Coordinates

% Principal coordinates of the row points
RowsPri     = Dr^(-1/2) * U*Gam;

% Principal coordinates of the column points
ColsPri     = Dc^(-1/2) * V*Gam;

%% Correspondence analysis plot
close all
titl={'Correspondence analysis plot.' , ...
    'Plot of $X=D_r^{-1/2}U \Gamma$ and $Y= D_c^{-1/2} V \Gamma$'};
% Symbols and colors
symbolrows='o'; colorrows='b';
symbolcols='^'; colorcols='r';
MarkerSize=14; hold('on')
plot(RowsPri(:,1),RowsPri(:,2),'LineStyle','none','Marker',symbolrows,'Color', colorrows,'MarkerSize',MarkerSize)
plot(ColsPri(:,1),ColsPri(:,2),'LineStyle','none','Marker',symbolcols,'Color', colorcols,'MarkerSize',MarkerSize)
Lr=["A=Commercial brand" "B=Industrial brand" "C=Indifferent"];
Lc=["Liguria" "Lombardia" "Piemonte" "Veneto"];
dx=0.05;
text(RowsPri(:,1),RowsPri(:,2)+dx,Lr)
text(ColsPri(:,1),ColsPri(:,2)+dx,Lc)

title(titl,'Interpreter','Latex');

s1=sprintf('%5.1f',InertiaExplained(1,3)*100);
s2=sprintf('%5.1f',InertiaExplained(2,3)*100);

FontName='Times';
fsal=12; % Font Size Axes Labels
xlabel(['Dimension 1 (' s1 '%)'],'FontName', FontName, 'FontSize', fsal);
ylabel(['Dimension 2 (' s2 '%)'],'FontName', FontName, 'FontSize', fsal);
axis(gca,'equal')
xline(0); yline(0)
 % print -depsc toothpaste.eps;









%% Contributions
disp("Contributions of the different rows to explaining the first eigenvalue")
disp(RowsPri(:,1).^2.*r/(Gam(1,1)^2))

disp("Contributions of the different rows to explaining the second eigenvalue")
disp(RowsPri(:,2).^2.*r/(Gam(2,2)^2))

disp("Contributions of the different columns to explaining the first eigenvalue")
disp(ColsPri(:,1).^2.*c/(Gam(1,1)^2))

disp("Contributions of the different columns to explaining the second eigenvalue")
disp(ColsPri(:,2).^2.*c/(Gam(2,2)^2))

disp("Relative contributions of the two dimensions to explaining the inertia of each row point")
disp(RowsPri.^2./distI)
disp("Relative contributions of the two dimensions to explaining the inertia of each column point")
disp(ColsPri.^2./distJ)

%% Call to CorAna (not in the textbook)

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

%% Analusys startind directly from Excel file
X=readtable('toothpaste.xlsx','Range','A1:B1177','Sheet','data');
CorAna(X,'datamatrix',true)