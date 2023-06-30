function d = dirND(dirLoc)
    d = dir(dirLoc);    
    d=d(~ismember({d.name},{'.','..'}));
end