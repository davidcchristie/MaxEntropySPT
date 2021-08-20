function x =   Newton(yTarg, x, tolerance, trunc)  
% Multivariate Newtonian solver.  Function and Jacobian are evaluated using
% "MomsAndJacobianFlexi".
if nargin < 4
    trunc = 50;
    if nargin < 3
        tolerance = 1e-2;
    end
end
    % Initialise: ensure correct dimensions, and create placeholder for f
    yTarg = yTarg(:);     
    x = x(:);       
    y0 = MomsAndJacobianFlexi(x,trunc);
    f = y0(:)-yTarg;
   
     while norm(f) > tolerance 
        [y,J] = MomsAndJacobianFlexi(x,trunc);
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
     