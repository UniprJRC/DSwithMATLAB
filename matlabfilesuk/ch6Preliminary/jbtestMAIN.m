n = 100;
x = rand(n,1);
z = zscore(x,1);            % population z-scores
AS = sum(z.^3)/n;
KU = sum(z.^4)/n - 3;
jbstatM = n*(AS^2/6 + KU^2/24);
[~,~,jbstat] = jbtest(x);
assert(abs(jbstatM - jbstat) < 1e-15, "Incorrect JB implementation")