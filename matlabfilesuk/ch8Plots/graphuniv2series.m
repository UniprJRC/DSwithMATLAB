%% Load data
T = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
Y = T{:,1:2};
months = categorical(T.Properties.RowNames,T.Properties.RowNames);
nr=2; nc=4;

subplot(nr,nc,1)
bar(months,Y)
title('Grouped vertical bars')

subplot(nr,nc,2)
barh(months,Y)
title('Grouped horizontal bars')

subplot(nr,nc,3)
bar(months,Y,'stacked')
title('Stacked bars')

subplot(nr,nc,4)
bar(months,100*Y./sum(Y,2),'stacked')
title('100% stacked bars')

subplot(nr,nc,5)
area(months,100*Y./sum(Y,2))
title('100% stacked area')

subplot(nr,nc,6)
bar3(months,Y)
title('3D bars')

subplot(nr,nc,7)
stairs(months,Y)
title('Stairs')

subplot(nr,nc,8)
bar(months,Y(:,1),0.7,"FaceColor","yellow","FaceAlpha",0.5,...
    "EdgeColor","black","LineWidth",1.5);
hold on
bar(months,Y(:,2),0.25,"FaceColor","red");
legend(["Skis" "Water"+ newline+ "Skis"],'Location','northwest')
title('Custom-colored bars')
