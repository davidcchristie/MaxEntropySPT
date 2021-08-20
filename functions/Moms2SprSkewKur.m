function ParamSet = Moms2SprSkewKur(MomSet)
    
% Converts offset moments to spread (deg), skew and kurtosis

    m1 = MomSet(:, end-2);
    m2 = MomSet(:, end-1);
    n2 = MomSet(:, end);
    
    spr_rad = sqrt(2*(1-m1));
    sig2 = sqrt((1-m2)/2);
    skw = -n2./sig2.^3;
    kur = (6 - 8*m1 + 2*m2)./spr_rad.^4;
    
    ParamSet = MomSet;
    ParamSet(:, end-2) = rad2deg(spr_rad);
    ParamSet(:, end-1) = skw;
    ParamSet(:, end) = kur;


end
