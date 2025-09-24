x = [-3 2 -10 5 20];
pp = [-Inf; 1; 2; Inf];        % norms to compute
norme = zeros(length(pp),1);

for i=1:length(pp)
    norme(i) = norm(x, pp(i));
end

lab = "Norm p=" + string(pp);
normeT = array2table(norme, "RowNames", lab, "VariableNames", "Norme");
disp(normeT)