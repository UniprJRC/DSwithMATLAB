%% Data loading
myfile = "Firm.xlsx"; % Load the file Firm.xlsx into MATLAB
X = readtable(myfile,"ReadRowNames",true);

%% Construction of pivot tables using the pivot function

% Variable Gender on the rows (no variable on the columns)
pivot(X,'Rows','Gender')

% The categories of the variable on the rows are inserted as RowNames
pivot(X,'Rows','Gender','RowLabelPlacement','rownames')

% Variable Gender on the rows, variable Education on the columns, frequencies inside
pivot(X,'Rows','Gender','Columns','Education')

% Same as above but with totals added for rows and columns
pivot(X,'Rows','Gender','Columns','Education','IncludeTotals',true)

% Same as above but now the categories of the variable
% on the rows are inserted as RowNames
pivot(X,'Rows','Gender','Columns','Education','IncludeTotals',true, ...
    'RowLabelPlacement','rownames')

% Variable Gender on the rows, variable Education on the columns
% Average wage inside
pivot(X,'Rows','Gender','Columns','Education', ...
    'DataVariable','Wage','Method','mean')

% Same as above but with overall averages added
pivot(X,'Rows','Gender','Columns','Education', ...
    'DataVariable','Wage','Method','mean','IncludeTotals',true)

% Variable Gender on the rows, variable Education on the columns
% Inside both the minimum and the maximum wage
method=@(x)[min(x) max(x)];
pv3=pivot(X,'Rows','Gender','Columns','Education', ...
    'DataVariable','Wage','Method',method);
disp(pv3)

% Wage variable on the rows, Education variable on the columns
% The variable on the rows is divided into 5 classes
pivot(X,'Rows','Wage','Columns','Education','RowsBinMethod',5)

%% Beginning of Exercise 3.12

X1=X; 
X1.Wage(1)=2000;

disp('Pivot table point 1)')
pv1=pivot(X1,'Rows','Wage','Columns','Education', ...
    'RowsBinMethod',1500:500:4500);
disp(pv1)

% To define right-closed classes use 'IncludedEdge'
disp('Pivot table point 2)')
pv2=pivot(X1,'Rows','Wage','Columns','Education', ...
    'RowsBinMethod',1500:500:4500,'IncludedEdge','right');
disp(pv2)

% To define more than one variable on rows or columns
% enter the variable names in a cell array
disp('Pivot table point 3)')
pv3=pivot(X1,'Rows',{'Gender' 'Education'},'Columns','Seniority', ...
    'ColumnsBinMethod',0:15:45);
disp(pv3)

% To define two grouping criteria they must be inserted in a cell array
disp('Pivot table point 4)')
pv4=pivot(X1,'Rows',{'Wage' 'Seniority'},'Columns','Education', ...
    'RowsBinMethod',{1500:1000:4500 0:15:45});
disp(pv4)

%% Section not present in the book
% As an alternative to a cell array, the two grouping criteria can 
% be entered in a string array
pv4chk=pivot(X1,'Rows',["Wage" "Seniority"],'Columns','Education', ...
    'RowsBinMethod',{1500:1000:4500 0:15:45});
assert(isequal(pv4,pv4chk),"Cell array or string array not correct")

%% Section not in the book
% If there is more than one grouping criterion for the rows,
% "RowLabelPlacement","rownames" creates row names that combine the two
% grouping criteria
pv4WithRowNames=pivot(X1,'Rows',{'Gender' 'Education'},'Columns','Seniority', ...
    'ColumnsBinMethod',0:15:45,"RowLabelPlacement","rownames");
disp(pv4WithRowNames)

%% Section included in the book
% If a variable is already qualitative and should not be grouped into
% classes use 'none'
disp('Pivot table point 5)')
pv5=pivot(X1,'Rows',{'Gender' 'Seniority'},'Columns','Education', ...
    'RowsBinMethod',{'none' [0 20 30 45]}, ...
    'DataVariable','Wage','Method','median');
disp(pv5)

%% Beginning of Exercise 3.13

% If there is more than one variable on the columns, MATLAB creates nested 
% tables one inside the other 
disp('Pivot table pv6')
pv6=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min');
disp(pv6)
disp('Variable names of pv6')
disp(pv6.Properties.VariableNames)

% To avoid creating nested tables and concatenate the category names
% of the two variables entered in the columns, you must specify 
% 'OutputFormat','flat'
disp('Pivot table pv7')
pv7=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min','OutputFormat','flat');
disp(pv7)
disp('Variable names of pv7')
disp(pv7.Properties.VariableNames)

%% Section not in the book 
% Adding the option 'RowLabelPlacement','rownames'
pv8=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min','OutputFormat','flat', ...
    'RowLabelPlacement','rownames');
disp(pv8)

%% Pivot tables with Method none (from version 2025a)

close all
myfile="Firm.xlsx";
X=readtable(myfile,"ReadRowNames",true);
groupingVARS={'Gender', 'Education'};
statOfInterest="mean";
varOfInterest="Wage";

Xtab=grpstats(X,groupingVARS,statOfInterest, ...
    "DataVars",varOfInterest);
disp('Input table to be reorganized')
disp(Xtab)

%% Pivot table after reorganization
TBL=pivot(Xtab,'Rows','Gender','Columns','Education','Method','none', ...
    'DataVariable','mean_Wage','RowLabelPlacement','rownames');
disp('Output table')
disp(TBL)
