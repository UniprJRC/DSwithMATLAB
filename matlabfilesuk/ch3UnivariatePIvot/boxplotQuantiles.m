%% Data loading

miofile = "Firm.xlsx";
X = readtable(miofile, "ReadRowNames", true);

subplot(1,2,1)
boxplot(X.Wage)
% add2boxplot also accepts a table as input
add2boxplot(X(:, "Wage"))
subplot(1,2,2)
boxplot(X.Wage, X.Gender)
add2boxplot(X(:, "Wage"), X.Gender)

%% Quantile comparison
figure
% boo = logical vector indicating males
boo = strcmp(X.Gender, 'M');

% Alternatively:
% boo = categorical(X.Gender) == "M";

% quan = requested quantiles
quan = 0.1:0.05:0.9;
% Compute quantiles separately for M and F
qM = quantile(X.Wage(boo), quan);
qF = quantile(X.Wage(~boo), quan);
% Plot the quantiles
plot(quan, qM, 'r--*', quan, qF, 'b-o')
legend(["Men" "Women"], 'Location', 'best')

%% violinplot
figure
nameVariable="Wage";
xsel=X{:,nameVariable};
% se withpoints è true nel grafico a violino vengono aggiunti i punti
% relativi alle osservazioni
withpoints=true;
subplot(1,2,1)
violinplot(xsel)

if withpoints==true
    hold('on')
    one=ones(size(X,1),1);
    scatter(one,xsel)
end

subplot(1,2,2)
violinplot(categorical(X.Gender),xsel)

if withpoints==true
    hold('on')
    % Osservazione: dato che quando trasformo la variabile in
    % categorica le modalità sono inserite in ordine alfabetico, il
    % primo violinplot si riferisce alla modalità F
    boo=X.Gender=="F";
    % punti relativi alle donne
    scatter(one(boo,1),xsel(boo))
    % punti relativi agli uomini
    scatter(2*one(~boo,1),xsel(~boo))
end
% L'istruzione sgtitle inserisce un title
% sopra la griglia dei subplots
sgtitle(nameVariable)


