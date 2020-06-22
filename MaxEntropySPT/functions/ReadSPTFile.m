function S = ReadSPTFile(filename)
    % Reads a Datawell SPT file.  
    % Generates nf * 6 matrix: freq, PSD (actual), MWD, SPR, SKW, KUR
    
    spt_in = importdata(filename,',',12);
    S = spt_in.data;    
    % NB Datawell scales PSD so maximum is 1.  This function returns actual
    % max, scaled with maxPSD.
    maxPSD = str2double(spt_in.textdata(4));
    S(:,2) = maxPSD*S(:,2);
    disp([filename, ' read']);
end
