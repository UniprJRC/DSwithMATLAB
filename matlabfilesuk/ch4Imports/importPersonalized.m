%% Personalized import
filename="FTSeMibTitoliSel.xlsx";
opts=detectImportOptions(filename);
disp(opts.VariableTypes)
preview(filename,opts)

opts.VariableTypes([4 7])={'double'};
Y = readtimetable(filename,opts);
head(Y)
%% Change periodicity: retime and convert2annual 

funzioneRichiesta="max";
Y1=retime(Y,"yearly",funzioneRichiesta);
newDates=dateshift(Y1.Properties.RowTimes,'end','year');
Y1.Properties.RowTimes=newDates;
Y2=convert2annual(Y,'Aggregation',funzioneRichiesta);
assert(isequaln(Y1,Y2),"Conversione diversa")