COO=readtable("CoordGeogProvince.xlsx",'ReadRowNames',true);
load citiesItaly.mat
CIT=citiesItaly;

nam=CIT.Properties.RowNames;
[~,ind]=sort(nam);
CITord=CIT(ind,:);

% Alternative way of ordering according to RowNames
CITORDchk=sortrows(CIT,"RowNames");
assert(isequal(CITord,CITORDchk),"Different ordering")


% Add to COO variable addedval 
COO.addedval=zscore(CITord.addedval);

geobubble(COO,"LAT","LONG",'Basemap','streets','SizeVariable','addedval')
