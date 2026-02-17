%% Import data
T = readtable("graphuniv.xlsx",'ReadRowNames',true);
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




%%
figure
% Create a tiled layout with 2 rows and 3 columns
tiledlayout('flow');

% Create the first plot
nexttile
bar(cats, y, 'BaseValue', m);
title('Vertical bars');

% Create the second plot
nexttile
barh(cats, y, 'BaseValue', m);
title('Horizontal bars');

% Create the third plot
nexttile
plot(cats, y);
title('Line plot');

% Create the fourth plot
nexttile
area(cats, y);
title('Area plot');

% Create the fifth plot
nexttile
stairs(cats, y);
title('Stairs plot');

% Create the sixth plot
nexttile
stem(cats, y);
title('Stem plot');
sgtitle('With tiledlayout implementation')