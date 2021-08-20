function theta = MakeDirBins(DirInfo) 

if nargin<1 % Default
    ndirbins = 180;
    startdir = -180;
else    
    ndirbins = DirInfo(1);
    startdir = deg2rad(DirInfo(2));
end



% theta axis
theta =    startdir+ linspace(0, 2*pi, ndirbins+1);
theta(end) = [];

end