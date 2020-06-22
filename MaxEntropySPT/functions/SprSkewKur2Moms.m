function MomSet = SprSkewKur2Moms(ParamSet)
    
    % Spread, Skew, Kurtosis
    spr_rad = deg2rad(ParamSet(:,end-2));
    skw = ParamSet(:,end-1);
    kur = ParamSet(:,end);
        
    % Mask Bad Data
    
    
    % Convert to Centred Moments m1, m2, n2
    m1 =  1-spr_rad.^2/2;
    m2 = (kur.*spr_rad.^4-6+8*m1)/2;
    sig2_sq = (1-m2)/2;
    n2 = -sig2_sq.^(3/2).*skw;
    
    % Mask bad / pathological data
    DataMask = ones(size(m1));
    DataMask(m1<0 | sig2_sq<0) = NaN;
    

    
    % Return Parameters
    MomSet = ParamSet;
    MomSet(:,end) = real(n2).*DataMask;
    MomSet(:,end-1) = real(m2).*DataMask;
    MomSet(:,end-2) = real(m1).*DataMask;
    MomSet(:,end-3) = deg2rad(ParamSet(:,end-3)).*DataMask;
end
