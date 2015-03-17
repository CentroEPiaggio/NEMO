function [numberOfNeurons] = editor_precount1 (neuron, pathname, filename)


if isempty(lasterror) == 0   %c'è errore
    
    [filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');
           
    str = strcat(pathname, filename);    %complete directory
    
    neuron = imread(str);

    
end;

dirOutput = dir(fullfile(pathname,'p_*.*'));

fileNames = {dirOutput.name}' ;
         
nu=numel(fileNames);

 S = char(fileNames{nu});
[a b c gmax d] = strread(S, '%s %s %s %d %d', 'delimiter', '_');


numberOfNeurons = zeros(nu, 1);     

path(path,pathname);
for k = 1:nu
    
        slice=imread(fileNames{k});
        NON = count_noflu(slice);
        numberOfNeurons(k) = NON;
        
end;

t=0;

while t==0
[pathstr, name, ext, versn] = fileparts(pathname);
pathname=pathstr;
t=isequal(name, sprintf('%s%s',char(b),char(c)));
end

mkdir(sprintf('%s\\Count',pathname));
pathname1=(sprintf('%s\\Count',pathname));

save(sprintf('%s\\numberOfneurons_%s_%s_%d',pathname1, char(b),char(c), d),'numberOfNeurons')
