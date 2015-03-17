%%%Neurons count%%%
function [number] = count(image)    

%gaussian

I_filter = im2double (image);

sigma = 0.2;   %default parameters
hsize_r = 3;
hsize_c = 3;

imageycbcr = rgb2ycbcr (I_filter);
lum = imageycbcr (:, :, 1); 

im_gaus = filter2 (fspecial ('gaussian', [hsize_r  hsize_c] , sigma), lum);

imageycbcr (:, :, 1) = im_gaus;
image_rgb = ycbcr2rgb (imageycbcr);

% grayscale

image_gray = rgb2gray(image_rgb);

%Uniform background

background = imopen (image_gray, strel('disk', 30) );
image_gray = imsubtract (image_gray, background);


% Contrast enhancement
g=figure;
g, imhist(image_gray)

h = helpdlg('Enter gray intensity input value and gray intensity value you want in output:', 'Contrast enhancement');
uiwait(h);

prompt1 = {'Enter low_in', 'Enter high_in', 'Enter low_out', 'Enter high_out'};
dlg_title = 'Input imhist parameters';           %see help for informations
num_lines = 1;
answer = inputdlg(prompt1, dlg_title, num_lines);

close(g);

im_adjust = imadjust(image_gray, [str2num(cell2mat(answer(1))); str2num(cell2mat(answer(2)))],...
           [str2num(cell2mat(answer(3))); str2num(cell2mat(answer(4)))], 1);    %gamma=1 ---> linear mapping


 
% Segmentation: find thresholding

level = graythresh (im_adjust);
im_bw = im2bw (im_adjust, level);


im = imerode(im_bw, strel('diamond', 12));
im = bwareaopen(im, 4, 8);   %removes object that have fewer than 4 pixels
im = bwmorph(im, 'spur');    %removes spur pixels

[im,num] = bwlabel(im, 8);

a = zeros(num, 1);        %row of all zeros
w = zeros(num, 1);

for i = 1 : num 
    
    [r, c] = find(im == i);
    a(i) = size(r, 1);
    
        if a(i) <= 10
            for i = 1: size(r)
            im(r(i), c(i)) = 0;
            end;
        end;
            
end;
  
  
[im, number] = bwlabel(im, 8);
figure, imshow(im)

answer = strcat('The neuron cells in this image are:  ', num2str(number));

h = msgbox(answer);
uiwait(h);

close;

