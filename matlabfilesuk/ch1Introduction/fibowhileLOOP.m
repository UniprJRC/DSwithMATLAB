n = 10;
f = zeros(1,n);
f(1) = 0; % not necessary
f(2) = 1;
i = 3;
while i <= n
    f(i) = f(i-1) + f(i-2);
    i = i + 1;
end
disp(f)