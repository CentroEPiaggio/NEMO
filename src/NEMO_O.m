function varargout = NEMO_O(varargin)
% NEMO_O M-file for NEMO_O.fig
%      NEMO_O, by itself, creates a new NEMO_O or raises the existing
%      singleton*.
%
%      H = NEMO_O returns the handle to a new NEMO_O or the handle to
%      the existing singleton*.
%
%      NEMO_O('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEMO_O.M with the given input arguments.
%
%      NEMO_O('Property','Value',...) creates a new NEMO_O or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NEMO_O_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NEMO_O_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NEMO_O

% Last Modified by GUIDE v2.5 01-Mar-2010 10:10:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NEMO_O_OpeningFcn, ...
                   'gui_OutputFcn',  @NEMO_O_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before NEMO_O is made visible.
function NEMO_O_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NEMO_O (see VARARGIN)





% Choose default command line output for NEMO_O
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NEMO_O wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% set(handles.l_intersezioni1,'Value',[]);




% --- Outputs from this function are returned to the command line.
function varargout = NEMO_O_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on selection change in pop_immagine.
function pop_immagine_Callback(hObject, eventdata, handles)
% hObject    handle to pop_immagine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_immagine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_immagine
% 
% global photo;
% global bw;
% global skeleton;
% 
% %Inizializzo gli edit a zero
% str = get(hObject, 'String');
% val = get(hObject,'Value');
% 
% 
% switch str{val}    
%     
%     case 'Photograph'   % Visualization of original image
%      
%         
%         axes(handles.a_immagine);
%         imshow(photo);
%         axis equal;
%         axis tight;
%         axis off;
% 
%     case 'Binary'    % Visualization of binary image
%         
%         
%         axes(handles.a_immagine);
%         imshow(bw);
%         axis equal;
%         axis tight;
%         axis off;
% 
% 
% 
%     case 'Skeleton'     % visualization of skeleton
%            
%          
%          axes(handles.a_immagine);
%          imshow(skeleton);
%          axis equal;
%          axis tight;
%          axis off;
%          uisave
%        
% end;


       

% --- Executes during object creation, after setting all properties.
function pop_immagine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_immagine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_carica.
function b_carica_Callback(hObject, eventdata, handles)
% hObject    handle to b_carica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global photo;
global bw;
global DM;
global N;
global nu;
global fileNames2;
global t;
global gg;
global frac_dim;
global pathname;
global d;




dirOutput1 = dir(fullfile(pathname,'s_*.*'));  
dirOutput2 = dir(fullfile(pathname,'p_*.*'));
dirOutput3 = dir(fullfile(pathname,'b_*.*'));  
fileNames1 = {dirOutput1.name}' ;
fileNames2 = {dirOutput2.name}' ;
fileNames3 = {dirOutput3.name}' ;          
nu=numel(fileNames1);


    
S = char(fileNames1{nu});
[a b c gmax dmax] = strread(S, '%s %s %s %d %d', 'delimiter', '_');   


% Data matrix construction


DM=zeros(1,177,dmax);


for N=(gmax-nu)+1:gmax

path(path,pathname)

skeleton1=imread(fileNames1{N-gmax+nu});


S = char(fileNames1{N-gmax+nu})
[a b c gg d] = strread(S, '%s %s %s %d %d', 'delimiter', '_')     

%level = graythresh(skeleton1);
%skeleton = im2bw(skeleton1,level);
skeleton = skeleton1;
photo=imread(fileNames2{N-gmax+nu});
bw=imread(fileNames3{N-gmax+nu});


% Skeleton visualization
       
axes(handles.a_immagine);
imshow(skeleton);
title(handles.a_immagine,sprintf('Photograph number %s',num2str(gg)))
axis image
axis off; 



b_centro_Callback(hObject, eventdata, handles); 

b_raggiominimo_Callback(hObject, eventdata, handles);

b_rmax_Callback(hObject, eventdata, handles); 

b_cerchi1_Callback(hObject, eventdata, handles); 

b_intersezioni1_Callback(hObject, eventdata, handles); 

b_semilog1_Callback(hObject, eventdata, handles); 

b_loglog1_Callback(hObject, eventdata, handles); 

b_percestr1_Callback(hObject, eventdata, handles); 

b_percasse1_Callback(hObject, eventdata, handles); 

b_cerchi2_Callback(hObject, eventdata, handles); 

b_intersezioni2_Callback(hObject, eventdata, handles); 

b_semilog2_Callback(hObject, eventdata, handles); 

b_loglog2_Callback(hObject, eventdata, handles); 

b_percestr2_Callback(hObject, eventdata, handles); 

b_percasse2_Callback(hObject, eventdata, handles); 

b_estensione_Callback(hObject, eventdata, handles);

b_soma_Callback(hObject, eventdata, handles);

b_retta1_Callback(hObject, eventdata, handles);

b_box_Callback(hObject, eventdata, handles);  

DM(1,173,d) = frac_dim;


% dm=DM(:,:,d);

% pathname2=(sprintf('%s\\Datamatrix',pathname));
% 
% save(sprintf('%s\\dm%s_%s_%s.mat',pathname2,char(b),char(c),num2str(d)),'dm')

end;

for i=1:size(DM,2)
    
    for j=1:size(DM,3)
        
        if DM(1, i, j)==0
            
            DM(1, i, j)=NaN;
            
        end;
        
    end;
    
end;

t=0;

while t==0
[pathstr, name, ext, versn] = fileparts(pathname);
pathname=pathstr;
t=isequal(name, sprintf('%s%s',char(b),char(c)));
end


mkdir(sprintf('%s\\Datamatrix%s',pathname, char(b)));
pathname1=(sprintf('%s\\Datamatrix%s',pathname, char(b)));   %b=colture number

v = genvarname(['DM_' char(b) '_' char(c) '_' num2str(d)]);

eval ([v '=DM']);
    %save datamatrix in the folder of the corrisponding colture
save(sprintf('%s\\DM_%s_%s_%s.mat', pathname1, char(b), char(c), num2str(d)),['DM_' char(b) '_' char(c) '_' num2str(d)]);        
    %save datamatrix in the datamatrix folder, where there are all
    %datamatrix, for all colture
xlswrite(sprintf('%s\\DM_%s_%s_%s', pathname1, char(b), char(c), num2str(d)),['DM_' char(b) '_' char(c) '_' num2str(d)]);            

mkdir(sprintf('%s\\Datamatrix\\%s', cd, char(b)));
pathname2=(sprintf('%s\\Datamatrix\\%s', cd, char(b)));   %b=colture number

%save(sprintf('%s\\DM_%s_%s_%s.mat', pathname2 , char(b), char(c), num2str(d)),['DM_' char(b) '_' char(c) '_' num2str(d)]);
save(sprintf('%s\\DM_%s_%s_%s.mat', pathname2 , char(b), char(c), num2str(d)), 'DM', '-mat');
xlswrite(sprintf('%s\\DM_%s_%s_%s', pathname2 , char(b), char(c), num2str(d)), 'DM', '-mat');

%cd(pathname1)


% --- Executes on button press in b_centro.
function b_centro_Callback(hObject, eventdata, handles)
% hObject    handle to b_centro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global gg;
global DM;
global d;

% Inizializzo gli edit a zero

set(handles.edit_xc,'String','')
set(handles.edit_yc,'String','')

% Visualizzo lo scheletro dell'immagine

axes(handles.a_immagine); 
% imshow(scheletro);
% figure
imshow(skeleton);
title (sprintf('Photograph number %s   Select center and minimum radius',num2str(gg)))
axis equal;
axis tight;
axis off;

% Individuo il centro con il clic del mouse

[xc,yc,but]=ginput(1);

if but==3       %Se clicco col tasto destro, esco
    return
end


set(handles.edit_xc,'String',num2str(round(xc)))
set(handles.edit_yc,'String',num2str(round(yc)))

DM(1,176,d)=xc;
DM(1,177,d)=yc;

% --- Executes during object creation, after setting all properties.
function b_centro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_centro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function edit_rmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rmax as text
%        str2double(get(hObject,'String')) returns contents of edit_rmax as a double



% --- Executes during object creation, after setting all properties.
function edit_rmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_yc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yc as text
%        str2double(get(hObject,'String')) returns contents of edit_yc as a double


% --- Executes during object creation, after setting all properties.
function edit_yc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xc as text
%        str2double(get(hObject,'String')) returns contents of edit_xc as a double


% --- Executes during object creation, after setting all properties.
function edit_xc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function file_menu_exit_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




    selection = questdlg('Are you sure?');
       
    if strcmp(selection,'No')
        return;
    end

    close;      %close the current figure  


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cut_Callback(hObject, eventdata, handles)
% hObject    handle to cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function copy_Callback(hObject, eventdata, handles)
% hObject    handle to copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function paste_Callback(hObject, eventdata, handles)
% hObject    handle to paste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in b_raggiominimo.
function b_raggiominimo_Callback(hObject, eventdata, handles)
% hObject    handle to b_raggiominimo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global xc;
global yc;
global rmin;
global skeleton;
global gg;
global DM;
global d;


% Inizializzo l'edit a zero

set(handles.e_rmin,'String','');

% Individuo il raggio minimo con il clic del mouse


[x3,y3,but]=ginput(1);

if but==3       %Se clicco col tasto destro, esco
    return
end

% Calcolo il raggio minimo

rmin=sqrt(((xc-x3)^2)+((yc-y3)^2));

set(handles.e_rmin,'String','');
set(handles.e_rmin,'String',num2str(round(rmin)));

DM(1,174,d)=rmin;




% close


function e_rmin_Callback(hObject, eventdata, handles)
% hObject    handle to e_rmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rmin as text
%        str2double(get(hObject,'String')) returns contents of e_rmin as a double


% --- Executes during object creation, after setting all properties.
function e_rmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_carica.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to b_carica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in b_intersezioni1.
function b_intersezioni1_Callback(hObject, eventdata, handles)
% hObject    handle to b_intersezioni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO;
global Intersezioni1;
global DM;
global N;
global gg;
global d;


[m,n]=size(skeleton);
B=zeros(size(skeleton));


s=(rmax-rmin)/9;


indice=0;

% Inizializzo a zero l'array del numero di intersezioni per cerchio

Int=zeros(1,10);

for r=rmin:s:rmax
    indice=indice+1;
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;


% Calcolo la matrice data dalla somma della matrice che rappresenta
% l'immagine e la matrice che rappresenta ciascun cerchio e vado a vedere
% quando questa matrice assume il valore 2. Nei punti di intersezione
% infatti i pixel delle due metrici che assumono valore 1, sommandosi danno
% il valore 2

T=B+(1-skeleton);
[ro,c,v]=find(T>1);
% w = length(v);

% Rendo l'immagine somma binaria ponendo a 1 i pixel che a ssumono valore 2
% e a 0 tutti gli altri

for i=1:m;
    for j=1:n
        if T(i,j)==2;
            T(i,j)=1;
        else T(i,j)=0;
        end
    end
end;

% Determino il numero di intersezioni utilizzando la segmentazione della
% nuova immagine

[L,num] = bwlabel(T,8);  

B=zeros(size(skeleton));
Int(indice)=num;
end;
for i=1:9    
if Int(i)==0
    for j=i+1:9
        if Int(j)>0
            Int(i)=1
        end
    end
end
end
if Int(10)==0
    Int(10)=1
end
Intersezioni1=Int
set(handles.l_intersezioni1,'Value',1)
set(handles.l_intersezioni1,'String',{num2str(Intersezioni1(1)),num2str(Intersezioni1(2)),num2str(Intersezioni1(3)),num2str(Intersezioni1(4)),num2str(Intersezioni1(5)),...
                                     num2str(Intersezioni1(6)),num2str(Intersezioni1(7)),num2str(Intersezioni1(8)),num2str(Intersezioni1(9)),num2str(Intersezioni1(10))});




% Calcolo il numero massimo di intersezioni

set(handles.e_nmax1,'String','');
[Nm1,i]=max(Intersezioni1);
set(handles.e_nmax1,'String',num2str(Nm1));

% Calcolo il raggio del cerchio corrispondente al numero massimo di
% intersezioni(raggio critico)

set(handles.e_rcritico1,'String','');
r=[rmin:s:rmax];
rc1=r(i);
set(handles.e_rcritico1,'String',num2str(rc1));


% Calcolo l'indice di ramificazione di Schoenen (rapporto tra il numero massimo di intersezioni e il numero di dentriti primari) 

set(handles.e_schoenen1,'String','');
dp1=Intersezioni1(1);
S1=Nm1/dp1;
set(handles.e_schoenen1,'String',num2str(S1));


DM(1,1:10,d)=Intersezioni1; 
DM(1,11,d)=rc1;
DM(1,12,d)=Nm1;
DM(1,13,d)=S1;
                             
function e_livello_Callback(hObject, eventdata, handles)
% hObject    handle to e_livello (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_livello as text
%        str2double(get(hObject,'String')) returns contents of e_livello as a double


% --- Executes during object creation, after setting all properties.
function e_livello_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_livello (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in pop_elaborazione.
function pop_elaborazione_Callback(hObject, eventdata, handles)
% hObject    handle to pop_elaborazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_elaborazione contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_elaborazione

% global gg;
% global d;
% 
% str = get(hObject, 'String');
% val = get(hObject,'Value');
% 
% 
% switch str{val}    % Set current data to the selected data set.
% 
%     case 'Istogramma'
%         
%         global lg;
%         
%         axes(handles.a_immagine);
%         imshow(lg);
%         figure,imhist(lg);
%         
% 
% 
%     case 'Sogliatura'
% 
%         global lg;
%         global m1;
% 
%         n=get(handles.e_livello,'String');
%         n1=str2num(n) ;
% 
%         if isempty(n1)
%             msgbox('Scegliere il livello di soglia in base all''istogramma','Attenzione','warn')
%         else
%             n1=str2num(n);
%             m1=lg<n1;
%             axes(handles.a_immagine);
%             imshow(m1);
%         end;
% 
%     case 'Dilatazione'
% 
%         o=get(handles.e_disco,'String');
%         o1=str2num(o);
%         if isempty(o1)
%             msgbox('Scegliere la dimensione del disco di dilatazione','Attenzione','warn')
%         else
%             global se;
%             se = strel('disk',o1);
%             global MDIL;
%             global m1;
%             MDIL=imdilate(m1,se);
%             axes(handles.a_immagine);
%             imshow(MDIL);
%         end;
% 
%     case 'Segmentazione'
% 
%         global MDIL;
%         global L;
%         L=bwlabel(MDIL,4);
%         axes(handles.a_immagine);
%         imshow(L,[]);
% 
%     case'Estrazione sagoma'
% 
%         s=get(handles.e_sagoma,'String')
%         s1=str2num(s);
%         if isempty(s1)
%             msgbox('Scegliere la sagoma da visualizzare','Attenzione','warn')
%         else
%             axes(handles.a_immagine);
%             global L;
%             imshow(L==s1)
%             global se;
%             MER=imerode(L==s1,se);
%             global BW2;
%             BW1 = bwmorph(MER,'skel',Inf);
%             [m,n]=size(BW1);
%             BW1(1:(m+1),(n+1))=zeros(1,(m+1));
%             alto=zeros(1,(n+1));
%             BW1=[alto;BW1];
%             sinistra=zeros((m+2),1);
%             BW1=[sinistra BW1];
%             BW2=1-BW1;
%             axes(handles.a_immagine);
%             imshow(BW2)
%             axis equal;
%             axis tight;
%         end;
% 
%      
% end;



% --- Executes during object creation, after setting all properties.
function pop_elaborazione_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_elaborazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function e_sagoma_Callback(hObject, eventdata, handles)
% hObject    handle to e_sagoma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_sagoma as text
%        str2double(get(hObject,'String')) returns contents of e_sagoma as a double


% --- Executes during object creation, after setting all properties.
function e_sagoma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_sagoma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function e_disco_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_disco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_rmax.
function b_rmax_Callback(hObject, eventdata, handles)
% hObject    handle to b_rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global ax;
global ay;
global gg;
global DM;
global d;

% Inizializzo l'edit a zero

set(handles.e_rmax,'String','');

% Per calcolare il raggio massimo misuro la distanza di tutti i pixel
% dell'immagine dal centro e prendo come raggio massimo la distanza massima

[ro,c]=find(1-skeleton);
l=length(ro);
rm=zeros(1,l);

for i=1:l
 rm(i)=sqrt(((xc-c(i))^2)+((yc-ro(i))^2));
end;

[rmax,v] = max(rm);

ax=c(v);
ay=ro(v);

set(handles.e_rmax,'String','')
set(handles.e_rmax,'String',num2str(round(rmax)))

DM(1,175,d)=rmax;

function e_rmax_Callback(hObject, eventdata, handles)
% hObject    handle to e_rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rmax as text
%        str2double(get(hObject,'String')) returns contents of e_rmax as a double


% --- Executes during object creation, after setting all properties.
function e_rmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in l_intersezioni1.
function l_intersezioni1_Callback(hObject, eventdata, handles)
% hObject    handle to l_intersezioni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns l_intersezioni1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from l_intersezioni1


% --- Executes during object creation, after setting all properties.
function l_intersezioni1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l_intersezioni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in l_intersezioni1.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to l_intersezioni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns l_intersezioni1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from l_intersezioni1


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l_intersezioni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_cerchi1.
function b_cerchi1_Callback(hObject, eventdata, handles)
% hObject    handle to b_cerchi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO1;
global gg;
global d;

% Creo una matrice di zeri di dimensioni pari a quelle dell'immagine

[m,n]=size(skeleton);
B=zeros(size(skeleton));
SO1=zeros(size(skeleton));
SO1=SO1+(1-skeleton);

s=(rmax-rmin)/9;  % Distanza inter-cerchio (voglio costruire 10 cerchi)

% Pongo in B un pixel uguale ad uno se rispetta l'equazione del cerchio

for r=rmin:s:rmax
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;

end;
SO1=SO1+B;
end;

% axes(handles.a_immagine); 
%figure
imshow(1-SO1);

title(handles.a_immagine,sprintf('Photograph number %s     First reference system',num2str(gg)))
axis equal;
axis tight;


function e_1_Callback(hObject, eventdata, handles)
% hObject    handle to e_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_1 as text
%        str2double(get(hObject,'String')) returns contents of e_1 as a double


% --- Executes during object creation, after setting all properties.
function e_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_2_Callback(hObject, eventdata, handles)
% hObject    handle to e_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_2 as text
%        str2double(get(hObject,'String')) returns contents of e_2 as a double


% --- Executes during object creation, after setting all properties.
function e_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_3_Callback(hObject, eventdata, handles)
% hObject    handle to e_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_3 as text
%        str2double(get(hObject,'String')) returns contents of e_3 as a double


% --- Executes during object creation, after setting all properties.
function e_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_4_Callback(hObject, eventdata, handles)
% hObject    handle to e_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_4 as text
%        str2double(get(hObject,'String')) returns contents of e_4 as a double


% --- Executes during object creation, after setting all properties.
function e_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_4 (see GCBO)
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



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_cerchi2.
function b_cerchi2_Callback(hObject, eventdata, handles)
% hObject    handle to b_cerchi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO2;
global gg;
global d;

[m,n]=size(skeleton);
B=zeros(size(skeleton));
SO2=zeros(size(skeleton));
SO2=SO2+(1-skeleton);

s=60; % Pongo una distanza inter-cerchio fissa


for r=rmin:s:rmax
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;
SO2=SO2+B;
end;


axes(handles.a_immagine); 
imshow(1-SO2);
title(handles.a_immagine,sprintf('Photograph number %s     Second reference system',num2str(gg)))
axis equal;
axis tight;





% --- Executes on button press in b_intersezioni2.
function b_intersezioni2_Callback(hObject, eventdata, handles)
% hObject    handle to b_intersezioni2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO;
global Intersezioni2;
global indice;
global DM;
global N;
global gg;
global d;

set(handles.l_intersezioni2,'Value',1);
set(handles.l_intersezioni2,'String','');


[m,n]=size(skeleton);
B=zeros(size(skeleton));


s=60;

indice=0;

for r=rmin:s:rmax
    indice=indice+1;
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;


T=B+(1-skeleton);

for i=1:m;
    for j=1:n
        if T(i,j)==2;
            T(i,j)=1;
        else T(i,j)=0;
        end
    end
end;

[L,num] = bwlabel(T,8);   


B=zeros(size(skeleton));
Int(indice)=num;


Intersezioni2=Int;


end;

for i=1:(length(Intersezioni2)-1)    
if Intersezioni2(i)==0
    for j=i+1:(length(Intersezioni2)-1)  
        if Intersezioni2(j)>0
            Intersezioni2(i)=1
        end
    end
end
end

if Intersezioni2(length(Intersezioni2))==0
   Intersezioni2(length(Intersezioni2))=1
end
for indice=1:(length(Intersezioni2))
    lista=get(handles.l_intersezioni2,'String');
lista{indice}=Intersezioni2(indice);
set(handles.l_intersezioni2,'Value',1);
set(handles.l_intersezioni2,'String',lista);
end

% Calcolo il numero massimo di intersezioni

[Nm2,i]=max(Intersezioni2);
set(handles.e_nmax2,'String',num2str(Nm2));

% Calcolo il raggio del cerchio corrispondente al numero massimo di
% intersezioni(raggio critico)

r=[rmin:s:rmax];
rc2=r(i);
set(handles.e_rcritico2,'String',num2str(rc2));


% Calcolo l'indice di ramificazione di Schoenen (rapporto tra il numero massimo di intersezioni e il numero di dentriti primari) 

dp2=Intersezioni2(1);
S2=Nm2/dp2;
set(handles.e_schoenen2,'String',num2str(S2));  

Intersezioni2b=zeros(1,20);
Intersezioni2b(1:length(Intersezioni2))=Intersezioni2;

DM(1,60:79,d)=Intersezioni2b;

DM(1,80,d)=rc2;
DM(1,81,d)=Nm2;
DM(1,82,d)=S2;

% --- Executes on selection change in l_intersezioni2.
function l_intersezioni2_Callback(hObject, eventdata, handles)
% hObject    handle to l_intersezioni2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns l_intersezioni2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from l_intersezioni2


% --- Executes during object creation, after setting all properties.
function l_intersezioni2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l_intersezioni2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_estensione_Callback(hObject, eventdata, handles)
% hObject    handle to e_estensione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_estensione as text
%        str2double(get(hObject,'String')) returns contents of e_estensione as a double


% --- Executes during object creation, after setting all properties.
function e_estensione_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_estensione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_estensione.
function b_estensione_Callback(hObject, eventdata, handles)
% hObject    handle to b_estensione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global DM;
global N;
global bw;
global gg;
global d;

% Inizializzo a zero l'edit

set(handles.e_estensione,'String','')

 axes(handles.a_immagine); 
% figure
imshow(skeleton);
title(sprintf('Photograph number %s     Select the center to compute radial extension with 3 left click of mouse',num2str(gg)))
axis equal;
axis tight;
axis off;


% Individuo il centro con il clic del mouse per avere una maggiore
% precisione nella determinazione dell'estensione radiale

[xc1,yc1,but]=ginput(1);
[xc2,yc2,but]=ginput(1);
[xc3,yc3,but]=ginput(1);

if but==3       %Se clicco col tasto destro, esco
    return
end

[ro,c]=find(1-skeleton);


% Calcolo la distanza tra ciascun centro e i pixel dello scheletro, trovo
% la massima, e faccio la media delle tre distanze massime

l=length(ro);
rm=zeros(1,l);

for i=1:l
 rm(i)=sqrt(((xc1-c(i))^2)+((yc1-ro(i))^2));
end;
rmax1=max(rm);

for i=1:l
 rm(i)=sqrt(((xc2-c(i))^2)+((yc2-ro(i))^2));
end;
rmax2=max(rm);

for i=1:l
 rm(i)=sqrt(((xc3-c(i))^2)+((yc3-ro(i))^2));
end;
rmax3=max(rm);

D=(rmax1+rmax2+rmax3)/3;

set(handles.e_estensione,'String',num2str(D));

DM(1,170,d)=D;


% --- Executes on button press in b_lineare1.
function b_lineare1_Callback(hObject, eventdata, handles)
% hObject    handle to b_lineare1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global rmin;
global rmax;
global Intersezioni1;

% Numero di intersezione per area del cerchio in funzione del raggio

s=(rmax-rmin)/9;

r=rmin:s:rmax
y=Intersezioni1./(pi*(r.^2));
figure
plot(r,y,'o')

% --- Executes on button press in b_semilog1.
function b_semilog1_Callback(hObject, eventdata, handles)
% hObject    handle to b_semilog1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rmin;
global rmax;
global Intersezioni1;
global Rsl1;
global DM;
global N;
global gg;
global d;

% Logaritmo del numero di intersezione per area del cerchio in funzione del raggio

s=(rmax-rmin)/9;

r=rmin:s:rmax;

y=Intersezioni1./(pi*(r.^2));

%Calcolo del coefficiente di correlazione

set(handles.e_rsl1,'String','')
l=log10(y)
TF = isinf(l)
for i=1:length(TF)
 if TF(i)==1
l(i)=[ ]
r(i)=[ ]
 end
end
C1=corrcoef(r,l);
Rsl1=-C1(1,2);
set(handles.e_rsl1,'String',num2str(Rsl1))

DM(1,15,d)=Rsl1; 

% Calcolo parametri fitting

set(handles.e_ksl1,'String','')
[p,ErrorEst]=polyfit(r,l,1);
set(handles.e_ksl1,'String',num2str(p(1)))

DM(1,14,d)=p(1); 

% Valutazione del fitting
pop_fit=polyval(p,r,ErrorEst);
% Valutazione del fit e dell'errore di predizione
[pop_fit,delta] = polyval(p,r,ErrorEst);
% Plot dei dati, del fit e degli intervalli di confidenza
% figure
% plot(r,log10(y),'+',r,pop_fit,'g-',r,pop_fit+2*delta,'r:',r,pop_fit-2*delta,'r:'); 


% --- Executes on button press in b_loglog1.
function b_loglog1_Callback(hObject, eventdata, handles)
% hObject    handle to b_loglog1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rmin;
global rmax;
global Intersezioni1;
global Rsl1;
global DM;
global N;
global gg;
global d;

% Logaritmo del numero di intersezione per area del cerchio in funzione del logaritmo del raggio

s=(rmax-rmin)/9;

r=rmin:s:rmax;
y=Intersezioni1./(pi*(r.^2));

% Calcolo del coefficiente di correlazione

set(handles.e_rll1,'String','')
l=log10(y)
TF = isinf(l)
for i=1:length(TF)
 if TF(i)==1
l(i)=[ ]
r(i)=[ ]
 end
end
C1=corrcoef(log10(r),l);
Rll1=-C1(1,2);
set(handles.e_rll1,'String',num2str(Rll1))

DM(1,17,d)=Rll1;

% Calcolo parametri fitting

set(handles.e_kll1,'String','')
[p,ErrorEst]=polyfit(log10(r),l,1);
set(handles.e_kll1,'String',num2str(p(1)))

DM(1,16,d)=p(1);

% Valutazione del fitting
pop_fit=polyval(p,log10(r),ErrorEst);
% Valutazione del fit e dell'errore di predizione
[pop_fit,delta] = polyval(p,log10(r),ErrorEst);
% Plot dei dati, del fit e degli intervalli di confidenza
% figure
% plot(log10(r),log10(y),'+',log10(r),pop_fit,'g-',log10(r),pop_fit+2*delta,'r:',log10(r),pop_fit-2*delta,'r:'); 


%Calcolo del determination ratio

set(handles.e_delta1,'String','')
delta1=(Rsl1^2)/(Rll1^2);
set(handles.e_delta1,'String',num2str(delta1))

DM(1,18,d)=delta1;


% --- Executes on button press in b_lineare2.
function b_lineare2_Callback(hObject, eventdata, handles)
% hObject    handle to b_lineare2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rmin;
global rmax;
global Intersezioni2;

% Numero di intersezione per area del cerchio in funzione del raggio

s=40;

r=rmin:s:rmax
y=Intersezioni2./(pi*(r.^2));
figure
plot(r,y,'o')

% --- Executes on button press in b_semilog2.
function b_semilog2_Callback(hObject, eventdata, handles)
% hObject    handle to b_semilog2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rmin;
global rmax;
global Intersezioni2;
global Rsl2;
global DM;
global N;
global gg;
global d;

% Logaritmo del numero di intersezione per area del cerchio in funzione del raggio

s=60;

r=rmin:s:rmax;
y=Intersezioni2./(pi*(r.^2));

%Calcolo del coefficiente di correlazione

set(handles.e_rsl2,'String','')
l=log10(y)
TF = isinf(l)
for i=1:length(TF)
 if TF(i)==1
l(i)=[ ]
r(i)=[ ]
 end
end
C1=corrcoef(r,l);
Rsl2=-C1(1,2);
set(handles.e_rsl2,'String',num2str(Rsl2))

DM(1,84,d)=Rsl2;

% Calcolo parametri fitting

set(handles.e_ksl2,'String','')
[p,ErrorEst]=polyfit(r,l,1);
set(handles.e_ksl2,'String',num2str(p(1)))

DM(1,83,d)=p(1);

% Valutazione del fitting
pop_fit=polyval(p,r,ErrorEst);
% Valutazione del fit e dell'errore di predizione
[pop_fit,delta] = polyval(p,r,ErrorEst);
% Plot dei dati, del fit e degli intervalli di confidenza
% figure
% plot(r,log10(y),'+',r,pop_fit,'g-',r,pop_fit+2*delta,'r:',r,pop_fit-2*delta,'r:'); 

% --- Executes on button press in b_loglog2.
function b_loglog2_Callback(hObject, eventdata, handles)
% hObject    handle to b_loglog2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rmin;
global rmax;
global Intersezioni2;
global Rsl2;
global DM;
global N;
global gg;
global d;

% Logaritmo del numero di intersezione per area del cerchio in funzione del logaritmo del raggio

s=60;

r=rmin:s:rmax;
y=Intersezioni2./(pi*(r.^2));

%Calcolo del coefficiente di correlazione

set(handles.e_rll2,'String','')
l=log10(y)
TF = isinf(l)
for i=1:length(TF)
 if TF(i)==1
l(i)=[ ]
r(i)=[ ]
 end
end
C1=corrcoef(log10(r),l);
Rll2=-C1(1,2);
set(handles.e_rll2,'String',num2str(Rll2))

DM(1,86,d)=Rll2;

% Calcolo parametri fitting

set(handles.e_kll2,'String','')
[p,ErrorEst]=polyfit(log10(r),l,1);
set(handles.e_kll2,'String',num2str(p(1)))

DM(1,85,d)=p(1);

% Valutazione del fitting
pop_fit=polyval(p,log10(r),ErrorEst);
% Valutazione del fit e dell'errore di predizione
[pop_fit,delta] = polyval(p,log10(r),ErrorEst);
% Plot dei dati, del fit e degli intervalli di confidenza
% figure
% plot(log10(r),log10(y),'+',log10(r),pop_fit,'g-',log10(r),pop_fit+2*delta,'r:',log10(r),pop_fit-2*delta,'r:'); 


%Calcolo del determination ratio

set(handles.e_delta2,'String','')
delta2=(Rsl2^2)/(Rll2^2);
set(handles.e_delta2,'String',num2str(delta2))

DM(1,87,d)=delta2;



% --- Executes on button press in b_retta1.
function b_retta1_Callback(hObject, eventdata, handles)
% hObject    handle to b_retta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global DM;
global N;
global h;
global xv;
global yv;
global angle;
global gg;
global d;

% Inizializzo a zero l'edit

set(handles.e_cono,'String','')
% 
% % axes(handles.a_immagine); 


figure
% title('Left click on the cell soma' )
imshow(skeleton)
title(sprintf('Photograph number %s     Position the half-rect that form the cone in which the cell is encolsed',num2str(gg)))
axis equal;
axis tight;
axis off;

if N==1
h = helpdlg('If the cell has a uniform radial exention, right click with mouse, else left click on cell soma and then move the rects such as they form an angle in which the cell is encolsed');
uiwait(h);
end
% Individuo il vertice del cono con il clic del mouse

% axes(handles.a_immagine); 
%figure
imshow(skeleton);
title(handles.a_immagine,sprintf('Photograph number %s     Position the half-rect that form the cone in which the cell is encolsed',num2str(gg)))
axis equal;
axis tight;
axis off;

[xv,yv,but]=ginput(1);

if but==1 
    
h = imline(gca,[xv 100], [yv 100]);

pause(8)

b_retta2_Callback(hObject, eventdata, handles);

DM(1,172,d)=angle;


elseif but==3 % Se clicco con il tasto destro significa che la cellula si estende in tutte le direzioni
           % per cui l'angolo del cono viene  posto uguale a 360°
    
           angle=360;
           set(handles.e_cono,'String',num2str(angle))
           DM(1,172,gg)=angle;
 
          
end;


function e_soma_Callback(hObject, eventdata, handles)
% hObject    handle to e_soma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_soma as text
%        str2double(get(hObject,'String')) returns contents of e_soma as a double


% --- Executes during object creation, after setting all properties.
function e_soma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_soma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_cono_Callback(hObject, eventdata, handles)
% hObject    handle to e_cono (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_cono as text
%        str2double(get(hObject,'String')) returns contents of e_cono as a double


% --- Executes during object creation, after setting all properties.
function e_cono_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_cono (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_soma.
function b_soma_Callback(hObject, eventdata, handles)
% hObject    handle to b_soma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global photo;
global DM;
global N;
global gg;
global d;

% Inizializzo l'edit a zero

set(handles.e_soma,'String','')

axes(handles.a_immagine); 
imshow(photo);
title(handles.a_immagine,sprintf('Photograph number %s     Select the extremities of the soma axis ',num2str(gg)))
axis equal;
axis tight;
axis off;

% [m,n]=size(bw);
% B1=zeros(size(1-bw));
% B2=zeros(size(1-bw));
% SO=1-bw;

% Individuo con il clic del mouse le estremità degli assi dell'ellisse che
% approssima il soma

[xa1,ya1,but]=ginput(1); % estremità destra asse minore
[xa2,ya2,but]=ginput(1); % estremità sinistra asse minore
[xb1,yb1,but]=ginput(1); % estremità superiore asse maggiore
[xb2,yb2,but]=ginput(1); % estremità inferiore asse maggiore

if but==3       %Se clicco col tasto destro, esco
    return
end

% Calcolo la lunghezza degli assi

a=(sqrt(((xa1-xa2)^2)+((ya1-ya2)^2)))/2;
b=(sqrt(((xb1-xb2)^2)+((yb1-yb2)^2)))/2;



% Calcolo l'area dell'ellisse

A=pi*a*b;
set(handles.e_soma,'String',num2str(round(A)));


DM(1,171,d)=A;



function e_percestr1_Callback(hObject, eventdata, handles)
% hObject    handle to e_percestr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_percestr1 as text
%        str2double(get(hObject,'String')) returns contents of e_percestr1 as a double


% --- Executes during object creation, after setting all properties.
function e_percestr1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_percestr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_percasse1_Callback(hObject, eventdata, handles)
% hObject    handle to e_percasse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_percasse1 as text
%        str2double(get(hObject,'String')) returns contents of e_percasse1 as a double


% --- Executes during object creation, after setting all properties.
function e_percasse1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_percasse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_vettestr1.
function b_vettestr1_Callback(hObject, eventdata, handles)
% hObject    handle to b_vettestr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Lmine1;

figure
plot(1:1:10,Lmine1);

% --- Executes on button press in b_vettasse1.
function b_vettasse1_Callback(hObject, eventdata, handles)
% hObject    handle to b_vettasse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 global Lmina1;
 
figure
plot(1:1:length(Lmina1),Lmina1);


% --- Executes on button press in b_percestr2.
function b_percestr2_Callback(hObject, eventdata, handles)
% hObject    handle to b_percestr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO2;
global Intersezioni1;
global rmax;
global Lmine2;
global ange2;
global DM;
global N;
global gg;
global ax;
global ay;
global d;
%

[ro,c]=find(1-skeleton);
l=length(ro);
rm=zeros(1,l);

for i=1:l
 rm(i)=sqrt(((xc-c(i))^2)+((yc-ro(i))^2));
end;

[rmax,v] = max(rm);

ax=c(v);
ay=ro(v);

axes(handles.a_immagine);
imshow(1-SO2);
title(sprintf('Photograph number %s',num2str(gg)))

set(handles.e_percestr2,'String','')

[m,n]=size(skeleton);

B=zeros(size(skeleton));
L=zeros(size(skeleton));

s=60;

indice=0;


for r=rmin:s:rmax
    indice=indice+1;
    for teta=0:2*pi/3600:2*pi
        x=round(r*cos(teta))+round(xc);
        y=round(r*sin(teta))+round(yc);
        if x>0 & x<n
            if y>0 & y<m
                B(y,x)=1;
            end;
        end;
    end;
    T=B+(1-skeleton);
    [ro,c,v]=find(T>1);
    R{indice}=ro(1:length(v));
    C{indice}=c(1:length(v));
    B=zeros(size(skeleton));
end;

for r=rmin:s:rmax
    for teta=0:2*pi/3600:2*pi
        x=round(r*cos(teta))+round(xc);
        y=round(r*sin(teta))+round(yc);
        if x>0 & x<n
            if y>0 & y<m
                B(y,x)=1;
            end;
        end;
    end;
    T=B+(1-skeleton);
end;
a=zeros(1,indice+1);
Lmine2=zeros(1,indice+1);
ange2=zeros(1,indice);
P=0;

indice=indice-1; 
f=length(R{indice});
l=zeros(1,f);



for j=1:f
    
    l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
end

[lu,k]=min(l);

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k);
    by=R{indice}(k);
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
Lmine2(indice+1)=lmin;
P=P+lmin;

if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
   a(indice+1)=atand((by-ay)/(bx-ax)); 


while indice>1

    ax=bx;
    ay=by;
    indice=indice-1;

    f=length(R{indice});
    l=zeros(1,f);

    for j=1:f
        l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
    end;
[lu,k]=min(l);

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k);
    by=R{indice}(k);
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
    Lmine2(indice+1)=lmin;
    P=P+lmin;
    if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.1:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
    a(indice+1)=atand((by-ay)/(bx-ax));
end;

ax=bx;
ay=by;
lmin=sqrt(((ax-xc)^2)+((ay-yc)^2));
Lmine2(indice)=lmin;
P=P+lmin;
if ax==xc
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
for x=min(ax,xc):0.01:max(ax,xc)
      y=round((((yc-ay)/(xc-ax))*x)+((ay*xc-ax*yc)/(xc-ax)));
      L(y,round(x))=1;
end;  
end;
a(indice)= atand((yc-ay)/(xc-ax));  

for j=1:length(ange2)
    if a(j)>0 & a(j+1)>0
ange2(j)= a(j+1)-a(j);
    elseif a(j)<0 & a(j+1)<0
        ange2(j)=-a(j+1)-a(j);
    elseif a(j+1)<0 & a(j)>0
        ange2(j)=180-(-a(j+1)+a(j));
    elseif a(j+1)>0 & a(j)<0
       ange2(j)= 180-(a(j+1)-a(j));
 
    end;       
end;
axes(handles.a_immagine);
imshow(1-(L+T));
title(handles.a_immagine,sprintf('Photograph number %s     Minimum pathway between center and extremity',num2str(gg)))

%figure
imshow(1-(L+T));
title(sprintf('Photograph number %s     Minimum pathway between center and extremity',num2str(gg)))

set(handles.e_percestr2,'String',num2str(P));

DM(1,88,d)=P;

Lmine2b=zeros(1,20);
Lmine2b(1:length(Lmine2))=Lmine2;

DM(1,89:108,d)=Lmine2b;

ange2b=zeros(1,20);
ange2b(1:length(ange2))=ange2;

DM(1,109:128,d)=ange2b;


function e_percestr2_Callback(hObject, eventdata, handles)
% hObject    handle to e_percestr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_percestr2 as text
%        str2double(get(hObject,'String')) returns contents of e_percestr2 as a double


% --- Executes during object creation, after setting all properties.
function e_percestr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_percestr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_percasse2.
function b_percasse2_Callback(hObject, eventdata, handles)
% hObject    handle to b_percasse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO2;
global Intersezioni1;
global rmax;
global Lmina2;
global anga2;
global DM;
global N;
global gg;
global d;


 axes(handles.a_immagine);
% figure
imshow(1-SO2);
title(sprintf('Photograph number %s     Secect the extremity of principal axis',num2str(gg)))

L=zeros(size(skeleton));
B=zeros(size(skeleton));

s=60;
[m,n]=size(skeleton)

set(handles.e_percasse2,'String','')

indice=0;

for r=rmin:s:rmax
     indice=indice+1;
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;

end;
[m,n]=size(B)
T=B+(1-skeleton);
[ro,c,v]=find(T>1);
R{indice}=ro(1:length(v));
C{indice}=c(1:length(v));
B=zeros(size(skeleton));
end;

for r=rmin:s:rmax
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;

end;
[m,n]=size(skeleton)
T=B+(1-skeleton);
end;


[xa,ya,but]=ginput(1);

if but==3       %Se clicco col tasto destro, esco
    return
end

dist=sqrt(((xa-xc)^2)+((ya-yc)^2))-rmin;

indice=ceil(dist/s);

Lmina2=zeros(1,indice+1);
a=zeros(1,indice+1);
anga2=zeros(1,indice);
P=0;
ax=xa;
ay=ya;
f=length(R{indice});
l=zeros(1,f);

for j=1:f
    l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
end;

[lu,k]=min(l);

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k);
    by=R{indice}(k);
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
Lmina2(indice+1)=lmin;
P=P+lmin;

   if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
    a(indice+1)=atand((by-ay)/(bx-ax));



while indice>1
    ax=bx;
    ay=by;
    indice=indice-1;
    f=length(R{indice});
    l=zeros(1,f);
    for j=1:f
        l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
    end;
[lu,k]=min(l);

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k)
    by=R{indice}(k)
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
    Lmina2(indice+1)=lmin;
    P=P+lmin;
    if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
    a(indice+1)=atand((by-ay)/(bx-ax));
end;

ax=bx;
ay=by;
lmin=sqrt(((ax-xc)^2)+((ay-yc)^2));
Lmina2(indice)=lmin;
P=P+lmin;
if ax==xc
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
for x=min(ax,xc):0.01:max(ax,xc)
    y=round((((yc-ay)/(xc-ax))*x)+((ay*xc-ax*yc)/(xc-ax)));
    L(y,round(x))=1;
end;
end;
a(indice+1)=atand((yc-ay)/(xc-ax));

for j=1:length(anga2)
    if a(j)>0 & a(j+1)>0
        anga2(j)= a(j+1)-a(j);
    elseif a(j)<0 & a(j+1)<0
        anga2(j)=-a(j+1)-a(j);
    elseif a(j+1)<0 & a(j)>0
        anga2(j)=180-(-a(j+1)+a(j));
    elseif a(j+1)>0 & a(j)<0
        anga2(j)= 180-(a(j+1)-a(j));
    end;
end;

axes(handles.a_immagine);
imshow(1-(L+T));
title(handles.a_immagine,sprintf('Photograph number %s     Minimum pathway on principal axis',num2str(gg)))

%figure
imshow(1-(L+T));
title(sprintf('Photograph number %s     Minimum pathway on principal axis',num2str(gg)))

set(handles.e_percasse2,'String',num2str(P));


DM(1,129,d)=P;


Lmina2b=zeros(1,20);
Lmina2b(1:length(Lmina2))=Lmina2;

DM(1,130:149,d)=Lmina2b;

anga2b=zeros(1,20);
anga2b(1:length(anga2))=anga2;

DM(1,150:169,d)=anga2b;


function e_percasse2_Callback(hObject, eventdata, handles)
% hObject    handle to e_percasse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_percasse2 as text
%        str2double(get(hObject,'String')) returns contents of e_percasse2 as a double


% --- Executes during object creation, after setting all properties.
function e_percasse2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_percasse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_vettestr2.
function b_vettestr2_Callback(hObject, eventdata, handles)
% hObject    handle to b_vettestr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global Lmine2;

figure
plot(1:1:length(Lmine2),Lmine2);


% --- Executes on button press in b_vettasse2.
function b_vettasse2_Callback(hObject, eventdata, handles)
% hObject    handle to b_vettasse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global Lmina2;

figure
plot(1:1:length(Lmina2),Lmina2);


% --- Executes on button press in b_angoliestr1.
function b_angoliestr1_Callback(hObject, eventdata, handles)
% hObject    handle to b_angoliestr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




global ange1;

figure
plot(1:9,ange1);









% --- Executes on button press in b_angoliasse1.
function b_angoliasse1_Callback(hObject, eventdata, handles)
% hObject    handle to b_angoliasse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global anga1;

figure
plot(1:1:length(anga1),anga1);




% --- Executes on button press in b_angoliestr2.
function b_angoliestr2_Callback(hObject, eventdata, handles)
% hObject    handle to b_angoliestr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ange2;

figure
plot(1:length(ange2),ange2);



% --- Executes on button press in b_angoliasse2.
function b_angoliasse2_Callback(hObject, eventdata, handles)
% hObject    handle to b_angoliasse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global anga2;

figure
plot(1:length(anga2),anga2);



function e_rsl1_Callback(hObject, eventdata, handles)
% hObject    handle to e_rsl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rsl1 as text
%        str2double(get(hObject,'String')) returns contents of e_rsl1 as a double


% --- Executes during object creation, after setting all properties.
function e_rsl1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rsl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_ksl1_Callback(hObject, eventdata, handles)
% hObject    handle to e_ksl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_ksl1 as text
%        str2double(get(hObject,'String')) returns contents of e_ksl1 as a double


% --- Executes during object creation, after setting all properties.
function e_ksl1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_ksl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_kll1_Callback(hObject, eventdata, handles)
% hObject    handle to e_kll1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_kll1 as text
%        str2double(get(hObject,'String')) returns contents of e_kll1 as a double


% --- Executes during object creation, after setting all properties.
function e_kll1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_kll1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_rll1_Callback(hObject, eventdata, handles)
% hObject    handle to e_rll1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rll1 as text
%        str2double(get(hObject,'String')) returns contents of e_rll1 as a double


% --- Executes during object creation, after setting all properties.
function e_rll1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rll1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_delta1_Callback(hObject, eventdata, handles)
% hObject    handle to e_delta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_delta1 as text
%        str2double(get(hObject,'String')) returns contents of e_delta1 as a double


% --- Executes during object creation, after setting all properties.
function e_delta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_delta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_ksl2_Callback(hObject, eventdata, handles)
% hObject    handle to e_ksl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_ksl2 as text
%        str2double(get(hObject,'String')) returns contents of e_ksl2 as a double


% --- Executes during object creation, after setting all properties.
function e_ksl2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_ksl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_rsl2_Callback(hObject, eventdata, handles)
% hObject    handle to e_rsl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rsl2 as text
%        str2double(get(hObject,'String')) returns contents of e_rsl2 as a double


% --- Executes during object creation, after setting all properties.
function e_rsl2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rsl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_kll2_Callback(hObject, eventdata, handles)
% hObject    handle to e_kll2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_kll2 as text
%        str2double(get(hObject,'String')) returns contents of e_kll2 as a double


% --- Executes during object creation, after setting all properties.
function e_kll2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_kll2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_rll2_Callback(hObject, eventdata, handles)
% hObject    handle to e_rll2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rll2 as text
%        str2double(get(hObject,'String')) returns contents of e_rll2 as a double


% --- Executes during object creation, after setting all properties.
function e_rll2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rll2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_delta2_Callback(hObject, eventdata, handles)
% hObject    handle to e_delta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_delta2 as text
%        str2double(get(hObject,'String')) returns contents of e_delta2 as a double


% --- Executes during object creation, after setting all properties.
function e_delta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_delta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_start.
function b_start_Callback(hObject, eventdata, handles)
% hObject    handle to b_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


b_centro_Callback(hObject, eventdata, handles);   

b_raggiominimo_Callback(hObject, eventdata, handles);

b_rmax_Callback(hObject, eventdata, handles); 

b_cerchi1_Callback(hObject, eventdata, handles); 

b_intersezioni1_Callback(hObject, eventdata, handles); 

b_lineare1_Callback(hObject, eventdata, handles); 

b_semilog1_Callback(hObject, eventdata, handles); 

b_loglog1_Callback(hObject, eventdata, handles); 

b_percestr1_Callback(hObject, eventdata, handles); 

b_percasse1_Callback(hObject, eventdata, handles); 

b_cerchi2_Callback(hObject, eventdata, handles); 

b_intersezioni2_Callback(hObject, eventdata, handles); 

b_lineare2_Callback(hObject, eventdata, handles); 

b_semilog2_Callback(hObject, eventdata, handles); 

b_loglog2_Callback(hObject, eventdata, handles); 

b_percestr2_Callback(hObject, eventdata, handles); 

b_percasse2_Callback(hObject, eventdata, handles); 

b_estensione_Callback(hObject, eventdata, handles);

b_soma_Callback(hObject, eventdata, handles);

b_cono_Callback(hObject, eventdata, handles);


% --- Executes on button press in b_percestr1.
function b_percestr1_Callback(hObject, eventdata, handles)
% hObject    handle to b_percestr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO1;
global Intersezioni1;
global rmax;
global Lmine1;
global ange1;
global DM;
global N;
global gg;
global ax;
global ay;
global d;

[ro,c]=find(1-skeleton);
l=length(ro);
rm=zeros(1,l);

for i=1:l
 rm(i)=sqrt(((xc-c(i))^2)+((yc-ro(i))^2));
end;

[rmax,v] = max(rm);

ax=c(v);
ay=ro(v);
axes(handles.a_immagine);
imshow(1-SO1);
title(handles.a_immagine,sprintf('Photograph number %s',num2str(gg)))

% Inizializzo l'edit a zero

set(handles.e_percestr1,'String','')

[m,n]=size(skeleton)
B=zeros(size(skeleton));

% Creo una matrice di tutti zero delle dimensioni dell'immagine

L=zeros(size(skeleton));

s=(rmax-rmin)/9;

indice=0;

% Memorizzo le coordinate di tutti i pixel di intersezione

for r=rmin:s:rmax
     indice=indice+1;
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;
T=B+(1-skeleton);
[ro,c,v]=find(T>1);
R{indice}=ro(1:length(v));
C{indice}=c(1:length(v));
B=zeros(size(skeleton));
end;

for r=rmin:s:rmax
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;
T=B+(1-skeleton);
end;

% Creo un array di zeri di lunghezza pari al numero di zeri dova mettere le
% lunghezze minime

Lmine1=zeros(1,10);
a=zeros(1,10);

% Creo un array di zeri di lunghezza pari al numero di zeri dova mettere
% gli angoli tra i vettori delle lunghezze minime

ange1=zeros(1,9);

P=0;
% indice=10
% indice
indice=indice-1; 

f=length(R{indice});
l=zeros(1,f);

% Calcolo le distanze tra i pixel di intersezione su due cerchi consecutivi
% e prendo la minima.

for j=1:f
    l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2))
