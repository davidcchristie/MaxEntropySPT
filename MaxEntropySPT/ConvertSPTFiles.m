tolerance = 1e-2;
UserSettings;
addpath([pwd,filesep,'functions']);




% Get list of SPT files
[SPTFileList, SPTFilePath] = GetFileList;

% Location of saved files
OutFilePath = uigetdir(SPTFilePath, 'Please select location for output files');

% Vector of directional bins (in radians)
DirBins = MakeDirBins([ NumberofDirectionalBins, StartDirectionDegrees]);

% Start to convert spectra
for fileno = 1:length(SPTFileList)
    disp(['Reading SPT File ', SPTFileList{fileno}]);
    specDW = ReadSPTFile([SPTFilePath, SPTFileList{fileno}]);
    dirSpec =  Moments2Spec(SprSkewKur2Moms(specDW), DirBins, tolerance);
	OutFileName = strsplit(SPTFileList{fileno}, '.');
    disp('Writing Output File');
    writematrix( dirSpec, [OutFilePath, filesep, OutFileName{end-1}, '_2D.dat']);    
    % Write direction, freq vectors in separate files?
    % BinFileType = 1: only first time; 2: every time
    if BinFileType == 2 || BinFileType * fileno == 1  
    	writematrix( rad2deg(DirBins), ...
            [OutFilePath, filesep, OutFileName{end-1}, '_Dirs.dat']);        
     	writematrix( specDW(:,1), ...
            [OutFilePath, filesep, OutFileName{end-1}, '_Freqs.dat']);            
    end
end








