    function [x, counts ] = CallNewton(TargMoms, x0, tolerance, trunc, maxIntermedSteps, maxiters)
    
    
    if nargin<6
        maxiters = 25;
    end
    
    if nargin<5
        maxIntermedSteps = 15;
    end
    
    if nargin<4
        trunc = 30;
    end
    
    
    
    FinalTarget = TargMoms;
    needtosolve = true;
    x0Orig = x0;

    y0 = MomsAndJacobianFlexi(x0);  
    yTarg = FinalTarget;   
    isFinalTarget = true;
    movingPointCount = 0; 
    % If Newton's method fails, use an intermediate target point.  
    % movingPointCount ensures this is only attempted a finite number of
    % times

    while (needtosolve && movingPointCount<maxIntermedSteps)
        [x, xbest, tolreached, NewtCount] =   NewtonStore(yTarg,x0, tolerance,trunc, maxiters, 100);  
%     disp(NewtCount);
        
        needtosolve = any(isnan(x)) | ~isFinalTarget | ~tolreached;
        if any(isnan(x)) | ~tolreached% i.e. Newton's method failed
            yTarg = (y0+yTarg)/2; % Bring target closer to known values
            isFinalTarget = false;
            movingPointCount = movingPointCount + 1;
        elseif ~isFinalTarget % Newton succeeded for an intermediate target
                x0 = x; % Use new known values to define new starting point
                y0 = MomsAndJacobianFlexi(x0); 
                
                yTarg = FinalTarget; % Next time, attempt to solve for final target
                isFinalTarget = true;
        end

    end
    
    if any(isnan(x))
        if any(isnan(xbest))
            x = x0Orig;
        else
            x = xbest;
        end
    end
        counts = [movingPointCount, NewtCount];
    end