function [moms, J] = MomsAndJacobianFlexi(K1K2Psi, trunc, GetLoc)
% Returns moments m1, m2, n2 of GvM distribution with parameters k1, k2 and Psi.
% If k1, k2 and Psi are vectors, returns nk1 x nk2 x nPsi grids of values
% in a struct.
% If called with two outputs, returns the Jacobian of the transformation
% between moments and GvM parameters (for Newtonian iteration)

if nargin < 2
        trunc = 50;
    end
    
% This function can also be used to find the location parameters mu1 and
% mu2 from the k1, k2, Psi values (if GetLoc is true).  In which case, it
% simply returns these two quantities.
    if nargin < 3  
        GetLoc = false;
    end
    
    MakeGrid = iscell(K1K2Psi);
    
    if MakeGrid
        kappa1 = K1K2Psi{1};
        kappa2 = K1K2Psi{2};
        Psi = K1K2Psi{3};
    else
        kappa1 = K1K2Psi(1);
        kappa2 = K1K2Psi(2);
        Psi = K1K2Psi(3);
    end
%     D0
    
%     D0 and its derivatives

% % % %     D0 = D0_and_derivatives_full(K1K2Psi,[0 0 0], trunc);
    D0 = BesselSeries([0 0 0], trunc);
    % Evaluate Lambdas
    
    Lambda1 = BesselSeries([1 0 0], trunc)./D0;
    Lambda2 = BesselSeries([0 1 0], trunc)./D0;
    
    % Evaluate Gammas
    Gamma1 = -BesselSeries([-1 0 1], trunc)./D0;
    Gamma2 = BesselSeries([0 -1 1], trunc)./D0;
    
    [KAPPA1, KAPPA2, PSI] = ndgrid(kappa1, kappa2, Psi); 
            % Same dimensions as inputs (even if they're just scalars)
    % Evaluate Moments
    m1 = sqrt(Lambda1.^2 + Gamma1.^2);
    
    if GetLoc
        mu1 = atan2(-Gamma1, Lambda1);
        mu2 = Psi + mu1;
        moms = [mu1, mu2, D0*exp(kappa1)*exp(kappa2)]; % exp term due to scale factor in besseli(nu,k, 1)
        return
    end
    
    [m2,  n2] = R_2mu2(Lambda1, Gamma1, PSI, Lambda2, Gamma2);

    

    if MakeGrid
        moms = struct('kappa1',kappa1,'kappa2',kappa2,'Psi',Psi,...
            'M1',m1,'M2',m2,'N2',n2, 'KAPPA1', KAPPA1, 'KAPPA2', KAPPA2,...
            'PSI', PSI);
    else
        moms = [m1, m2, n2];
    end
    
    if nargout == 2 && ~ MakeGrid  %
    
    
    % Derivatives of each Lambda
    Lambda1_kappa1 = -Lambda1^2 + BesselSeries([2 0 0], trunc)/D0 + 1/2;
    Lambda2_kappa2 = -Lambda2^2 + BesselSeries( [0 2 0], trunc)/D0 + 1/2;
    
    

 

    [Lambda1_kappa2, Lambda2_kappa1] = deal(-Lambda1*Lambda2 + ...
        BesselSeries( [1 1 0], trunc)/D0);
	Lambda1_Psi = Lambda1*Gamma1*kappa1 + BesselSeries([-1 0 1], trunc)/D0...
        + kappa1*BesselSeries([-2 0 1], trunc)/D0;
    
    

    Lambda2_Psi = -2*Lambda2*Gamma2*kappa2 +...
        2*BesselSeries([0 -1 1], trunc)/D0 +...
        2*kappa2*BesselSeries([0 -2 1], trunc)/D0;    

%     % Derivatives of each Gamma
    Gamma1_kappa1 = - Gamma1*Lambda1 - BesselSeries([-2 0 1], trunc) /D0;
   
   

    
    Gamma1_kappa2 = - Gamma1*Lambda2 - BesselSeries([-1 1 1], trunc) /D0 ; 


    Gamma1_Psi = kappa1*Gamma1^2 - kappa1*BesselSeries([2 0 2], trunc) /D0...
        + kappa1*BesselSeries([0 0 2], trunc) /(2*D0)...
        - BesselSeries([1 0 2], trunc) /D0;     
    
  
    %        Gamma2_kappa1 = - Gamma2*Lambda1 ...
%         + D0_and_derivatives_full(K1K2Psi, [1 0 1], trunc)/(2*D0*K1K2Psi(2)); 
    
    Gamma2_kappa1 = - Gamma2*Lambda1 + BesselSeries([1 -1 1], trunc)/D0;
    
    

    Gamma2_kappa2 = BesselSeries([0 -2 1], trunc)/D0 - Gamma2*Lambda2;
   
   

    Gamma2_Psi = -2 * kappa2*Gamma2^2 + 2 * kappa2* BesselSeries([0 2 2], trunc)/D0 ...
        - kappa2* BesselSeries([0 0 2], trunc)/D0 + 2* BesselSeries([0 1 2], trunc)/D0  ;

    % Elements of Jacobian 
        % Derivatives of m1
    m1_kappa1 = (Lambda1 * Lambda1_kappa1 + Gamma1 * Gamma1_kappa1)/m1;
    m1_kappa2 = (Lambda1 * Lambda1_kappa2 + Gamma1 * Gamma1_kappa2)/m1;
    m1_Psi = (Lambda1 * Lambda1_Psi + Gamma1 * Gamma1_Psi)/m1;
    
        % Derivatives of m2 and n2 as (2, 1) vectors
    mn2_kappa1 = 2*(Gamma1 * Lambda1_kappa1 - Lambda1 * Gamma1_kappa1)/m1^2*[-n2; m2] ...
        + R_2mu2(Lambda1, Gamma1, PSI, [Lambda2_kappa1; Gamma2_kappa1 ]);
    mn2_kappa2 = 2*(Gamma1 * Lambda1_kappa2 - Lambda1 * Gamma1_kappa2)/m1^2*[-n2; m2] ...
        + R_2mu2(Lambda1, Gamma1, PSI, [Lambda2_kappa2; Gamma2_kappa2 ]);   
    mn2_Psi = 2*(1+(Gamma1 * Lambda1_Psi - Lambda1 * Gamma1_Psi)/m1^2)*[-n2; m2] ...
        + R_2mu2(Lambda1, Gamma1, PSI, [Lambda2_Psi; Gamma2_Psi]);       
   
    % Jacobian Matrix
    J = [m1_kappa1, m1_kappa2, m1_Psi; mn2_kappa1, mn2_kappa2, mn2_Psi];     
    % Jacobian Matrix

    end


    
    function DDN = BesselSeries(offset_indices, trunc)
        PsiShift = offset_indices(3)*pi/2; 
        % differentiate trig term wrt angle by changing phase 
        % first Psi derivative: replaces cos by -sin
        % second Psi derivative: replaces cos by -cos    
        
        % Zero order term (only if no deriv wrt Phi)
        if offset_indices(3)==0
            DDN = 2*pi*kron3(I_pm_k(0, offset_indices(1), kappa1) , ...
                I_pm_k(0, offset_indices(2), kappa2),1);
        else 
            DDN = 0;
        end
        
        % Higher order terms 
        for j = 1:trunc
            DDN = DDN + 4*pi*kron3(I_pm_k(2*j, offset_indices(1), kappa1) , ...
                 I_pm_k(j, offset_indices(2), kappa2) , cos( 2*j*Psi + PsiShift));
        end
        
    end
    
    function I_out = I_pm_k(order, offset_index, argument)  
        offset = abs(offset_index);
        pm = sign(offset_index);
        I_out = (besseli(abs(order-offset), argument, 1)  ...
            + pm * besseli(abs(order+offset), argument, 1))/2^offset;
    end


	function M = kron3(V1, V2, V3)
        if MakeGrid
            M = reshape(kron(V3, kron(V2, V1)), length(V1), length(V2), length(V3));
        else
            M = V1 * V2 * V3;
        end
    end

           
           
           
end
        
