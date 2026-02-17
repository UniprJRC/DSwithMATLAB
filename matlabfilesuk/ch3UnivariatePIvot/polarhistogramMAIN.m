load citiesItaly.mat
namevar="addedval";
numberclasses=10;
zone=[repelem("N",46) repelem("CS",57)]';
[X01,C,S]=normalize(citiesItaly,"range");
X02pi=2*pi.*X01.*0.999+1e-10;
edgesPolar=linspace(0,2*pi,numberclasses+1);
trasp=0.2; 
citN=X02pi{zone=="N",namevar};
h1=polarhistogram(citN,edgesPolar,'FaceAlpha',trasp);
hold on
citCS=X02pi{zone=="CS",namevar};
h2=polarhistogram(citCS,edgesPolar,"FaceAlpha",trasp);
set(gca,"ThetaTick",rad2deg(edgesPolar))
edgesOriginal=edgesPolar/(2*pi)*S{:,namevar}+C{:,namevar};
set(gca,'ThetaTickLabel',string(edgesOriginal(1:end-1)));
lege=["North" "Centre and South"];
legend(lege)

%% Standard histogram
figure
Freq=histFS(citiesItaly.addedval,edgesOriginal,zone,lege);
disp([h1.Values' h2.Values' Freq])

%% Example with all default arguments.
figure
load citiesItaly
zone=[repelem("N",46) repelem("CS",57)]';
polarhistogramFS(citiesItaly,'groupvars',zone,'DataVars',1:6);


%% Call with grouping variable and DataVars
zone=[repelem("N",46) repelem("CS",57)]';
polarhistogramFS(citiesItaly,'DataVars',[2 5],'groupvars',zone);


%% Call with grouping variable, DataVars and nbins
zone=[repelem("N",46) repelem("CS",57)]';
polarhistogramFS(citiesItaly,'DataVars',1:4,'groupvars',zone,'nbins',10);


%% Use of FaceAlpha.
polarhistogramFS(citiesItaly,'DataVars',1:4,'groupvars',zone,'nbins',10,'FaceAlpha',0.01);

%% Grouping variable with more than two levels
zone=[repelem("N",46) repelem("C",21) repelem("S",36)]';
polarhistogramFS(citiesItaly,'DataVars',1:4,'groupvars',zone,'nbins',10);


%% Example of  DisplayStyle 'stairs'
zone=[repelem("N",46) repelem("C",21) repelem("S",36)]';
polarhistogramFS(citiesItaly,'DataVars',1:4,'groupvars',zone,'nbins',10,'DisplayStyle','stairs');

%% Example of  DisplayStyle 'stairs' with linewidth
z3=[repelem("N",46) repelem("C",21) repelem("S",36)]';
dv=["addedval" "depos" "pensions" "unemploy"];
polarhistogramFS(citiesItaly,'DataVars',dv,'groupvars',z3,'nbins',10,'DisplayStyle','stairs','LineWidth',2);

%% Example of nbins as a vector
polarhistogramFS(citiesItaly,'DataVars',1:2,'groupvars','','nbins',[1000:1000:5000 30000],'DisplayStyle','stairs','LineWidth',2);

%% Call with grouping variable inside the table
zone=[repelem("N",46) repelem("CS",57)]';
C=citiesItaly;
C.zone=zone;
polarhistogramFS(C,'DataVars',2:5,'groupvars',"zone");


%% Example of the book
figure

zone=[repelem("N",46) repelem("CS",57)]';

polarhistogramFS(citiesItaly,'DataVars',1,'groupvars',zone,'nbins',10,'FaceAlpha',0.2);
title('new')