end;
[lu,k]=min(l)

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k)
    by=R{indice}(k)
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
Lmine1(indice+1)=lmin;

P=P+lmin;


% Rappresento le lunghezze minime sull'immagine ponendo a 1 i pixel di L
% che rispettano l'equazione di una retta passante per i pixel di
% intersezione.
% Calcolo anche l'angolo che ciascun vettore lunghezza forma con
% l'orizzontale come arcotangente del coefficiente angolare della retta

   if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
   a(indice+1)=atand((by-ay)/(bx-ax));   




while indice>1
    ax=bx;
    ay=by;
    indice=indice-1;
    f=length(R{indice});
    l=zeros(1,f);
    for j=1:f
        l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
    end;
    [lu,k]=min(l)
if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k)
    by=R{indice}(k)
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
    Lmine1(indice+1)=lmin;
    P=P+lmin;
    if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
    a(indice+1)=atand((by-ay)/(bx-ax)) ;
end;
    
ax=bx;
ay=by;
lmin=sqrt(((ax-xc)^2)+((ay-yc)^2));
Lmine1(indice)=lmin;
P=P+lmin;
if ax==xc
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
for x=min(ax,xc):0.01:max(ax,xc)
    y=round((((yc-ay)/(xc-ax))*x)+((ay*xc-ax*yc)/(xc-ax)));
    L(y,round(x))=1;
