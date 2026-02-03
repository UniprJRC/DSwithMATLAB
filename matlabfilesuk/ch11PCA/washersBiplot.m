Xtable=readtable('washers.xlsx','ReadRowNames',true,'Sheet','data');
X      = table2array(Xtable);
[n,p]  = size(X);

Z      = zscore(X);              % standardize
[U,Gammastar,V] = svd(Z,'econ');

% sanity check
maxdiff = max(abs(Z - U*Gammastar*V'),[],"all");
assert(maxdiff<1e-12, ...
    "Reconstruction error: original matrix not recovered")

sqn1   = sqrt(n-1);
Gamma  = Gammastar / sqn1;

% best rank-2 approximation
numcomp = 2;
U2 = U(:,1:numcomp);
V2 = V(:,1:numcomp);
G2 = Gamma(1:numcomp,1:numcomp);
Zhat = sqn1 * U2 * G2 * V2';

rowlabs=Xtable.Properties.RowNames;
varlabs=Xtable.Properties.VariableNames;

%% Biplot: representation A. 
figure; hold('on')
G = sqn1 * U;
plot(G(:,1), G(:,2), 'o')
text(G(:,1), G(:,2), rowlabs)

H = V * Gamma;
zeroes = zeros(p,1);
quiver(zeroes, zeroes, H(:,1), H(:,2))
dx = 0.02; dy = 0.03;
text(H(:,1)+dx, H(:,2)+dy, varlabs, 'Color', 'b');

% Cartesian axes are added
xline(0); yline(0)
title("Representation A.")

%% Biplot: representation B.
figure; hold('on')
G = sqn1 * U * Gamma;
plot(G(:,1), G(:,2), 'o')
text(G(:,1), G(:,2), rowlabs)

H = V;
zeroes = zeros(p,1);
quiver(zeroes, zeroes, H(:,1), H(:,2))
text(H(:,1)+dx, H(:,2)+dy, varlabs, 'Color', 'b');

% Cartesian axes are added
xline(0); yline(0)
title("Representation B.")

%% Dynamic representation with omega and alpha
figure; hold('on')
omega = 0.6; alpha = 0.3;

G = sqn1^omega * U(:,1:2) * Gamma(1:2,1:2)^alpha;
H = V(:,1:2) * (Gamma(1:2,1:2)^(1-alpha)) * sqn1^(1-omega);

plot(G(:,1), G(:,2), 'o')
text(G(:,1), G(:,2), Xtable.Properties.RowNames)
zeroes = zeros(p,1);
quiver(zeroes, zeroes, H(:,1), H(:,2))
varlabs = Xtable.Properties.VariableNames;
text(H(:,1)+dx, H(:,2)+dy, varlabs, 'Color', 'b');

% Cartesian axes are added
xline(0); yline(0)
title(['Dynamic representation: \omega=' num2str(omega) ' \alpha=' num2str(alpha)])