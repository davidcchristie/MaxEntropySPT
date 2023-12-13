function [dirSpec, DirBins] = MaxEntropyFromFirstFive(ABMoments, DirBins)
    % Generates maximum entropy distributions from trigonometric moments
    % .
    %
    % Trigonometric moments are defined as:
    % a_n = int(D(theta) cos (n theta) d theta), b_n = int(D(theta) sin (n theta) d theta)
    %
    % Enter then in a 1 x 4 vector or 1 x 5 if you want to inlude a scaling a0
    %
    % The trigonometric moments take the form a1 b1 a2 b2 OR a0 a1 b1 a2 b2
    % a0 is a scaling factor (normalised so that a_0 = 1 if not specified)
    %
    % Directional bins are specified in UserSettings script.
        addpath('functions\');
    UserSettings;
    if nargin<2
        DirBins = MakeDirBins([ NumberofDirectionalBins, StartDirectionDegrees]);
    end
    
    targMoms = ABMoments;
    nCols = size(ABMoments, 2);
    startCol = nCols-3;   % allow for N x 4 OR N x 5 (with a0 for scaling)
    targMoms(:, startCol:nCols) = Moms_2_Offset_Moms(ABMoments(:,startCol:nCols));  
    
    momsOK = KrogstadTest(targMoms(:,end-2:end)); 
    % See documentation for KrogstadTest.  If they don't satisfy the
    % inequalities, then it is not theoretically possible to find a
    % non-negative probability density with these moments, so we don't try!
    if any(~momsOK) 
        warning('Some supplied moments are not moments of a non-negative density: will return NaNs');
        targMoms(~momsOK,:) = NaN;    
    end
    
    dirSpec =  Moments2Spec(targMoms, DirBins, tolerance); 

end
