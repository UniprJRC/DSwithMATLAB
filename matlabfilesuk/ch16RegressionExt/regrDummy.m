XX=readtable("RegrDummy.xlsx");
dummy=XX.Year>=1942 & XX.Year<=1945
% Variable dummy is added to XX before the response
XX=addvars(XX,dummy,'Before','Consumption');
out=fitlm(XX,"Consumption","linear","PredictorVars",["Income" "dummy"]);