function varargout = ToSli(varargin)
%TOSLI M-file for ToSli.fig
%      TOSLI, by itself, creates a new TOSLI or raises the existing
%      singleton*.
%
%      H = TOSLI returns the handle to a new TOSLI or the handle to
%      the existing singleton*.
%
%      TOSLI('Property','Value',...) creates a new TOSLI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ToSli_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TOSLI('CALLBACK') and TOSLI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TOSLI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ToSli

% Last Modified by GUIDE v2.5 08-Jan-2015 15:29:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ToSli_OpeningFcn, ...
                   'gui_OutputFcn',  @ToSli_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ToSli is made visible.
function ToSli_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
global im;

% Choose default command line output for ToSli
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ToSli wait for user response (see UIRESUME)
% uiwait(handles.figure1);
mInputArgs = varargin;

im = mInputArgs{1};

axes(handles.a_immagine)
    imshow(im);

% --- Outputs from this function are returned to the command line.
function varargout = ToSli_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function b_open_Callback(hObject, eventdata, handles)
% hObject    handle to b_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global pathname;
global slice;

[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');

    str = strcat(pathname, filename)   %complete directory
    
    slice = imread(str);

axes(handles.a_immagine)
    imshow(slice);
    axis image
    axis off;


% --- Executes on button press in b_bin.
function b_bin_Callback(hObject, eventdata, handles)
% hObject    handle to b_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname;
global im;
global im_bw;
global image_gray;

% % I_filter = im2double (im);
image_gray = im;

% % sigma = 0.2;   %default parameters
% % hsize_r = 3;
% % hsize_c = 3;

% % imageycbcr = rgb2ycbcr (I_filter);
% % lum = imageycbcr (:, :, 1); 
% % 
% % im_gaus = filter2 (fspecial ('gaussian', [hsize_r  hsize_c] , sigma), lum);
% % 
% % imageycbcr (:, :, 1) = im_gaus;
% % image_rgb = ycbcr2rgb (imageycbcr);

% grayscale

% image_gray = rgb2gray(image_rgb);


%Uniform background
pathname

background = imopen (image_gray, strel('disk', 30) );
image_gray = imsubtract (image_gray, background);

im_adjust = image_gray;
level = graythresh (im_adjust);
im_bw = im2bw (im_adjust, level);

axes(handles.a_immagine)
    imshow(im);
    axis image
    axis off;

axes(handles.a_binary)
    imshow(im_bw);
    axis image
    axis off;


% --- Executes on button press in b_analysis.
function b_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to b_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_bw;
global image_gray;
global pathname;
global im;
%global olddir;

olddir = pwd;   %current directory

helpdlg ('In the binary image on the right, select two points, so as to divide the two layers!', 'Points selection');
uiwait;

dirOutput1 = dir(fullfile(pathname,'p_*.*'))  
fileNames1 = {dirOutput1.name}' 
nu=numel(fileNames1)


    
S = char(fileNames1{nu})
[a b c gmax dmax] = strread(S, '%s %s %s %d %d', 'delimiter', '_');


% Data matrix construction


DM=zeros(1,12,dmax);


for N=(gmax-nu)+1:gmax

path(path, pathname)

im=imread(fileNames1{N-gmax+nu});
pathname
S = char(fileNames1{N-gmax+nu});
[ay by cy gg dy] = strread(S, '%s %s %s %d %d', 'delimiter', '_');

axes(handles.a_immagine);
imshow(im);

b_bin_Callback(hObject, eventdata, handles); 

[m,n]= size(im_bw);
C= zeros(m,n);
for i=1:m
    for j =1:n
        if im_bw(i,j)==1
            C(i,j)=image_gray(i,j);
        end
    end
end

C1=C>0;
Int=mean(mean(C>0));

set(handles.edit1,'String',num2str(Int));

[y,x]=find(im_bw==1);
[y1,i]=sort(y);

[l,p]=size(i);

x1=zeros(l,1);
for k=1:l
    x1(k)=x(i(k));
    
end


dis=max(x)-min(x);

set(handles.edit21,'String',num2str(dis));

[m,n]= size(im_bw);
% g=1;
% while g>0
% g=find(im_bw(:,med));
% if g>0
%     med=med+1;
% end

% med=n/2;

% g=1;
% mn=min(x1);
% t=zeros(m,51);
% med=1;
% while g>0 
% g=find(im_bw(:,mn));
% if g>0
%     mn=mn+1;
% else 
%     for i=mn:(mn+80)
%     d=find(im_bw(:,i));
%     t(1:length(d))=d;
%     end
%     if find(t>0)
%         mn=mn+80; 
%     end
% g=find(im_bw(:,mn));
% end
% end
% 
% med=mn;


[a,b,v]=impixel(im_bw);
mm=(a(2)-a(1))/(b(2)-b(1));
q=(b(2)*a(1)-b(1)*a(2))/(b(2)-b(1));
xx=1:m;
yy=mm*xx+q;


cor1=[0 0];
cor2=[0 0];


for i=1:length(x)
    if x1(i)<round(yy(y1(i)))
        cor1=cat(1,cor1,[y1(i) x1(i)]);
    else
        cor2=cat(1,cor2,[y1(i) x1(i)]);
    end
end

cor1=removerows(cor1,1);
cor2=removerows(cor2,1);
        
[l1,p]=size(cor1);  
[l2,p]=size(cor2);


s1=zeros(l1,3);
s2=zeros(l2,3);


k=1;
s1(k,1)=cor1(k,2);
k=k+1;
j=1;
while k<l1+1
    if cor1(k-1,1)==cor1(k,1)
      s1(j,2)=cor1(k,2);  
            s1(j,3)=cor1(k,1);
    else
        j=j+1;
        s1(j,1)=cor1(k,2); 
              s1(j,3)=cor1(k,1);
    end
    k=k+1;
end
        
k=1;
s2(k,1)=cor2(k,2);
k=k+1;
j=1;
while k<l2+1
    if cor2(k-1,1)==cor2(k,1)
      s2(j,2)=cor2(k,2);  
      s2(j,3)=cor2(k,1);
    else
        j=j+1;
        s2(j,1)=cor2(k,2); 
        s2(j,3)=cor2(k,1);
    end
    k=k+1;
end

[q,w]=find(s2(:,3)==0);

if q(1)==1
    s2(1,2)=s2(1,1);
    s2(1,3)=1;
    q=removerows(q,1);
end

s2=removerows(s2,[q(1):q(end)]);


[q,w]=find(s1(:,3)==0);

if q(1)==1
    s1(1,2)=s1(1,1);
    s1(1,3)=1;
    q=removerows(q,1);
end

s1=removerows(s1,[q(1):q(end)]);

[v,u]=find(s1==0)
for i=1:length(v)
    s1(v(i),2)=s1(v(i),1);
end

[v,u]=find(s2==0)
for i=1:length(v)
    s2(v(i),2)=s2(v(i),1);
end


[l1,p]=size(s1);  
[l2,p]=size(s2);

seg1=zeros(l1,1);
for i=1:l1
seg1(i)=(s1(i,2)-s1(i,1));
end

seg2=zeros(l2,1);
for i=1:l2
seg2(i)=(s2(i,2)-s2(i,1));
end

max1=max(seg1);
max2=max(seg2);
for i=1:length(seg1)
    if seg1(i)<4
        seg1(i)=NaN;
    end 
end
min1=min(seg1);
for i=1:length(seg2)
    if seg2(i)<4
        seg2(i)=NaN;
    end 
end
min2=min(seg2);
av1=nanmean(seg1);
av2=nanmean(seg2);

set(handles.edit15,'String',num2str(av1));
set(handles.edit20,'String',num2str(av2));
set(handles.edit13,'String',num2str(max1));
set(handles.edit19,'String',num2str(max2));
set(handles.edit12,'String',num2str(min1));
set(handles.edit18,'String',num2str(min2));

mean1=zeros(l1,2);
m1=zeros(l2,1);
for i=1:l1
m1(i)=(s1(i,2)-s1(i,1))/2;
mean1(i,2)=s1(i,1)+m1(i);
mean1(i,1)=s1(i,3);
end

mean2=zeros(l2,2);
m2=zeros(l2,1);
for i=1:l2
m2(i)=(s2(i,2)-s2(i,1))/2;
mean2(i,2)=s2(i,1)+m2(i);
mean2(i,1)=s2(i,3);
end





 axes(handles.a_rect)
 imshow(im_bw)

[p,ErrorEst]=polyfit(mean1(:,2),mean1(:,1),1);
                    pop_fit1=polyval(p,mean1(:,2),ErrorEst);
                    [pop_fit1,delta1] = polyval(p,mean1(:,2),ErrorEst);
                    % Plot dei dati, del fit e degli intervalli di
                    % confidenza
                    axes(handles.a_rect)
                   
%                     axis image
                    axis off
          hold on
                    plot(mean1(:,2),mean1(:,1),'+',mean1(:,2),pop_fit1,'g-',mean1(:,2),pop_fit1+2*delta1,'r:',mean1(:,2),pop_fit1-2*delta1,'r:')
                    

                    
[p,ErrorEst]=polyfit(mean2(:,2),mean2(:,1),1);
pop_fit2=polyval(p,mean2(:,2),ErrorEst);
[pop_fit2,delta2] = polyval(p,mean2(:,2),ErrorEst);
% Plot dei dati, del fit e degli intervalli di confidenza
                    axes(handles.a_rect)
                 
%                     axis image
                    axis off
                    hold on
plot(mean2(:,2),mean2(:,1),'+',mean2(:,2),pop_fit2,'g-',mean2(:,2),pop_fit2+2*delta2,'r:',mean2(:,2),pop_fit2-2*delta2,'r:')


ll1=sqrt(((mean1(end,2)-mean1(1,2))^2)+((pop_fit1(end)-pop_fit1(1))^2));
ll2=sqrt(((mean2(end,2)-mean2(1,2))^2)+((pop_fit2(end)-pop_fit2(1))^2));


meanE1=mean(delta1);
meanE2=mean(delta2);
set(handles.edit11,'String',num2str(ll1));
set(handles.edit16,'String',num2str(ll2));

set(handles.edit14,'String',num2str(meanE1));
set(handles.edit17,'String',num2str(meanE2));




DM(1,1,dy)=Int;
DM(1,2,dy)=ll1;
DM(1,3,dy)=av1;
DM(1,4,dy)=min1;
DM(1,5,dy)=max1;
DM(1,6,dy)=meanE1;
DM(1,7,dy)=ll2;
DM(1,8,dy)=av2;
DM(1,9,dy)=min2;
DM(1,10,dy)=max2;
DM(1,11,dy)=meanE2;
DM(1,12,dy)=dis;


end;

%salvo il datamatrix globale sia nella cartella corrispondente alla slice,
%che chiamo Datamatrix, sia in una cartella in NE.MO. che raccoglie tutti i
%datamatrix di tutte le slice, che chiamo DatamatrixSlice.

mkdir(sprintf('%s\\Datamatrix',pathname));
pathname1=(sprintf('%s\\Datamatrix',pathname));

v = genvarname(['DM_' char(by) '_' char(cy) '_' num2str(dy)]);

eval ([v '=DM']);

save(sprintf('%s\\DM_%s_%s_%s.mat',pathname1, char(by), char(cy), num2str(dy)), ['DM_' char(by) '_' char(cy) '_' num2str(dy)]);   

mkdir(sprintf('%s\\DatamatrixSlice',olddir));
pathname2=(sprintf('%s\\DatamatrixSlice',olddir));
save(sprintf('%s\\DM_%s_%s_%s.mat', pathname2, char(by), char(cy), num2str(dy)), 'DM', '-mat');


helpdlg('Datamatrix saved!', 'About Datamatrix:');


% mkdir(sprintf('%s\\DatamatrixSlice', olddir);
% pathname2 = sprintf('%s\\DatamatrixSlice', olddir);
% 
% v = genvarname('DM_


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