end;
end;
a(indice)= atand((yc-ay)/(xc-ax));

% Calcolo gli angoli compresi tra due segmenti consecutivi
% N.B. : se il prolungamento è a sinistra l'angolo viene preso positivo

for j=1:length(ange1)
    if a(j)>0 & a(j+1)>0
ange1(j)= a(j+1)-a(j);
    elseif a(j)<0 & a(j+1)<0
        ange1(j)=-a(j+1)-a(j);
    elseif a(j+1)<0 & a(j)>0
        ange1(j)=180-(-a(j+1)+a(j));
    elseif a(j+1)>0 & a(j)<0
       ange1(j)= 180-(a(j+1)-a(j));
 
    end;       
end;

axes(handles.a_immagine)
imshow(1-(L+T));
title(handles.a_immagine,sprintf('Photograph number %s     Minimum pathway between center and extremity of cell',num2str(gg)))

% figure
% imshow(1-(L+T));
% title(sprintf('Foto numero %s     Percorso estremità nel primo sistema di riferimento',num2str(gg)))

set(handles.e_percestr1,'String',num2str(P));

DM(1,19,d)=P;

DM(1,20:29,d)=Lmine1;

DM(1,30:38,d)=ange1;

% --- Executes on button press in b_percasse1.
function b_percasse1_Callback(hObject, eventdata, handles)
% hObject    handle to b_percasse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global xc;
global yc;
global rmax;
global rmin;
global SO1;
global Intersezioni1;
global rmax;
global Lmina1;
global anga1;
global DM;
global N;
global gg;
global d;

