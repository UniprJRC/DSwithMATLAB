% Sample data in a table
load citiesItaly.mat

%% The output of grpstats is very cumbersome
TBL = grpstats(citiesItaly, [], ["mean" "median" "skewness" "kurtosis"]);
disp(TBL)


%% call to grpstatsFS with all default arguments
TBL = grpstatsFS(citiesItaly);
disp(TBL)

%% Add zone to citiesItaly
zone = [repelem("N", 46) repelem("CS", 57)]';
citiesItaly.zone = zone;
TBL = grpstatsFS(citiesItaly, "zone", ["mean" "median"]);
disp(TBL)

%% Use of option plots as a scalar (first example)
TBL = grpstatsFS(citiesItaly, "zone", ["mean" "median" "meanci"], 'Alpha', 0.001, 'plots', 1);
disp(TBL)


%% Use of option plots as a struct 
load citiesItaly.mat
zone=[repelem("N",46) repelem("CS",57)]';
citiesItaly.zone=zone;
plots=struct;
plots.selStats="median";
% Show the two medians 
TBL=grpstatsFS(citiesItaly,"zone",["median" "mean" "var"],'plots',1);

