% 
n = 1e6;
myKeys = "ID" + string(1:n)';
myValues = randn(n,1);
nkey = 1000;
keysToSearch = randsample(myKeys, nkey);

% Dictionary
tic
dict = dictionary(myKeys, myValues);
tDictCreate = toc;
tic
outDict = dict(keysToSearch);
tDictLookup = toc;

% Table 2-column
tic
T2 = table(myKeys, myValues);
tT2Create = toc;
tic
outT2 = zeros(nkey,1);
for k=1:nkey
	idx = strcmp(T2.myKeys, keysToSearch(k));
	outT2(k) = T2.myValues(idx);
end
tT2Lookup = toc;

% Table 1 column with RowNames
tic
T1 = table(myValues, 'RowNames', myKeys);
tT1Create = toc;
tic
outT1 = T1{keysToSearch,1};
tT1Lookup = toc;

% Verify equality
assert(max(abs(outDict-outT2))<eps);
assert(max(abs(outT2-outT1))<eps);

disp(['Dictionary create: ' num2str(tDictCreate) ' s'])
disp(['Dictionary lookup: ' num2str(tDictLookup) ' s'])
disp('---')
disp(['Table(2col) create: ' num2str(tT2Create) ' s'])
disp(['Table(2col) lookup: ' num2str(tT2Lookup) ' s'])
disp('---')
disp(['Table(1col) create: ' num2str(tT1Create) ' s'])
disp(['Table(1col) lookup: ' num2str(tT1Lookup) ' s'])