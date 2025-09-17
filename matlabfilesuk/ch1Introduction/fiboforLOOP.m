% Initialize n and preallocate f
n = 10;
f = zeros(1,n);
% Base cases
f(1) = 0;
f(2) = 1;
% Compute with for loop
for i = 3:n
	f(i) = f(i-1) + f(i-2);
end
disp(f)