% La stessa cosa che è stata fatta prendendo come estremo l'estremità dell
% a cellula viene fatto prendendo come estremo il pixel più distante dal
% centro sull'asse principale

 axes(handles.a_immagine);
% figure
imshow(1-SO1);
title(sprintf('Photograph number %s     Select the extremity of principal axis',num2str(gg)))

L=zeros(size(skeleton));
B=zeros(size(skeleton));

s=(rmax-rmin)/9
[m,n]=size(skeleton);

set(handles.e_percasse1,'String','')

indice=0;

for r=rmin:s:rmax
     indice=indice+1;
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;
T=B+(1-skeleton);
[ro,c,v]=find(T>1);
R{indice}=ro(1:length(v));
C{indice}=c(1:length(v));
B=zeros(size(skeleton));
end;

for r=rmin:s:rmax
for teta=0:2*pi/3600:2*pi
    x=round(r*cos(teta))+round(xc);
    y=round(r*sin(teta))+round(yc);
    if x>0 & x<n 
        if y>0 & y<m
        B(y,x)=1;
        end;
    end;
end;
T=B+(1-skeleton);
end;

% Con il clic del mouse seleziono l'estremità dell'asse principale

[xa,ya,but]=ginput(1);

if but==3       %Se clicco col tasto destro, esco
    return
