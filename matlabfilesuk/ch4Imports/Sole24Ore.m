%% Cloned folder
% The folder is cloned into the QDV2022 subfolder of the current folder
!git clone https://github.com/IlSole24ORE/QDV2022.git

%% Loading the 2022 dataset
folderName='QDV2022';
fileName='20221213_QDV2022_001.csv';
X22=readtable([folderName filesep fileName]);

%% Creation of the table containing the province x variables data matrix 
Y2=pivot(X22(1:end-1,:),"Rows","DENOMINAZIONECORRENTE","Columns","INDICATORE", ...
    'DataVariable','VALORE','Method','none','RowLabelPlacement','rownames');

%% Downloading 2023 data
!git clone https://github.com/IlSole24ORE/QDV2023.git

%% Loading the 2023 dataset 
folderName='QDV2023';
fileName='20231204_QDV2023_001.csv';
X23=readtable([folderName filesep fileName]);

%% Creation of the table containing the province x variables data matrix 
Y3=pivot(X23,"Rows","DENOMINAZIONECORRENTE","Columns","INDICATORE", ...
    'DataVariable','VALORE','Method','none','RowLabelPlacement','rownames');

%% Downloading 2024 data
!git clone https://github.com/IlSole24ORE/QDV2024.git

%% Loading the 2024 dataset 
folderName='QDV2024';
fileName='20241216_QDV2024_001.csv';
X24ini=readtable([folderName filesep fileName]);
X24=unique(X24ini,"rows");

%% Creation of the table containing the province x variables data matrix 
Y4=pivot(X24,"Rows","DENOMINAZIONECORRENTE","Columns","INDICATORE", ...
    "DataVariable","VALORE",'Method','none','RowLabelPlacement','rownames');

%%
[~, idx] = unique(X24ini, 'rows', 'stable'); % Get unique rows and their indices
duplicatedRows = setdiff(1:height(X24ini), idx); % Find indices of duplicated rows

% Extract duplicated rows
duplicatedTable = X24ini(duplicatedRows, :);
