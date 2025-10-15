%% Data loading
X=readtable("regions.xlsx",'ReadRowNames',true);

%% bubblechart with 3 variabbles (without colorbar)
% Bubble chart 
bubblechart(X,"PassRate","EnrollmentRate","Residents")
names=X.Properties.RowNames;
% Add labels
text(X.PassRate,X.EnrollmentRate,names)

%% bubblechart with 4 variables (with colorbar) 
% Color gradient based on out-of-region enrollment
figure
outRE="OutOfRegionStudents";
% bubblechart with 4 input arguments
bubblechart(X,"PassRate","EnrollmentRate","Residents",outRE)
c=colorbar;
c.Label.String = outRE;
text(X.PassRate,X.EnrollmentRate,names)