end

% Prendo come indice di partenza quello corispondente al cerchio di
% distanza aèpena inferiore alla distanza del punto di estremità dell'asse
% principale rispetto al centro 

dist=sqrt(((xa-xc)^2)+((ya-yc)^2))-rmin;

indice=ceil(dist/s);

Lmina1=zeros(1,indice+1);
a=zeros(1,indice+1);
anga1=zeros(1,indice);

P=0;

ax=xa;
ay=ya;

f=length(R{indice});
l=zeros(1,f);

for j=1:f
    l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
end;
[lu,k]=min(l);

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k)
    by=R{indice}(k)
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
Lmina1(indice+1)=lmin;
P=P+lmin;

   if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
         
    end;

   a(indice+1)=atand((by-ay)/(bx-ax)); 
while indice>1

    ax=bx;
    ay=by;
    indice=indice-1;
    f=length(R{indice});
    l=zeros(1,f);
    for j=1:f
        l(j)=sqrt(((ax-(C{indice}(j)))^2)+((ay-(R{indice}(j)))^2));
    end;
[lu,k]=min(l);

if lu<sqrt((120*rmin)+(8200*indice)-3600)
    lmin=lu;
    bx=C{indice}(k)
    by=R{indice}(k)
else
    lmin=60;
if ax<n/2 && ay<m/2
    bx=ax+round(60/sqrt(2));
    by=ay+round(60/sqrt(2));
