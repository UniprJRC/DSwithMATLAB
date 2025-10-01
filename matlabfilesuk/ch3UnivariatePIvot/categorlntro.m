% Create a string array of length 10
c = ["School leaving certificate", "High school graduate", ...
     "Bachelor degree", "Master's degree", ...
     "School leaving certificate", "High school graduate", ...
     "Bachelor degree", "Master's degree", ...
     "School leaving certificate", "High school graduate"];

% Define the categories in the desired order
ctgs = ["School leaving certificate", "High school graduate", ...
              "Bachelor degree", "Master's degree"];



%% Creation of categorical vector (without second input argument)
cat = categorical(c);
% The order in which the categories are presented is alphabetical
disp(tabulate(cat))

%% Creation of categorical vector (with second input argument)
cat = categorical(c, ctgs);
% The order in which the categories are presented is that
% of the second input argument of categorical
disp(tabulate(cat))

%% Creation of ordinal categorical vector
cat = categorical(c, 'Ordinal', true);
disp('Categorical vector with unordered categories, min and max are')
[min(cat) max(cat)]

% with second input argument and 'Ordinal', true
cat = categorical(c, ctgs, 'Ordinal', true);
disp('Categorical vector with ordered categories, min and max are')
[min(cat) max(cat)]

%% Function categories shows the categories
ctgs(cat)

%% I cannot add a category that is not predefined
% For example 
% cat(2) = "nnn"
% does not work

%% To add a category if the variable is ordinal categorical
newcat = addcats(cat, "nnn", "Before", "School leaving certificate");
disp(categories(newcat))
