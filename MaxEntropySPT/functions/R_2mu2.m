function [Vr1, Vr2] = R_2mu2(Lambda1, Gamma1, Psi, V1, V2)
% Multiplies the "vector" (V1;V2) by the rotation matrix R(2*mu2) where mu2
% is Psi+mu1, and the sine and cosine of mu1 are expressed in terms of
% Lambda1 and Gamma1.  Can be used when the inputs are arrays, provided
% they have the same dimensions.
if nargin == 4 && length(V1)==2  % also accepts vector V instead of pair of components V1 and V2
    V2 = V1(2);
    V1 = V1(1);
end

C2 = (Lambda1.^2 - Gamma1.^2)./(Lambda1.^2 + Gamma1.^2); % cos 2*mu1
S2 = 2*Lambda1.*Gamma1./(Lambda1.^2 + Gamma1.^2); % sin 2*mu1

Vr1 = (C2.*cos(2*Psi) + S2.*sin(2*Psi)).*V1 ...
        + (-C2.*sin(2*Psi) + S2.*cos(2*Psi)).*V2;
    
Vr2 = (C2.*sin(2*Psi) - S2.*cos(2*Psi)).*V1 ...
        + (C2.*cos(2*Psi) + S2.*sin(2*Psi)).*V2;

if nargout == 1  % can also generate vector [Vr1; Vr2] instead of separate components
    Vr1 = [Vr1; Vr2]; Vr2 = [];
end

end