%% Esercise 1.1

on = [0 1 2];

vn = [0; 1; 2];

mn = [0 1 2; 3 4 5];

nd = 1:2:15;  

%% Esercise 1.2

ot = ["John" "Doe"];

vt = ["John"; "Doe"];

%% Esercizio 1.3
cm=  {1,2,3; "Buongiorno a tutti", rand(3,2),[11; 22; 33]};

%% Esercizio 1.4
st = struct;
st.a = 1;
st.b = 2;
st.c = 3;
st.d = "Buongiorno a tutti";
st.e = rand(3,2);
st.f = [11; 22; 33];

%% 1.5.1 Creazione di una tabella
% Define the data
numericData = (1:10)'; % Numeric data for the first column
stringData = repmat(["LTD"; "LLC"; "PLC"], 4, 1); % Repeat the string values
stringData = stringData(1:10); % Ensure it has exactly 10 entries
booleanData = logical([true; false; true; false; true; false; true; false; true; false]); % Boolean data

% Create the table
T = table(numericData, stringData, booleanData, ...
    'VariableNames', {'NumericColumn', 'StringColumn', 'BooleanColumn'}, ...
    'RowNames', {'CompanyA', 'CompanyB', 'CompanyC', 'CompanyD', ...
                 'CompanyE', 'CompanyF', 'CompanyG', 'CompanyH', ...
                 'CompanyI', 'CompanyJ'});

% Display the table
disp(T);

%% From array to table Exercise 1.5
data = [110.63, 3.7; 736871, 12157];
Summary = array2table(data,"VariableNames",["Acquisti in euro", "Numero visite"], "RowNames", ["Media mensile", "Totale mensile"]);

%% Exercise 1.6
Firm = readtable('Firm.xlsx','Sheet','data','Range','A1:J108', 'ReadRowNames', 0);

Firm = readtable('Firm.xlsx',Sheet='data',Range='A1:J108',ReadRowNames=0)

%% Esercizio 1.7
Firm = readtable('Firm.xlsx',Sheet='data',Range='A1:J108',ReadRowNames=0);
solarray1 = Firm(1:5,7);

soltable1 = Firm.Wage(1:5);

solarray2 = Firm(1:5,[7, 10]);

soltable2 = [Firm.Wage(1:5), Firm.Seniority(1:5)];

Firm = readtable('Firm.xlsx',Sheet='data',Range='A1:J108',ReadRowNames=1);
rowP0219 =Firm('P0219',:);

rowP0219P0476 =Firm({'P0219', 'P0476'},:);



%% Esercise 1.8
subset1 = Firm(Firm.Gender == "F", :);

subset2 = Firm(Firm.Gender == "F" & Firm.Education == "B", :);

subset3 = Firm((Firm.Gender == "F" & Firm.Education == "B") | (Firm.Gender == "M" & Firm.Wage > 4000), :);

subset4 = Firm(Firm.Wage >= 3000 &  Firm.Wage < 3500, :);

%% Section  1.8 saving results
cm = {1,2,3; "Buongiorno a tutti", rand(3,2),[11; 22; 33]};
save('myCell.mat', 'cm');


data = [110.63, 3.7; 736871, 12157];

Summary = array2table(data,"VariableNames",["Acquisti in euro", "Numero visite"], "RowNames", ["Media mensile", "Totale mensile"]);

% save of matrix "data" in ".txt" e in ".xlsx":
writematrix(data,'data.txt','Delimiter','tab');
writematrix(data,'data.xlsx');

% save of "Summary" table in ".txt" e in ".xlsx":
writetable(Summary,'Summary.txt','Delimiter','tab','WriteRowNames',true);
writetable(Summary,'Summary.xlsx','WriteRowNames',true);