elseif ax<n/2 && ay>m/2
        bx=ax+round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay>m/2
        bx=ax-round(60/sqrt(2));
        by=ay-round(60/sqrt(2));
elseif ax>n/2 && ay<m/2
        bx=ax-round(60/sqrt(2));
        by=ay+round(60/sqrt(2));        
end;
end;
    Lmina1(indice+1)=lmin;
    P=P+lmin;
    if ax==bx
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
        for x=min(ax,bx):0.01:max(ax,bx)
            y=round((((by-ay)/(bx-ax))*x)+((ay*bx-ax*by)/(bx-ax)));
            L(y,round(x))=1;
        end;
    end;
    a(indice+1)=atand((by-ay)/(bx-ax));
end;
ax=bx;
ay=by;
lmin=sqrt(((ax-xc)^2)+((ay-yc)^2));
Lmina1(indice)=lmin;
P=P+lmin;
if ax==xc
        for y=min(ay,by):0.01:max(ay,by)
            L(round(y),round(x))=1;
        end;
    else
for x=min(ax,xc):0.01:max(ax,xc)
    y=round((((yc-ay)/(xc-ax))*x)+((ay*xc-ax*yc)/(xc-ax)));
    L(y,round(x))=1;
end;
end;
a(indice)=atand((yc-ay)/(xc-ax));

for j=1:length(anga1)
    if a(j)>0 & a(j+1)>0
anga1(j)= a(j+1)-a(j);
    elseif a(j)<0 & a(j+1)<0
        anga1(j)=-a(j+1)-a(j);
    elseif a(j+1)<0 & a(j)>0
        anga1(j)=180-(-a(j+1)+a(j));
    elseif a(j+1)>0 & a(j)<0
       anga1(j)= 180-(a(j+1)-a(j));
 
    end;       
end;
% close
axes(handles.a_immagine);
imshow(1-(L+T));
title(handles.a_immagine,sprintf('Photograph number %s     Minimum pathway on the principal axis',num2str(gg)))



set(handles.e_percasse1,'String',num2str(P));

DM(1,39,d)=P;

Lmina1b=zeros(1,10)
Lmina1b(1:length(Lmina1))=Lmina1

DM(1,40:49,d)=Lmina1b;

anga1b=zeros(1,10);
anga1b(1:length(anga1))=anga1;

DM(1,50:59,d)=anga1b;

% --- Executes on selection change in pop_variabilit.
function pop_variabilit_Callback(hObject, eventdata, handles)
% hObject    handle to pop_variabilit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_variabilit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_variabilit

global nu;
global DM;
global Intersezioni2;
global t;
global d;

str = get(hObject, 'String');
val = get(hObject,'Value');

switch str{val}    
    
    case 'Intersctions1'
     
       Int1t=zeros(10,10);
       
       figure
           for j=1:10
               for i=1:10
           Int1t(i,j)=DM(1,j,i);
               end 
                plot(Int1t,'DisplayName','Cerchio')
           end
             
    case 'Nm1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,12,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of Nm')
       
    case 'rc1'
       
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,11,i);
       end
       figure
       plot(1:10,v)
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of rc')
        
    case 'Schoenen1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,13,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of Schoenen index')
        
    case 'ksl1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,14,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of ksl')
        
    case 'Rsl1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,15,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of Rsl')
       
        
    case 'kll1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,16,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of kll')
        
    case 'Rll1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,17,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of Rll')
        
    case 'Delta1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,18,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of Delta')
       
    case 'Pextr1'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,15,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of minimum pathway between center and extremity of cell')
        
    case 'Paxis1'
         
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,39,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant circles: Plot of minimum pathway on principal axis of cell')
        
    case 'Intersections2'
        
       Int2t=zeros(10,20);
            
       figure
           indice=60;
           for j=1:20 
               for i=1:10               
               Int2t(i,j)=DM(1,indice,i);
               end 
               indice=indice+1;
           end
           
               [r,c]=find(Int2t);
               Int2tb=Int2t(:,1:max(c))
               plot(Int2tb,'DisplayName','Cerchio')
         
   
    case 'Nm2'
  
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,81,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of Nm')
        
    case 'rc2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,80,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of rc')
       
    case 'Schoenen2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,82,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of Schoenen index')
       
    case 'ksl2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,83,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of ksl')
        
    case 'Rsl2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,84,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of Rsl')
        
    case 'kll2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,85,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of kll')
       
    case 'Rll2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,86,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of Rll')
        
    case 'Delta2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,87,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of Delta')
        
    case 'Pextr2'
               
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,88,i);
       end
       figure
       plot(1:10,v)
       title('Reference system with constant inter-circle distance: Plot of minimum pathway between center and extremity of cell')
       
    case 'Paxis2'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,15,i);
       end
       figure
       plot(1:129,v)
       title('Reference system with constant inter-circle distance: Plot of minimum pathway on principal axis of cell')
       
    case 'Extension'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,170,i);
       end
       figure
       plot(1:10,v)
       title('Plot of radial extension')
        
    case 'Soma area'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,171,i);
       end
       figure
       plot(1:10,v)
       title('Plot of soma area')
        
    case 'Cone angle'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,172,i);
       end
       figure
       plot(1:10,v)
       title('Plot of cone angle')
       
    case 'Fractal dimension'
        
       v=zeros(1,10);
       for i=1:10
       v(i)= DM(1,173,i);
       end
       figure
       plot(1:10,v)
       title('Plot of fractal dimension')
        
end













% --- Executes during object creation, after setting all properties.
function pop_variabilit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_variabilit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function e_giorno_Callback(hObject, eventdata, handles)
% hObject    handle to e_giorno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_giorno as text
%        str2double(get(hObject,'String')) returns contents of e_giorno as a double


% --- Executes during object creation, after setting all properties.
function e_giorno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_giorno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on selection change in pop_variabilig.
function pop_variabilig_Callback(hObject, eventdata, handles)
% hObject    handle to pop_variabilig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_variabilig contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_variabilig


global scheletro;
global DM;
global rmin;
global rmax;
global Lmina1;
global anga1;
global Lmine2;
global ange2;
global Lmina2;
global anga2;
global Intersezioni2;



str = get(hObject, 'String');
val = get(hObject,'Value');

g=str2num(get(handles.e_giorno,'String'))

