function [numberOfNeurons] = nonNEUfluo 


[filename, pathname] = uigetfile({'*.jpg;*.tiff;*.bmp;*.png;*.gif','All Images Files'}, 'Pick an image','Multiselect','on')


         
nu=length(filename)



numberOfNeurons = zeros(nu, 1);     

if iscell(filename)==1
for k = 1:nu
        slice=imread(filename{k});
         NON = count(slice);
         numberOfNeurons(k) = NON
       
end;
else
    slice=imread(filename);
         NON = count(slice);
         numberOfNeurons = NON;
end


mkdir(sprintf('%s\\Count',pathname));

uisave('numberOfNeurons')
