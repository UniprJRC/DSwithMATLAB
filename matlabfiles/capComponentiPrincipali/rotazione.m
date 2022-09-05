% Componenti principali come rotazione degli assi cartesiani

%% Diagramma di dispersione, ellisse di confidenza e assi dell'ellisse
close all
clear
% Dati caricati in formato table
Xtable=readtable("SpesaFatt.xlsx");
% X matrice dei dati
X=Xtable{:,:};
n=size(X,1);
X1=X(:,1);
X2=X(:,2);
% Vettore riga delle medie aritmetiche
meaX=mean(X);
% Matrice degli scostamenti dalla media
Xtilde=X-meaX;
% S = matrice di covarianze
S=Xtilde'*Xtilde/(n-1);


% Analisi in componenti principali

% Autovalori ed autovettori di S
[Vini,Lambdaini]=eig(S);

[~,ord]=sort(diag(Lambdaini),'descend');
% Lambda contiene sulla diagonale, gli
% autovalori ordinati in senso decrescente
Lambda=Lambdaini(ord,ord);
% V contiene i corrispondenti autovettori
V=Vini(:,ord);
% pendenza ed intercetta della retta principale
bprinc=-V(1,2)/V(2,2);
aprinc=meaX(2)-bprinc*meaX(1);

% Punti originari ed ellisse
plot(X1,X2,'o')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
hold('on')
axis equal
Ell= ellipse(meaX,S,1);
% print -depsc figs\rotazione1.eps;
%% Calcolo in maniera numerica lunghezza semisse
% Trasformo le coordinate dell'ellisse in un poligono
ellp=polyshape(Ell);

disp(['Area dell''ellisse: ' num2str(area(ellp))])
disp(['Perimetro dell''ellisse: ' num2str(perimeter(ellp))])

% gamma1 = lunghezza asse maggiore ellisse 
gamma1=sqrt(Lambda(1,1));
% gamma2= lunghezza asse minore ellisse
gamma2=sqrt(Lambda(2,2));
% Perimetro dell'ellisse
disp(pi*(3*(gamma1+gamma2)-sqrt((3*gamma1+gamma2)*(gamma1+3*gamma2))))

pi*sqrt(2*(gamma1^2+gamma2^2))
% e= eccentricità dell'ellisse
e=sqrt(1-(gamma2/gamma1)^2);
h=(gamma1-gamma2)^2/((gamma1+gamma2)^2);
pi*(gamma1+gamma2)*(1+3*h/(10+sqrt(4-h)))


% Coordinate x e y della retta principale
xcoo=(min(X1):0.01:max(X1))';
ycoo=aprinc+bprinc*xcoo;
% Trovo l'intersezione tra la retta principale e l'ellisse
[in,out]=intersect(ellp,[xcoo ycoo]);
disp("Lunghezza del semiasse principale dell'ellisse")
disp("ottenuta in maniera numerica")
% in(end,:) contiene le coordinate dell'ultimo punto della retta
% che si trova dentro l'ellisse
% lunSemiAxis contiene la lunghezza del semiasse
lunSemiAxis=norm(in(end,:)-meaX);
% La norma poteva anche esser calcolata come segue
% sqrt(sum((in(end,:)-meaX).^2))
disp(lunSemiAxis)

%% Rappresentazione dei punti nella base canonica e_1 e e_2
plot(X1,X2,'o')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
hold('on')

Ell= ellipse(meaX,S,1);
axis equal
[in]=inpolygon(X1,X2,Ell(:,1),Ell(:,2));
seq=1:n;
textOut=string(seq(~in));
text(X(~in,1),X(~in,2),textOut)

%% Rappresentazione dei punti in termini di scostamenti dalla media
% Punti nella base canonica e_1 e e_2
figure
Xtilde1=Xtilde(:,1);
Xtilde2=Xtilde(:,2);

plot(Xtilde1,Xtilde2,'o')
xlabel('$\tilde X_1= X_1-\overline x_1$','Interpreter','latex')
ylabel('$\tilde X_2=X_2-\overline x_2$','Interpreter','latex')
hold('on')
Ell= ellipse(0,S,1);
axis equal
[in]=inpolygon(Xtilde1,Xtilde2,Ell(:,1),Ell(:,2));
seq=1:n;
textOut=string(seq(~in));
text(Xtilde1(~in),Xtilde2(~in),textOut)
 % print -depsc figs\rotazione2.eps;
%% Rappresentazione dei punti nel nuovo sistema di assi cartesiani (PC)
figure
Y=Xtilde*V;
plot(Y(:,1),Y(:,2),'o')
hold('on')
Ellr= ellipse(0,Lambda,1);
xlabel('$Y_1$=Prima componente principale','Interpreter','latex')
ylabel('$Y_2$=Seconda componente principale','Interpreter','latex')

[in]=inpolygon(Y(:,1),Y(:,2),Ellr(:,1),Ellr(:,2));
seq=(1:size(X,1))';
textOut=string(seq(~in));
text(Y(~in,1),Y(~in,2),textOut)
axis equal
 % print -depsc figs\rotazione3.eps;
%% Rappresentazione dei punti nello spazio delle PC standardizzate
figure
Yst=zscore(Y);
plot(Yst(:,1),Yst(:,2),'o')
hold('on')
Ellr= ellipse(0,eye(2),1);
xlabel(['$Y_1\sqrt \lambda_1 $=Prima componente principale ' ...
    'standardizzata'],'Interpreter','latex')
ylabel(['$Y_2 \sqrt \lambda_2$=Seconda componente principale' ...
    ' standardizzata'],'Interpreter','latex')

[in]=inpolygon(Yst(:,1),Yst(:,2),Ellr(:,1),Ellr(:,2));
textOut=string(seq(~in));
text(Yst(~in,1),Yst(~in,2),textOut)
axis equal
 % print -depsc figs\rotazione4.eps;

 % Mostro 
 Gamma=sqrt(Lambda);
 gamma1=Gamma(1,1);
 gamma2=Gamma(2,2);
 disp('Lunghezza semiasse maggiore (valore esatto) gamma_1')
 disp(gamma1);
disp("Area dell'ellisse (valore esatto): pi*gamma1*gamma2i")
 disp('Lunghezza semiasse maggiore (valore esatto)')
 disp(pi*gamma1*gamma2);
disp("Perimetro dell'ellisse (formula approssimata)")
disp(2*pi*sqrt((gamma1(1)^2+gamma1(2)^2)/2))

