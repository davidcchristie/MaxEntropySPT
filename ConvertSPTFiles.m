tolerance = 1e-3;
UserSettings;
% addpath([pwd,filesep,'functions']);
addpath('functions');


% Do we keep track of (and output) the validation info?
genValFile = genValidationFile >= 1;

    

% Get list of SPT files
[SPTFileList, SPTFilePath] = GetFileList;

% Location of saved files
OutFilePath = uigetdir(SPTFilePath, 'Please select location for output files');

% Vector of directional bins (in radians)
DirBins = MakeDirBins([ NumberofDirectionalBins, StartDirectionDegrees]);

nfiles = length(SPTFileList);

if genValidationFile == 3
    [target_m1m2n2_all, recalculated_m1m2n2_all] = deal(cell(nfiles,1));
end

tOverall = tic;
% Start to convert spectra
for fileno = 1:nfiles
   
%     disp(['Reading SPT File ', SPTFileList{fileno}]);
    specDW = ReadSPTFile([SPTFilePath, SPTFileList{fileno}]);
    targetMoms = SprSkewKur2Moms(specDW);
    momsOK = KrogstadTest(targetMoms(:,end-2:end));
    if any(~momsOK) 
        warning('Some supplied moments are not moments of a non-negative distribution: will return NaNs');
        targetMoms(~momsOK,:) = NaN;    
    end
    
	OutFileName = strsplit(SPTFileList{fileno}, '.');    
    if genValFile
        tic
        [dirSpec, recalculated_m1m2n2] =  Moments2SpecValidate(targetMoms, DirBins, tolerance);
        timeInSeconds = toc;
        target_m1m2n2 = targetMoms(:,end-2:end);
        if genValidationFile == 2
        save([OutFilePath, filesep, OutFileName{end-1}, '_Validation.mat'], 'target_m1m2n2', 'recalculated_m1m2n2', 'timeInSeconds'); 
        else
            target_m1m2n2_all{fileno} = target_m1m2n2;
            recalculated_m1m2n2_all{fileno} = recalculated_m1m2n2;
        end
            
    else
        dirSpec =  Moments2SpecValidate(targetMoms, DirBins, tolerance);
    end
     if ~mod(fileno, progCountInterval)
         disp(['Writing Output File ', num2str(fileno), ' / ', num2str(nfiles)]);
     end
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



totalTime = toc(tOverall);
if genValidationFile == 1
   save([OutFilePath, filesep, OutFileName{end-1}, 'ValidationAll.mat'], ...
       'target_m1m2n2_all', 'recalculated_m1m2n2_all', 'totalTime', 'nfiles');       
end

disp(['Complete: Generated ', num2str(nfiles), ' directional spectra in ', num2str(totalTime), ' secs.']);
disp('MaxEntropySPT by David Christie, Bangor University d.christie@bangor.ac.uk');


