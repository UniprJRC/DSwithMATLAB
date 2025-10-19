load car.mat

%% Method 1 

% carNums = numeric matrix of just the data
carNums = car{:,:};
% Initialize the profile tables
ProfileRows = car;
ProfileCols = car;
% Row profiles: divide each row by its sum
ProfileRows{:,:} = carNums ./ sum(carNums,2);
% Column profiles: divide each column by its sum
ProfileCols{:,:} = carNums ./ sum(carNums,1);

%% Method 2
% Note: car ./ sum(car,2) fails because column names differ
ProfileRowsCHK = car ./ sum(carNums,2);
% car and sum(car,1) share column names, so:
ProfileColsCHK = car ./ sum(car,1);

% Show selected cases
disp(ProfileRows("Ferrari",["FuelEconomy" "Performance"]))
disp(ProfileCols("Volvo","Safety"))