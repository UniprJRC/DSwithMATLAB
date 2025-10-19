xi = (1:6)';
ni = [25; 38; 106; 52; 15; 3];
n = sum(ni);
M = sum(xi.*ni)/n;
disp("Arithmetic mean")
disp(M)
disp("Weighted RMS deviation (manual implementation)")
s = sqrt(sum((xi - M).^2 .* ni)/n);
disp(s)

%% Using function std

schk=std(xi,ni);

assert(isequal(s,schk),"Wrong implementation of s")