switch str{val}    
    
    case 'Intersections1Linear'
     
        s=(rmax-rmin)/9;
        r=rmin:s:rmax;
        y=(DM(1,1:10,g))./(pi*(r.^2));
        figure
        plot(r,y,'o')
        title('Sistema di riferimento cerchi costanti: Metodo Lineare')
        
    case 'Intersections1Semi-Log'
        
        s=(rmax-rmin)/9;
        r=rmin:s:rmax;
        y=(DM(1,1:10,g))./(pi*(r.^2));   
        [p,ErrorEst]=polyfit(r,log10(y),1);
        pop_fit=polyval(p,r,ErrorEst);
        [pop_fit,delta] = polyval(p,r,ErrorEst);
        % Plot dei dati, del fit e degli intervalli di confidenza
        figure
        plot(r,log10(y),'+',r,pop_fit,'g-',r,pop_fit+2*delta,'r:',r,pop_fit-2*delta,'r:');
        title('Sistema di riferimento cerchi costanti: Metodo Semi-Log')
        
    case 'Intersections1Log-Log'
   
        s=(rmax-rmin)/9;
        r=rmin:s:rmax;
        y=(DM(1,1:10,g))./(pi*(r.^2));
        [p,ErrorEst]=polyfit(log10(r),log10(y),1);
        pop_fit=polyval(p,log10(r),ErrorEst);
        [pop_fit,delta] = polyval(p,log10(r),ErrorEst);
        % Plot dei dati, del fit e degli intervalli di confidenza
        figure
        plot(log10(r),log10(y),'+',log10(r),pop_fit,'g-',log10(r),pop_fit+2*delta,'r:',log10(r),pop_fit-2*delta,'r:')
        title('Sistema di riferimento cerchi costanti: Metodo Log-Log')
        
    case 'Nm1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,12,g)))
        
    case 'rc1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,11,g)))
        
    case 'Schoenen1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,13,g)))
        
    case 'ksl1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,14,g)))
        
    case 'Rsl1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,15,g)))
        
    case 'kll1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,16,g)))
        
    case 'Rll1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,17,g)))
        
    case 'Delta1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,18,g)))
        
    case 'Pextr1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,19,g)))
        
    case 'Lminextr1'
       
        figure
        plot(1:1:10,DM(1,20:29,g));
        title('Sistema di riferimento cerchi costanti: Vettore delle lunghezze minime dall''estremità al centro')
        
    case 'Aextr1'
        
         figure
         plot(1:1:9,DM(1,30:38,g));
         title('Sistema di riferimento cerchi costanti: Vettore degli angoli dall''estremità al centro')
         
    case 'Paxis1'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,39,g)))
        
    case 'Lminaxis1'
        
        ind=find(DM(:,40:49,g));
        c=DM(:,40:40+max(ind)-1,g)
        figure
        plot(1:1:length(Lmina1),c);
        title('Sistema di riferimento cerchi costanti: Vettore delle lunghezze minime dall''estremità dell''asse principale al centro')
        
    case 'Aaxis1'
        
        ind=find(DM(:,50:59,g));
        c=DM(:,50:50+max(ind)-1,g)
        figure
        plot(1:1:length(anga1),c);
        title('Sistema di riferimento cerchi costanti: Vettore degli angoli dall''estremità dell''asse principale al centro')
        
    case 'Intersections2Lineare'
        
        s=60;
        r=rmin:s:rmax
        ind=find(DM(:,60:79,g));
        c=DM(:,60:60+max(ind)-1,g);
        y=c(1:length(r))./(pi*(r.^2));
        figure
        plot(r,y,'o')
        title('Sistema di riferimento distanza inter-cerchi costante : Metodo Lineare')
        
    case 'Intersections2Semi-Log'
        
        s=60;
        r=rmin:s:rmax;
        ind=find(DM(:,60:79,g));
        c=DM(:,60:60+max(ind)-1,g);
        y=c(1:length(r))./(pi*(r.^2));
        [p,ErrorEst]=polyfit(r,log10(y),1);
        pop_fit=polyval(p,r,ErrorEst);
        [pop_fit,delta] = polyval(p,r,ErrorEst);
        % Plot dei dati, del fit e degli intervalli di confidenza
        figure
        plot(r,log10(y),'+',r,pop_fit,'g-',r,pop_fit+2*delta,'r:',r,pop_fit-2*delta,'r:');
        title('Sistema di riferimento distanza inter-cerchio costante: Metodo Semi-Log')
        
    case 'Intersections2Log-Log'
        
        s=60;
        r=rmin:s:rmax;
        ind=find(DM(:,60:79,g));
        c=DM(:,60:60+max(ind)-1,g)
        y=c(1:length(r))./(pi*(r.^2));
        [p,ErrorEst]=polyfit(log10(r),log10(y),1);
        pop_fit=polyval(p,log10(r),ErrorEst);
        [pop_fit,delta] = polyval(p,log10(r),ErrorEst);
        % Plot dei dati, del fit e degli intervalli di confidenza
        figure
        plot(log10(r),log10(y),'+',log10(r),pop_fit,'g-',log10(r),pop_fit+2*delta,'r:',log10(r),pop_fit-2*delta,'r:');
        title('Sistema di riferimento distanza inter-cerchio costante: Metodo Log-Log')
        
    case 'Nm2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,81,g)))
        
    case 'rc2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,80,g)))
        
    case 'Schoenen2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,82,g)))

    case 'ksl2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,83,g)))
        
    case 'Rsl2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,84,g)))
        
    case 'kll2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,85,g)))
        
    case 'Rll2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,86,g)))
        
    case 'Delta2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,87,g)))
        
    case 'Pextr2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,88,g)))
        
    case 'Lminextr2'
        
        ind=find(DM(:,89:108,g));
        c=DM(:,89:89+max(ind)-1,g)
        figure
        plot(1:1:length(Lmine2),c);
        title('Sistema di riferimento distanza inter-cerchio costante: Vettore delle lunghezze minime dall''estremità al centro')
        
    case 'Aextr2'
        
        ind=find(DM(:,109:128,g));
        c=DM(:,109:109+max(ind)-1,g)
        figure
        plot(1:1:length(ange2),c);
        title('Sistema di riferimento distanza inter-cerchio costante: Vettore degli angoli dall''estremità al centro')
        
    case 'Paxis2'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,129,g)))
        
    case 'Lminaxis2'
        
        ind=find(DM(:,130:149,g));
        c=DM(:,130:130+max(ind)-1,g)
        figure
        plot(1:1:length(Lmina2),c);
        title('Sistema di riferimento distanza inter-cerchio costante: Vettore delle lunghezze minime dall''estremità dell''asse principale al centro')
        
    case 'Aaxis2' 
        
        ind=find(DM(:,150:169,g));
        c=DM(:,150:150+max(ind)-1,g);
        figure
        plot(1:1:length(anga2),c);
        title('Sistema di riferimento distanza inter-cerchio costante: Vettore degli angoli dall''estremità dell''asse principale al centro')
        
    case 'Extension'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,170,g)))
        
    case 'Soma area'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,171,g)))
        
    case 'Cone angle'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,172,g)))
        
    case 'Box-counting'
        
        axes(handles.a_immagine);
        axis equal;
        axis tight;
        axis off;
        imshow(scheletro)
        [x,y] = find(scheletro==0);

        coordmat=cat(2,x,y);

        frac_dim = boxcount(coordmat, 5, 1);

        
    case 'Fractal dimension'
        
        set(handles.e_ris,'String','')
        set(handles.e_ris,'String',num2str(DM(1,173,g)))
        
end




% --- Executes during object creation, after setting all properties.
function pop_variabilig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_variabilig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_variabile_Callback(hObject, eventdata, handles)
% hObject    handle to e_variabile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_variabile as text
%        str2double(get(hObject,'String')) returns contents of e_variabile as a double


% --- Executes during object creation, after setting all properties.
function e_variabile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_variabile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_rcritico1_Callback(hObject, eventdata, handles)
% hObject    handle to e_rcritico1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rcritico1 as text
%        str2double(get(hObject,'String')) returns contents of e_rcritico1 as a double


% --- Executes during object creation, after setting all properties.
function e_rcritico1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rcritico1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_nmax1_Callback(hObject, eventdata, handles)
% hObject    handle to e_nmax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_nmax1 as text
%        str2double(get(hObject,'String')) returns contents of e_nmax1 as a double


% --- Executes during object creation, after setting all properties.
function e_nmax1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_nmax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_schoenen1_Callback(hObject, eventdata, handles)
% hObject    handle to e_schoenen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_schoenen1 as text
%        str2double(get(hObject,'String')) returns contents of e_schoenen1 as a double


% --- Executes during object creation, after setting all properties.
function e_schoenen1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_schoenen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_rcritico2_Callback(hObject, eventdata, handles)
% hObject    handle to e_rcritico2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_rcritico2 as text
%        str2double(get(hObject,'String')) returns contents of e_rcritico2 as a double


% --- Executes during object creation, after setting all properties.
function e_rcritico2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_rcritico2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_nmax2_Callback(hObject, eventdata, handles)
% hObject    handle to e_nmax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_nmax2 as text
%        str2double(get(hObject,'String')) returns contents of e_nmax2 as a double


% --- Executes during object creation, after setting all properties.
function e_nmax2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_nmax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_schoenen2_Callback(hObject, eventdata, handles)
% hObject    handle to e_schoenen2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_schoenen2 as text
%        str2double(get(hObject,'String')) returns contents of e_schoenen2 as a double


