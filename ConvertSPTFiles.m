tolerance = 1e-3;
UserSettings;
addpath([pwd,filesep,'functions']);




% Get list of SPT files
[SPTFileList, SPTFilePath] = GetFileList;

% Location of saved files
OutFilePath = uigetdir(SPTFilePath, 'Please select location for output files');

% Vector of directional bins (in radians)
DirBins = MakeDirBins([ NumberofDirectionalBins, StartDirectionDegrees]);

nfiles = length(SPTFileList);

tic;
% Start to convert spectra
for fileno = 1:nfiles
    disp(['Reading SPT File ', SPTFileList{fileno}]);
    specDW = ReadSPTFile([SPTFilePath, SPTFileList{fileno}]);
    targMoms = SprSkewKur2Moms(specDW);
    momsOK = KrogstadTest(targMoms(:,end-2:end));
    if any(~momsOK) 
        warning('Some supplied moments are not moments of a non-negative distribution: will return NaNs');
        targMoms(~momsOK,:) = NaN;    
    end

    dirSpec =  Moments2Spec(targMoms, DirBins, tolerance);
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



totalTime = toc;

disp(['Complete: Generated ', num2str(nfiles), ' directional spectra in ', num2str(totalTime), ' secs.']);
disp('MaxEntropySPT by David Christie, Bangor University d.christie@bangor.ac.uk');


