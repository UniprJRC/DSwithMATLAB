%% Loading the content of the file Firm.xlsx as timetable
TT=readtimetable('Firm.xlsx');
head(TT,3)

%% Loading the content of the file Firm.xlsx as table and converting to timetable
Xt=readtable('Firm.xlsx');
TT=table2timetable(Xt);

%% Record extraction (first criterion)
sel=timerange('1996-12-05','1998-06-01');
TT(sel,:)

%% Part not in the book
sel=timerange('-inf','1998-06-01');
% means all dates before June 1, 1998

%% Part not in the book
% The two dates to be inserted into timerange, instead of being defined as
% characters, could have been introduced via datetime(Y,M,D)
sel=timerange(datetime(1996,12,05),datetime(1998,06,01));
TT(sel,:)

%% Record extraction (second criterion)
sel2=timerange('1999','2001','years');
TT(sel2,:)

%% Extracting a date interval with units of months
timerange(datetime(2022,15,1),datetime(2023,11,4),'months')

%% Record extraction (Exercise 4.4)

% boolean for the required years
anni=TT.Properties.RowTimes.Year >=1995 &  TT.Properties.RowTimes.Year  <=1999;
% boolean for the required months
mesi= TT.Properties.RowTimes.Month>=3 & TT.Properties.RowTimes.Month<=4; 
% boolean for the required days
giorni=TT.Properties.RowTimes.Day >=20;
% The three criteria are combined using logical AND operator
disp(TT(anni & mesi & giorni,1:4))

%% Additional examples with timerange (NOT INCLUDED IN THE BOOK)

% Example of a date passed as a string with recognized format
TR      = timerange("2016-01-01","2022-12-31")

% Example of a date passed as a string with unrecognized format
% Since the format "01-01-2016" is not recognized
% it is necessary to convert the string with datetime
TR      = timerange(datetime("01-01-2016","InputFormat","dd-MM-yyyy"), ...
    datetime("31-12-2022","InputFormat","dd-MM-yyyy"))

% Example of a string containing a non-unique date
% In this case MATLAB provides a warning
% The dates are ambiguous. MATLAB assumes the format is MM/dd/yyyy
% but warns that the format could also be 'dd/MM/yyyy'
TR=timerange("02/01/2016","11/12/2022");

%% Example of ambiguous string
% Is the date February 1, 2016 or
% January 2, 2016?
stringContainingDate="01/02/2016";
disp('Unclear date')
disp(stringContainingDate)
disp('Conversion with the format "dd/MM/yyyy"')
ini1=datetime(stringContainingDate,'InputFormat',"dd/MM/yyyy");
disp(ini1)
disp('Conversion with the format "MM/dd/yyyy"')
ini2=datetime(stringContainingDate,'InputFormat',"MM/dd/yyyy");
disp(ini2)

%% Remark 
% In the numbers passed to datetime with the format t = datetime(Y,M,D)
% the datetime help says: 
% "If an element of the Y, M, D, falls outside the conventional range, 
% then datetime adjusts both that element and the same element of the previous input."

% This means that it is possible (for example) in the second argument
% to write a value greater than 12
Y=2022;
M=16;
D=3;
disp(['Y=' num2str(Y) ' M=' num2str(M) ' D=' num2str(D)])
disp([' The syntax datetime(2022,16,3) ' ...
    'corresponds to April 3, 2023'])
disp(datetime(Y,M,D))

% Similarly, I can write for D a number greater than 31. 
% For example, datetime(2023,2,50) corresponds to 22-Mar-2023