% --- Executes during object creation, after setting all properties.
function e_schoenen2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_schoenen2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_coltura_Callback(hObject, eventdata, handles)
% hObject    handle to e_coltura (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_coltura as text
%        str2double(get(hObject,'String')) returns contents of e_coltura as a double


% --- Executes during object creation, after setting all properties.
function e_coltura_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_coltura (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_cellula_Callback(hObject, eventdata, handles)
% hObject    handle to e_cellula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_cellula as text
%        str2double(get(hObject,'String')) returns contents of e_cellula as a double


% --- Executes during object creation, after setting all properties.
function e_cellula_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_cellula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in b_filmato.
function b_filmato_Callback(hObject, eventdata, handles)
% hObject    handle to b_filmato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global foto;
global nu;
global fileNames2;

for N=1:nu
    
    
    foto=imread(fileNames2{N});
    axes(handles.a_immagine);
    imshow(foto);
    axis equal;
    axis tight;
    axis off;
    
    pause(1);
    
end;



% --- Executes on button press in b_cono.
function b_cono_Callback(hObject, eventdata, handles)
% hObject    handle to b_cono (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global h;
global h1;
global N;
global angle;


api = iptgetapi(h1);
pos1=api.getPosition();
api = iptgetapi(h);
pos=api.getPosition();


% M1=(pos(2,2)-pos(1,2))/(pos(2,1)-pos(1,1))
% M2=(pos1(2,2)-pos1(1,2))/(pos1(2,1)-pos1(1,1))
% 
% a1=atand(M1)
% a2=atand(M2)
% angle=max(a1,a2)-min(a1,a2);
% 
% vect1 = [1 M1]; % create a vector based on the line equation
% vect2 = [1 M2];
% dp = dot(vect1, vect2);
% 
% % compute vector lengths
% length1 = sqrt(sum(vect1.^2));
% length2 = sqrt(sum(vect2.^2));
% 
% % obtain the larger angle of intersection in degrees
% angle = acos(dp/(length1*length2))*180/pi

l1=sqrt(((pos(2,1)-pos(1,1))^2)+(pos(2,2)-pos(1,2))^2);
l2=sqrt(((pos1(2,1)-pos1(1,1))^2)+(pos1(2,2)-pos1(1,2))^2);
l3=sqrt(((pos(2,1)-pos1(2,1))^2)+(pos(2,2)-pos1(2,2))^2);

angle=(acos(((l1^2)+(l2^2)-(l3^2))/(2*l1*l2)))*(180/pi);

% axes(handles.a_immagine);
% text(pos(1,1)-40, pos(1,2)-30, [sprintf('%1.3f',angle),'{\circ}'],...
%      'Color','r','FontSize',14,'FontWeight','bold');
 

set(handles.e_cono,'String',num2str(angle))

% DM(N,172)=angle;


% --- Executes on button press in b_retta2.
function b_retta2_Callback(hObject, eventdata, handles)
% hObject    handle to b_retta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global h;
global h1;


% axes(handles.a_immagine); 

axis equal;
axis tight;
axis off;
api = iptgetapi(h);
pos=api.getPosition()
h1 = imline(gca,[pos(1,1) 100], [pos(1,2) 100]);


pause(10)

b_cono_Callback(hObject, eventdata, handles);


% --- Executes on button press in b_box.
function b_box_Callback(hObject, eventdata, handles)
% hObject    handle to b_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global skeleton;
global N;
global gg;
global frac_dim;


axes(handles.a_immagine);
axis equal;
axis tight;
axis off;
imshow(skeleton)
title(handles.a_immagine,sprintf('Photograph number %s',num2str(gg)))


[x,y] = find(skeleton==0);

coordmat=cat(2,x,y);

path(path,'functions')

frac_dim = boxcount(coordmat, 5, 0)


set(handles.e_dimfratt,'String',frac_dim);




% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function e_dimfratt_Callback(hObject, eventdata, handles)
% hObject    handle to e_dimfratt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_dimfratt as text
%        str2double(get(hObject,'String')) returns contents of e_dimfratt as a double


% --- Executes during object creation, after setting all properties.
function e_dimfratt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_dimfratt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_inizio_Callback(hObject, eventdata, handles)
% hObject    handle to e_inizio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_inizio as text
%        str2double(get(hObject,'String')) returns contents of e_inizio as a double


% --- Executes during object creation, after setting all properties.
function e_inizio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_inizio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_fine_Callback(hObject, eventdata, handles)
% hObject    handle to e_fine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_fine as text
%        str2double(get(hObject,'String')) returns contents of e_fine as a double


% --- Executes during object creation, after setting all properties.
function e_fine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_fine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in l_df.
function l_df_Callback(hObject, eventdata, handles)
% hObject    handle to l_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns l_df contents as cell array
%        contents{get(hObject,'Value')} returns selected item from l_df


% --- Executes during object creation, after setting all properties.
function l_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_tempo_Callback(hObject, eventdata, handles)
% hObject    handle to e_tempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_tempo as text
%        str2double(get(hObject,'String')) returns contents of e_tempo as a double


% --- Executes during object creation, after setting all properties.
function e_tempo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_tempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_risultato_Callback(hObject, eventdata, handles)
% hObject    handle to e_risultato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_risultato as text
%        str2double(get(hObject,'String')) returns contents of e_risultato as a double


% --- Executes during object creation, after setting all properties.
function e_risultato_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_risultato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function e_ris_Callback(hObject, eventdata, handles)
% hObject    handle to e_ris (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_ris as text
%        str2double(get(hObject,'String')) returns contents of e_ris as a double


% --- Executes during object creation, after setting all properties.
function e_ris_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_ris (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function b_cerchi1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_cerchi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





function e_step_Callback(hObject, eventdata, handles)
% hObject    handle to e_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_step as text
%        str2double(get(hObject,'String')) returns contents of e_step as a double


% --- Executes during object creation, after setting all properties.
function e_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function file_menu_open_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pathname;

[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');

    str = strcat(pathname, filename)   %complete directory
    
    neu = imread(str);

axes(handles.a_immagine)
    imshow(neu);
    axis image
    axis off;
    
    


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function datamatrix_Callback(hObject, eventdata, handles)
% hObject    handle to datamatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pathname;
global b; 
global c;

global pathname;

[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');

    str = strcat(pathname, filename)   %complete directory
    
    neu = imread(str);

axes(handles.a_immagine)
    imshow(neu);
    axis image
    axis off;
    
[a b c gmax dmax] = strread(filename, '%s %s %s %d %d', 'delimiter', '_')

t=0;

while t==0
[pathstr, name, ext, versn] = fileparts(pathname);
pathname=pathstr;
t=isequal(name, sprintf('%s',char(b)));
end


mkdir(sprintf('%s\\Datacolture',pathname));




num_colt = (size(dir, 1) - 3);   %numero colture nella cartella neurons

if num_colt>10     %se le colture sono più di 10, devo entrare, per le prime 
                   %9 colture, nella cartella "0+numero coltura", poichè la trasformazione
                   % da numero a stringa nn lascia lo zero all'inizio. Dopo
                   % la coltura 10, invece, n nc'è bisogno di aggiungere lo
                   % 0 all'inizio del nome della cartella
    
    for i = 1:9
        data = ['0' num2str(i)]   %qui è il problema!!!
%         cd(data)
%         path(path,pathname);
pathname1=sprintf('%s\\%s',pathname,data)
        data1 = dir(sprintf('%s\\*.mat',pathname1))  %tt i datamatrix nella cartella...
        num_data = size(data1, 1)    %...e li conta
        
        if num_data>1      
           name = importdata(data1(1).name);
           DMhelp = NaN(1, 177, 23);
           DMhelp(1,:,1:str2num(data1(1).name(10:11)))=name;
           name1 = cat(1, DMhelp);
                    
            for j = 2:num_data
               name = importdata(data1(j).name);    %import dei datamatrix di ogni cellula di quella colture
               DMhelp = NaN(1, 177, 23);
               DMhelp(1, :, 1:str2num(data1(1).name(10:11)))=name;
               name1 = cat(1, name1, DMhelp);
            end;
            
        end;
        
        DMhelp = NaN(1, 177, 23);
        name = importdata(data1(1).name);    %import dei datamatrix di ogni cellula di quella colture
        DMhelp(1,:,1:str2num(data1(1).name(10:11)))=name;   %tt i datamatrix avranno, come 3 dimensione, 23, in modo da rendere più agevole 
        name1 = cat(1, DMhelp);                               %l'inserimento nel DMg
        cd('..');
    end;
    
    for i=10:num_colt
        data = num2str(i);
        cd(data)
        num_data = size(data1, 1);     %...e li conta
        
        if num_data>1      
           name = importdata(data1(1).name);
           DMhelp = NaN(1, 177, 23);
           DMhelp(1,:,1:str2num(data1(1).name(10:11)))=name;
           name1 = cat(1, DMhelp);
           
            for j = 2:num_data
               name = importdata(data1(j).name);    %import dei datamatrix di ogni cellula di quella colture
               DMhelp = NaN(1, 177, 23);
               DMhelp(1,:,1:str2num(data1(j).name(10:11)))=name;
               name1 = cat(1, name1, DMhelp);
            end;
            
        end;
        
           DMhelp = NaN(1, 177, 23);
           DMhelp(1,:,1:str2num(data1(1).name(10:11)))=name;
           name1 = cat(1, DMhelp);
           
        
        cd('..');              %per l'inserimeno in DMg, ho già i valori in corrispondenza dei giorni, quindi basta riportare i 
                                %vari datamatrix nel DMg nelle relative
                                %dimensioni
        
    end;
    
cd('Datacolture');
v = genvarname(['DM' num2str(i)]);
eval([v '=name1']);
save( ['DM' num2str(i)], ['DM' num2str(i)]);   
cd('..');

    
end;


for i = 1:num_colt
        data = ['0' num2str(i)];
        cd(data)
        data1 = dir('*.mat');
        num_data = size(data1, 1);     %...e li conta
        
        if num_data>1      
          name = importdata(data1(1).name);    %import dei datamatrix di ogni cellula di quella colture
          DMhelp = NaN(1, 177, 23);
          DMhelp(1,:,1:str2num(data1(1).name(10:11)))=name;
          name1 = cat(1, DMhelp);
               
            for j = 2:num_data
               name = importdata(data1(j).name);
               DMhelp = NaN(1, 177, 23);          %datamatrix per 23 giorni 
               DMhelp(1,:,1:str2num(data1(j).name(10:11)))=name;
               name1 = cat(1, name1, DMhelp);
            end;
            
       else
        
       name = importdata(data1(1).name);    %import dei datamatrix di ogni cellula di quella colture
       DMhelp = NaN(1, 177, 23);
       DMhelp(1,:,1:str2num(data1(1).name(10:11)))=name;
       name1 = cat(1, DMhelp);
       
       end;
       
       cd('..');
        
cd('Datacolture');
v = genvarname(['DM' num2str(i)]);
eval([v '=name1']);
save( ['DM' num2str(i)], ['DM' num2str(i)]);   
cd('..');
        
        
end;


                           %%%Costruzione automatica del datamatrix globale

[filename, pathname] = uigetfile({'*.mat'; '*.*'; 'All file'}, 'Pick datamatrix', 'Multiselect', 'on');

cd(pathname);

a=size(filename, 2); %numero di datamatrix selezionati

num_cells = ones(a, 1);

for w=1:a
    dmatrix = importdata(num2str(cell2mat(filename(w))));
    num_cells(w) = size(dmatrix, 1);
end;

num_cell_tot = sum(num_cells);

DMg = NaN(num_cell_tot, 177, 23);     %dimensioni del datamatrix globale: numero cellule, numero variabili, numero massimo di giorni di coltura

DMg(1:(num_cells(1)),:, :) = dmatrix(:,:,:);

if a>2
for w=2:a
    dmatrix = importdata(num2str(cell2mat(filename(w))));
    num_cell1 = size(dmatrix, 1);
    DMg(sum(num_cells(w-1)):(num_cells(w)),:, :) = dmatrix(:,:,:);
end;
end;

save('DMg', 'DMg');
