function spec2D = GvMParams2Spec(ParamSet, DirInfo)

% ParamSet: [1 F, 2 PSD, 3 MWD(rad), 4 D0, 5 kappa1, 6 mu1, 7 kappa2, 8 mu2]
% D(theta) = exp(kappa1*cos(theta-theta0-mu1)+kappa2*cos(2*theta-theta0-mu2)/D0

if nargin<2
    ndirbins = 180;
    startdir = -180;
else    
    ndirbins = DirInfo(1);
    startdir = deg2rad(DirInfo(2));
end

% theta axis
theta =    startdir+ linspace(0, 2*pi, ndirbins+1);
theta(end) = [];
tshift = ParamSet(:,3); % mean wave direction


MU1bar = repmat(ParamSet(:,6)+tshift, 1, ndirbins); %mu1 + theta0 (since theta0 is different for each freq)
MU2bar = repmat(ParamSet(:,8)+tshift, 1, ndirbins); %mu2 + theta0
KAP1 = repmat(ParamSet(:,5), 1, ndirbins);
KAP2 = repmat(ParamSet(:,7), 1, ndirbins);
THETA = wrapToPi(repmat(theta, length(ParamSet), 1));
D0 =  repmat(ParamSet(:,4), 1, ndirbins);

spec2D =exp(KAP1.*cos(THETA-MU1bar)+KAP2.*cos(2*(THETA-MU2bar)))./D0;
end
