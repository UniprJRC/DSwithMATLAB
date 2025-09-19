load citiesItaly.mat
% Create keys as strings
nam = string(citiesItaly.Properties.RowNames);
% Create the dictionary
d = dictionary(nam, citiesItaly.unemploy);
disp(d)


% Unemployment rate of novara
d("Novara")

% Unemployment rate of novara using table extraction
unemployNovara = citiesItaly{"Novara", "unemploy"};

disp('---------------------')
disp('Congratulations')
disp('You could run file dictionaryIntro.m')
disp('ENJOY!!!')
disp('---------------------')
