function[pdspeechtable,T,names] = loaddataset()
% if nargout>1, then returns X,T,names
% otherwise return it as a table.
%By Aaron, Danielle, and Zac
%02/05/24
persistent pdspeechtable__; %in-memory version of pdspeechtable. (cache'ing)
if ~isempty(pdspeechtable__); pdspeechtable=pdspeechtable__; return; end

%% This is the function currently being used to load our data for the ML project
file_zip = bmes.downloadurl('https://archive.ics.uci.edu/static/public/470/parkinson+s+disease+classification.zip','pd_speech_features.zip');
tmp = split(file_zip,"/"); tmp = tmp(1:end-1); tmp = join(tmp,'/'); tmp = tmp{1};
file_rar = unzip(file_zip, tmp);

if numel(file_rar)~=1; error('Expecting only 1 unzipped file.'); end %ahmet: I added this line. You need to confirm the zip file contains only one file.
file_rar=file_rar{1}; %ahmet: file_rar was a cell array.

file = split(file_rar,"."); %ahmet: This is not a good way to obtain the filename without the extension. What if file contains multiple '.' ? TODO: use fileparts() instead.
file = append(file{1}, '.csv');

%ahmet: I added this code block:
if ~isfile(file)
	if ispc; sevenzexe = bmes.locateexe('7z',false,'C:\Program Files\7-Zip');
	else sevenzexe = bmes.locateexe('7z',false); end
	if ~isempty(sevenzexe)&&isfile(sevenzexe)
		filedir=fileparts(file);
		if any([sevenzexe file_rar]=='"'); error('Unexpected character in file names'); end %b/c next line is only safe if they do not contain quote.
		system(sprintf('"%s" x "%s" -o"%s"',sevenzexe,file_rar,filedir))
		if ~isfile(file); error(sprintf('Failed to 7zip extract the file %s from rar file %s',file,file_rar)); end
	else
		error(sprintf('7zip executable 7z could not be found. Either make 7z available on your System PATH so I can extract the rar file for you; or manually extract %s to %s using e.g., 7-Zip: https://www.7-zip.org/download.html', char(file_rar), file))
	end
end

%ahmet: I commented out some of these that are now handled above.
%if ~isfile(file)
% ahmet: 7-Zip is not exclusively for Windows. It works on Mac & Linux,
% too.
%	error(sprintf('Manually extract %s to %s using Windows 7-Zip', char(file_rar), file))
%else
	%reading table and fixing variable names'
	pdspeechtable=readtable(file); %ahmet: use: 'NumHeaderLines',1
	importdatastruct=importdata(file); %ahmet: this and next line are unnecessary and inefficient. readtable() is capable of using the second row for headers.
	pdspeechtable.Properties.VariableNames=importdatastruct.textdata(2,:);
%end

pdspeechtable__=pdspeechtable; 

