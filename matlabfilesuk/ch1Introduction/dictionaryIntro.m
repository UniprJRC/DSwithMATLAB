load citiesItaly.mat
% keys are created in string format
nam=string(citiesItaly.Properties.RowNames);
% Creazione del dictionary
d=dictionary(nam,citiesItaly.unemploy);
disp(d("Novara"))


% Recupero del tasso di disoccupazione di Novare direttamente 
% dalla table citiesItaly tramite i RowNames  
taxDisoccNovara = citiesItaly{"Novara", "unemploy"};