function [x, bestx, tolreached, count] =   NewtonStore(yTarg, x, tolerance, trunc, maxiters, maxX, dampval)  
% Multivariate Newtonian solver.  Function and Jacobian are evaluated using
% "MomsAndJacobianFlexi".



if nargin<7
    dampval = 1;
end


if nargin < 6
    maxX= 25;
end

if nargin < 5
    maxiters = 250;
end

if nargin < 4
    trunc = 30;
end

if nargin < 3
    tolerance = 1e-3;
end


    % Initialise: ensure correct dimensions, and create placeholder for f
    yTarg = yTarg(:);     
    [bestx, x] = deal(x(:));       
    y0 = MomsAndJacobianFlexi(x,trunc);
    f = y0(:)-yTarg;
    [bestNormF, normF] = deal(norm(f));
%     
    count = 0;  %%%%%
     while normF > tolerance && count <= maxiters
        [y,J] = MomsAndJacobianFlexi(x,trunc);
        f = y(:)-yTarg;
        
        normF = norm(f);
        if normF < bestNormF
            bestNormF = normF;
            bestx = x;          
        end
        if rcond(J) > 1e-14 % i.e. J is invertible
            xNew = x - dampval*J\f;
            if abs(xNew(1))<= maxX & abs(xNew(2)) <= maxX
                x(1) = abs(xNew(1));
                x(2) = abs(xNew(2));
                x(3) = wrapToPi(xNew(3));
            count = count + 1;
            else
                count = inf ; % terminate iteration 
            end
%             allx = [allx; (x(:)')];
        else 
            x = NaN*x; 
            % This violates the "while" loop condition, so iteration stops
            % and NaN returned as result.
        end
        
%      if count == maxiters
%          disp(allx)
%      end
     end
     tolreached = normF <= tolerance;

end
     