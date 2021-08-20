function[FileList, FilePath] = GetFileList
    % Gets user to locate SPT file(s), returns location and cell array of
    % file names
InputTypeSet = {'File(s)', 'Directory'};

% Input file
InputType = questdlg('How would you like to input files?', ...
	'Input Type', ...
	InputTypeSet{1}, InputTypeSet{2}, InputTypeSet{1});
switch InputType
    case InputTypeSet{1} % Select file(s)
        [FileList,FilePath] = uigetfile('*.spt','Select One or More Files','MultiSelect', 'on');
        
    case InputTypeSet{2}  % Select whole directory
        FilePath = uigetdir;
        FilePath = [FilePath, filesep];
        FileList = dir([FilePath, '*.spt']);
        FileList = {FileList.name};
end

if ~iscell(FileList) % Make sure file list is cell array for uniform handling
    FileList = {FileList}; 
end
    
end

