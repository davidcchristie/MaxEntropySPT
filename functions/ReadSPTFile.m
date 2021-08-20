function S = ReadSPTFile(filename)
	% Reads SPT file (which is a comma delimited ascii file with 12 header lines, then 64 x 6 block of spectral data)
	
	fid = fopen(filename, 'r');
	textin = textscan(fid,'%s','delimiter','\n');
	fclose(fid);


	textin = textin{1,1};
	
	maxPSD = str2double(textin{4}); % the PSD in column two must be scaled by this maxPSD
	
	S = cell2mat(cellfun(@(x) sscanf(x, '%g,'), textin(13:76), 'UniformOutput', false));
	S = reshape(S, [6, 64])';
	S(:,2) = maxPSD*S(:,2);

end