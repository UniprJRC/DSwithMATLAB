%% Load data
Xtable = readtable('cograd.xlsx','Range','B1:D9','ReadRowNames',true);

% Compute ranks column-wise
Datirank = zeros(size(Xtable));
for j = 1:2
    Datirank(:,j) = tiedrank(Xtable{:,j});
end
disp('Rank matrix:')
disp(Datirank)


%% Spearman correlation
rhoS = corr(X,'Type','Spearman');
disp(rhoS)
rhoSchk = corr(Datirank(:,1),Datirank(:,2));

disp(['Spearman rho via Datirank: ' num2str(rhoSchk)])

%% Alternative ways
rhoS    = corr(Xtable{:,"Movements"},Xtable{:,"Passengers"}, ...
               'Type','Spearman');
disp(['Spearman rho via corr: ' num2str(rhoS)])
