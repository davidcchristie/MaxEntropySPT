[flist,floc] = uigetfile('*.zip', 'MultiSelect', 'on');
backDir = pwd;
cd(floc);
for fno = 1:length(flist)
    system(['tar -xf "', flist{fno},'"']);
end
cd(backDir);