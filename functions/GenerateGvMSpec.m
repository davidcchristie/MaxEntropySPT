function spec2D = GenerateGvMSpec(F0_K1mu1_K2mu2, DirBins)

% ParamSet: [1 F, 2 PSD, 3 MWD(rad), 4 D0, 5 kappa1, 6 mu1, 7 kappa2, 8 mu2]
% D(theta) = exp(kappa1*cos(theta-theta0-mu1)+kappa2*cos(2*theta-theta0-mu2)/D0
ndirbins = length(DirBins);

MU1bar = repmat(F0_K1mu1_K2mu2(:,3), 1, ndirbins);
MU2bar = repmat(F0_K1mu1_K2mu2(:,5), 1, ndirbins); 
KAP1 = repmat(F0_K1mu1_K2mu2(:,2), 1, ndirbins);
KAP2 = repmat(F0_K1mu1_K2mu2(:,4), 1, ndirbins);
THETA = wrapToPi(repmat(DirBins, size(F0_K1mu1_K2mu2,1), 1));
F0 =  repmat(F0_K1mu1_K2mu2(:,1), 1, ndirbins);

spec2D =exp(KAP1.*cos(THETA-MU1bar)+KAP2.*cos(2*(THETA-MU2bar))).*F0;

end
