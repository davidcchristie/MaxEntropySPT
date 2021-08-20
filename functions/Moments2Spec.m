function [spec2D, F0_K1mu1_K2mu2] = Moments2Spec(TargSpecMoms, DirBins, tolerance)

% Set defaults for output spectra
if nargin < 3
    tolerance = 0.001;
end

if nargin < 2
    DirBins = MakeDirBins([180 -180]);
end


global SIGrid;  
% This is the 3D interpolation grid set used to find initial guess for GvM
% parameters.  Delaring as global means that you only have to generate it
% once, even if function is called multiple times (eg if you are
% calculating multiple spectra)

% If it hasn't already been generated, do so...
if isempty(SIGrid)
    tic
    disp('Generating interpolation grid for first approximation of GvM parameters...');
    SIGrid = GetInterpGrid;
    toc
end

% Generalied von Mises (GvM) parameters from moments...
F0_K1mu1_K2mu2 = Moms2GvMParams(TargSpecMoms, tolerance);

% 2D Spectrum from the GvM parameters
spec2D = GenerateGvMSpec(F0_K1mu1_K2mu2, DirBins);


end