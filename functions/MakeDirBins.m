function theta = MakeDirBins(DirInfo) 

if nargin<1 % Default
    DirInfo = [180 -180];
end

ndirbins = DirInfo(1);
startdir = deg2rad(DirInfo(2));

    



% theta axis
theta =    startdir+ linspace(0, 2*pi, ndirbins+1);
theta(end) = [];

end