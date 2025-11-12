N= [87 188;
    42 406];
n=sum(N,"all");

% sumc (1x2)= marginal freq of cols
sumc=sum(N,1);

% sumr (2x1)= marginal freq of rows
sumr=sum(N,2);

%% Table with theoretical frequencies
Ntheo=(sumr*sumc/n);
disp('Th freq')
disp(Ntheo)

%% Using double for loop
[nr,nc]=size(N);
Ntheochk=zeros(nr,nc);
for i=1:nr
    for j=1:nc
        % theo ij = ni. * n.j/n
        Ntheochk(i,j)=sumr(i)*sumc(j)/n;
    end
end
disp('Using for loop')
disp(Ntheochk)