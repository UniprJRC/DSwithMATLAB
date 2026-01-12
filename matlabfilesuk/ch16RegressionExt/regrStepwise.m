XX=readtable('regrStepwise.xlsx','Sheet','Risposta11','Range','B1:K81');
% Transform reponse with log
XX(:,end)=log(XX(:,end));
out=stepwiselm(XX,'linear','Upper','linear');

% Final regression model after variable selection procedure
disp(out)

%% 

% out=fitlm(XX);

