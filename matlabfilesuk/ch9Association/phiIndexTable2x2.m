%% Input data
Chi2=57.607148359920558;
N= [87 188;
    42 406];

%% phi index using precalculated Chi2 value
sumc=sum(N,1);
sumr=sum(N,2);
n=sum(N,'all');

if det(N)>0
    phi=sqrt(Chi2/n);
else
    phi=-sqrt(Chi2/n);
end

%% phi index using alternative formula
phichk=(N(1,1)*N(2,2)-N(1,2)*N(2,1))/sqrt(prod(sumr)*prod(sumc));
disp(['phi index = ' num2str(phi)])