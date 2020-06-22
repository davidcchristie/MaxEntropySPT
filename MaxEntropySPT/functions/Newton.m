function x =   Newton(yTarg, x, tolerance)  
% Multivariate Newtonian solver.  Function and Jacobian are evaluated using
% "MomsAndJacobianFlexi".

if nargin < 3
    tolerance = 1e-3;
end
    % Initialise: ensure correct dimensions, and create placeholder for f
    yTarg = yTarg(:);     
    x = x(:);       
    y0 = MomsAndJacobianFlexi(x,50);
    f = y0(:)-yTarg;
   
     while norm(f) > tolerance 
        [y,J] = MomsAndJacobianFlexi(x,50);
        f = y(:)-yTarg;
        if rcond(J) > 1e-14 % i.e. J is invertible
            x = x - J\f;
            x(1) = abs(x(1)); 
            x(2) = abs(x(2));
        else 
            x = NaN*x; 
            % This violates the "while" loop condition, so iteration stops
            % and NaN returned as result.
        end
        
     end
end
     