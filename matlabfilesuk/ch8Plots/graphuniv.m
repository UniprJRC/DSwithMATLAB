%% Import data
T = readtable("grafuniv.xlsx",'ReadRowNames',true);
labels = T.Properties.RowNames;
y    = T{:,1};
cats = categorical(labels,labels);

m = mean(y);

subplot(2,3,1)
bar(cats,y,'BaseValue',m)
title('Vertical bars')

subplot(2,3,2)
barh(cats,y,'BaseValue',m)
title('Horizontal bars')

subplot(2,3,3)
plot(cats,y)
title('Line plot')

subplot(2,3,4)
area(cats,y)
title('Area plot')

subplot(2,3,5)
stairs(cats,y)
title('Stairs plot')

subplot(2,3,6)
stem(cats,y)
title('Stem plot')




