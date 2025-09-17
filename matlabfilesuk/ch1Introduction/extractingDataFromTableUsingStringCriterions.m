Firm = readtable('Firm.xlsx','Sheet','data','Range','A1:J108', 'ReadRowNames', 1);
Sur = Firm.Surname;
Nam = Firm.Name;

%% First criterion
boo = startsWith(Sur, "CAS"); % boo is a logical vector
disp(Firm(boo, :))

%% Second criterion
boo = endsWith(Nam, "LA");
disp(Firm(boo, :))

%% Third criterion
pat = "R" + wildcardPattern + ("O");
boo = matches(Nam, pat);
Terzo = Firm(boo, :);
disp(Terzo)

%% Alternative third criterion
miocriterio = startsWith(Nam, "R") & endsWith(Nam, "O");
TerzoBIS = Firm(miocriterio, :);
disp(TerzoBIS)

%% Fourth criterion
pat = "R" + wildcardPattern + ("O"|"A");
boo = matches(Nam, pat);
disp(Firm(boo, :))

%% Fifth criterion
% wildcardPattern(1,5) means between 1 and 5 arbitrary characters
pat = "P" + wildcardPattern(1,5) + ("O"|"A");
boo = matches(Sur, pat);
disp(Firm(boo, :))