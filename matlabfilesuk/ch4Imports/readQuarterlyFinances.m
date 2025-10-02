%% Preview the output of the data loading
myfile="quarterlyFinances1999To2019.csv";
opts = detectImportOptions(myfile);
preview(myfile,opts)

%% Display the loading format of the variables
disp(opts.VariableTypes)

%% detectImportOptions with the 'TrimNonNumeric' option
opts = detectImportOptions(myfile,'TrimNonNumeric',true);
preview(myfile,opts)
disp(opts.VariableTypes)

%% Actual loading
X=readtable(myfile,opts);
head(X,2)