% Precision threshold for matching the m1, m2, n2 centred moments
tolerance = 1e-3;   

% Progress display every XXX files?
progCountInterval = 50;

% Directional discretisation
NumberofDirectionalBins = 180;
StartDirectionDegrees = -180;

% List frequency and directional bins in additional file?
% 0: No file created.
% 1: File created for first spectral file only.
% 2: File created for every spectral file (duplicate).
BinFileType = 1;

% Validation information required for each file?
% Select:
% 0 for no validation information 
% 1 for single validation Matlab file 
% 2 for separate validation text files
 genValidationFile = 1;
