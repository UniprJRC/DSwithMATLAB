rng(100)
% n = number of random values to generate
n = 1000;
x = randn(n,1);
% bins = vector containing the bin edges
bins = [-Inf; -2; 0; 1.5; Inf];

%% Frequencies via the histogram function
h = histogram(x, bins);

%% Frequencies via the histcounts function
freqWithHistCounts = histcounts(x, bins);
assert(isequal(freqWithHistCounts, h.Values), "Frequencies via histogram" + ...
    " differ from frequencies via histcounts");

%% Creation of the table with the requested row labels
% rowNames = names of the table rows
rowNames = {'<=-2', '(-2, 0]', '(0, 1.5]', '>1.5'};

FreqTable = array2table(h.Values', 'VariableNames', {'Frequencies'}, ...
    'RowNames', rowNames);
disp(FreqTable)


%% Call to function discretize with 2 3 and 4 input args


%% Discretize with two input arguments

[class_membership] = discretize(x, bins);
disp("First 5 elements of class_membership (2 inputs)")
disp(class_membership(1:5)')
disp('Absolute and percentage frequency distribution')
tabulate(class_membership);


%% Discretize with three input arguments
[class_membership] = discretize(x, bins, 'categorical');
disp("First 5 elements of class_membership (3 inputs)")
disp(class_membership(1:5)')
disp('Absolute and percentage frequency distribution')
tabulate(class_membership);

%% Discretize with four input arguments
rowNames = {'Less than -2', 'Between -2 and 0', 'Between 0 and 1.5', 'Greater than 1.5'};
[class_membership] = discretize(x, bins, 'categorical', rowNames);
disp("First 5 elements of class_membership (4 inputs)")
disp(class_membership(1:5))
disp('discretize with 4 inputs: custom labels')
disp('Absolute and percentage frequency distribution')
tabulate(class_membership);