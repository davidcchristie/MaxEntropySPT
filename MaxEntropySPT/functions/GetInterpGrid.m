function  SI = GetInterpGrid(createNew)

    if nargin == 0
        createNew = true;
    end
    gridFilename = 'InterpGrid';
    fileExists = exist([gridFilename,'.mat'], 'file');
    
    if fileExists && ~ createNew
        disp('Loading Grid');
        load(gridFilename, 'SI');
    else
        
    kappa12vec = [0.1:0.1:2, 2.25:0.25:8, 8.5: 0.5, 25];
    psiVec = linspace(-pi/2,pi/2,70);
    
    startGrid = MomsAndJacobianFlexi( {kappa12vec, kappa12vec, psiVec},25);
    InterpType = 'nearest';
    SI = cell(3,1);
    disp('Generating Grid');
    for n = 1:3
        switch n
            case 1 
                TargParam = startGrid.KAPPA1;
            case 2 
                TargParam = startGrid.KAPPA2;   
            case 3 
                TargParam = startGrid.PSI;
        end

    SI{n} = scatteredInterpolant(startGrid.M1(:), startGrid.M2(:), startGrid.N2(:), TargParam(:),InterpType);
    end
    end
end