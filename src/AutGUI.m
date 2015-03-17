%%% Automatic Image Processing %%%
function [im_binary, skel] = AutGUI (im_neur, fileFolder, fname, olddir)

if isempty(lasterror) == 0   %c'è errore
    
    [fname, fileFolder] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');
           
    str = strcat(fileFolder, fname);    %complete directory
    
    im_neur = imread(str);

    
end;


figure, subplot (221), imshow(im_neur), title ('original image')

%gaussian

I_filter = im2double (im_neur);

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

% Contrast enhancement

subplot (222), imhist(image_gray);

h = helpdlg('Enter gray intensity input value and gray intensity value you want in output: (value in [0.0 1.0])', 'Contrast enhancement');
uiwait(h);

prompt1 = {'Enter low_in', 'Enter high_in', 'Enter low_out', 'Enter high_out'};
dlg_title = 'Input imhist parameters';           %see help for informations
num_lines = 1;
answer = inputdlg(prompt1, dlg_title, num_lines);

im_adjust = imadjust(image_gray, [str2num(cell2mat(answer(1))); str2num(cell2mat(answer(2)))],...
            [str2num(cell2mat(answer(3))); str2num(cell2mat(answer(4)))], 1);    %gamma=1 ---> linear mapping

% Segmentation: find thresholding

level = graythresh (im_adjust);
im_bw = im2bw (im_adjust, level);

subplot(222), imshow(im_bw)

% Select object in binary image   

im_indiv = bwlabel (im_bw, 8);

h = helpdlg('Select objects you want in image shown in the next figure', 'Help!!');
uiwait(h)

figure, imshow(im_indiv)

im_indiv = bwselect (im_indiv, 8);

close;

subplot (223), imshow (im_indiv)

% Segmentation: morphological operations

h = helpdlg('Insert kernel size (shape: rectangle)', 'Dilate image');
uiwait(h);

prompt2 = {'Enter row number', 'Enter column number'};
dlg_title = 'Input structuring element shape and parameters:';
num_lines = 1;
answer = inputdlg(prompt2, dlg_title, num_lines);

kernel = strel('rectangle', [str2num(cell2mat(answer(1))), str2num(cell2mat(answer(2)))]);

im_dil = imdilate(im_indiv, kernel);
subplot (223), imshow(im_dil)

%Save binary image

im_binary = ~im_dil;

subplot (223), imshow(im_binary), title('Binary image')   %nera a sfondo bianco

%skeletonize
h = helpdlg('Select soma center and upper-left angle');
uiwait(h);

f = figure;
imshow(im_dil), impixelinfo
[x1, y1] = ginput(1);    %Seleziono orientativamente il centro del soma
[x2, y2] = ginput(1);   %Seleziono un punto in alto a destra che mi indentifichi la fine del soma
close (f)

x1 = uint32(x1);
y1 = uint32(y1);
x2 = uint32(x2);
y2 = uint32(y2);


for i = y2:(2*y1-y2)
    for j = (2*x1-x2):x2
        im_dil(i, j) = 0;
    end;
end;

skel = bwmorph (im_dil, 'thin', Inf);
skel = bwmorph (skel, 'bridge', 10);
skel = imdilate(skel, strel('line', 4, 1));
skel = bwareaopen(skel, 40);

skel = ~skel;


subplot(224), imshow(skel), title('Skeleton')

h = helpdlg('Zoom binary image and skeleton', 'Help');
uiwait(h)

%save

h = figure, imshow(im_binary)
uiwait(h);
g = figure, imshow(skel)
uiwait(g);

selection = questdlg('Do you want to save binary image and skeleton? If you click "No", you will be automatically directed to Image processing: an opportunity for changin parameters');
       
    if strcmp(selection,'No')
       
        close;
        [binary, im_skel] = Image_processing (im_neur, fileFolder, fname);
        
    else  
       cd(fileFolder)
       
     
        [path,name,ex]=fileparts(fname);
        bin = strrep (name, 'p', 'b'); %bin
        bin=strcat(bin,ex);

        imwrite (im_binary,bin);
    
        sch = strrep (name, 'p', 's');     %skel
        sch=strcat(sch,ex);
        imwrite (skel,sch);
        close;
      
    end;

delete intermedio.jpg
delete ('i_*.jpg')        

cd(olddir);
