function varargout = NeMo(varargin)
% NEMO M-file for NeMo.fig
%      NEMO, by itself, creates a new NEMO or raises the existing
%      singleton*.
%
%      H = NEMO returns the handle to a new NEMO or the handle to
%      the existing singleton*.
%
%      NEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEMO.M with the given input arguments.
%
%      NEMO('Property','Value',...) creates a new NEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NeMo_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NeMo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NeMo

% Last Modified by GUIDE v2.5 21-Nov-2011 10:57:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NeMo_OpeningFcn, ...
                   'gui_OutputFcn',  @NeMo_OutputFcn, ...
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


% --- Executes just before NeMo is made visible.
function NeMo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NeMo (see VARARGIN)
global olddir

cd ('./Icons');
   
   imshow('neuron.jpg');
   axis equal;
   axis off;
cd ..

olddir = pwd;
% Choose default command line output for NeMo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NeMo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% path(path,'Programs\Icons')
% 
% 
% h_toolbar1 = uitoolbar ('HandleVisibility','Callback'); 
% 
%               
% hOpen1Pushtool  =  uipushtool(...   
%                   'Parent',h_toolbar1,...
%                   'TooltipString', 'Open',...
%                   'CData', iconRead('open_icon.jpg'),...
%                   'HandleVisibility', 'callback',...
%                   'ClickedCallback', @hOpen1Callback);
%               
%               
% hClose1Pushtool  =  uipushtool(...   
%                   'Parent',h_toolbar1,...
%                   'TooltipString', 'Close',...
%                   'CData', iconRead('close_icon.jpg'),...
%                   'HandleVisibility', 'callback',...
%                   'ClickedCallback', @hClose1Callback);  


% --- Outputs from this function are returned to the command line.
function varargout = NeMo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global olddir;                                                                   
olddir=pwd; %pwd indentifies current directory

%function hOpen1Callback (hObject, eventdata) 
%Callback function run when the Open menu item is selected

%global neuron;
%global pathname;
%global filename;


%[filename, pathname] = uigetfile({'*.jpg;*.tiff;*.bmp;*.png;*.gif','All Images Files'}, 'Pick an image')
           
 %   str = strcat(pathname, filename);    %complete directory
 
  % neuron = imread(str)
     
 
    
   % imshow(neuron);
   % axis image
   % axis off;
    
   
        
%function hClose1Callback(hObject, eventdata)
% Callback function run when the Close menu item is selected

 %   selection = questdlg('Are you sure?');
       
 %   if strcmp(selection,'No')
  %      return;
  %  end

   % close;      %close the current figure  

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

global neuron;
global pathname;
global filename;

[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');
           
    str = strcat(pathname, filename);    %complete directory
    
    neuron = imread(str);

    axes(handles.a_image);  
    imshow(neuron);
    axis image
    axis off;
    

% --------------------------------------------------------------------
function file_menu_quit_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    selection = questdlg('Are you sure?');
       
    if strcmp(selection,'No')
        return;
    end

    close;      %close the current figure  
    

% --------------------------------------------------------------------
function imageprocessing_menu_Callback(hObject, eventdata, handles)
% hObject    handle to imageprocessing_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function imageprocessing_automatical_Callback(hObject, eventdata, handles)
% hObject    handle to imageprocessing_automatical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global neuron;
global pathname;
global filename;
global binary;
global im_skel;
global olddir;


% path(path,'Programs\functions')

[binary, im_skel] = AutGUI (neuron, pathname, filename, olddir);    %here you have binary and skel images!!!!  


% --------------------------------------------------------------------
function imageprocessing_changing_Callback(hObject, eventdata, handles)
% hObject    handle to imageprocessing_changing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global neuron;
global pathname;
global filename;
global im_skel;
global olddir

% path(path,'Programs')

[binary, im_skel] = Image_processing (neuron, pathname, filename);

cd(olddir)

% --------------------------------------------------------------------
function count_menu_Callback(hObject, eventdata, handles)
% hObject    handle to count_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function countf_run_Callback(hObject, eventdata, handles)
% hObject    handle to countf_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global neuron;
global pathname;
global filename;
global olddir;

% addpath(path,'Programs\functions')

[numberOfNeuronsFluo] = editor_precount(neuron, pathname, filename);

cd (olddir)

% --------------------------------------------------------------------
function morph_menu_Callback(hObject, eventdata, handles)
% hObject    handle to morph_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function morph_run_Callback(hObject, eventdata, handles)
% hObject    handle to morph_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global olddir

% path(path,'Programs')

NEMO_O

cd(olddir)
% --------------------------------------------------------------------
function plot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function plot_datamatrix_Callback(hObject, eventdata, handles)
% hObject    handle to plot_datamatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% path(path,'Programs\PLOT')

Costruzione;


h = msgbox('Global datamatrix is complete!', '', 'warn');
uiwait(h);

% --------------------------------------------------------------------
%function plot_data_Callback(hObject, eventdata, handles)
% hObject    handle to plot_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% path(path,'Programs\PLOT')

%DMglobale;



% --------------------------------------------------------------------
function PCA_menu_Callback(hObject, eventdata, handles)
% hObject    handle to PCA_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PCA_run_Callback(hObject, eventdata, handles)
% hObject    handle to PCA_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% path(path,'Programs\3-way PCA')

% DM1pca;
% pause(1)
% DM2pca;
% pause(1)
DMPCA;
pause(1)
% [a, b, c, d] = tucker3(DMp);
[a, b, c, d] = main_PCA(DMp);

% % --------------------------------------------------------------------
% function help_menu_Callback(hObject, eventdata, handles)
% % hObject    handle to help_menu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)



% % --------------------------------------------------------------------
% function help_what_Callback(hObject, eventdata, handles)
% % hObject    handle to help_what (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global olddir;
% 
% msgbox('All the documentation is in .doc. If you can''t open this file, you can find all the documentation in .pdf in the Help! folder');
% uiwait
% 
%    cd (sprintf('%s\\Help!', olddir'));
%    open('Whats NeMo.doc');   
%    cd(olddir)

% % --------------------------------------------------------------------
% function help_Nemo_Callback(hObject, eventdata, handles)
% % hObject    handle to help_Nemo (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global olddir
% 
% msgbox('All the documentation is in .doc. If you can''t open this file, you can find all the documentation in .pdf in the Help! folder');
% uiwait;
% 
% cd (sprintf('%s\\Help!', olddir'));
% open('Help_NeMo.doc');
% cd(olddir)

% % --------------------------------------------------------------------
% function help_processing_Callback(hObject, eventdata, handles)
% % hObject    handle to help_processing (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global olddir
% 
% msgbox('All the documentation is in .doc. If you can''t open this file, you can find all the documentation in .pdf in the Help! folder');
% uiwait
% 
% 
% cd (sprintf('%s\\Help!', olddir'));
% open('Image processing.doc');
% cd(olddir)

% --- Executes during object creation, after setting all properties.
function a_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate a_image




% --- Executes during object creation, after setting all properties.
function a_icon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_icon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate a_icon

   imshow(fullfile('.\Programs\Icons','neuron.jpg'));
   axis equal;
   axis off;


% --------------------------------------------------------------------
function count_run_Callback(hObject, eventdata, handles)
% hObject    handle to count_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global neuron;
global pathname;
global filename;


% addpath(path,'Programs\functions')

[numberOfneurons] = editor_precount1(neuron, pathname, filename);


% --------------------------------------------------------------------
function count_plot_Callback(hObject, eventdata, handles)
% hObject    handle to count_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function count_plot_separate_Callback(hObject, eventdata, handles)
% hObject    handle to count_plot_separate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pathname2;

[filename, pathname2] = uigetfile({ '*.mat','MAT-files (*.mat)'}, 'Pick vectors', 'MultiSelect', 'on');

str = strcat(pathname2, filename);  %complete directory
nu = numel(str); 


addpath(path,pathname2); 

if iscell(filename)
    for i=1:numel(filename)
a=load(str{i});
cell=struct2cell(a);
m=cell2mat(cell);
[a b c] = strread(filename{i}, '%s %s %s', 'delimiter', '_');
[c d]= strread(char(c), '%s %s', 'delimiter', '.');
figure
plot(m,'o')
title(sprintf('Number of neurons in image %s%s during culture time',char(b),char(c)));
xlabel('Days');
ylabel('Number of neurons');
    end

else
a=load(str);
cell=struct2cell(a);
m=cell2mat(cell);
[a b c] = strread(filename, '%s %s %s', 'delimiter', '_');
[c d]= strread(char(c), '%s %s', 'delimiter', '.');
figure
plot(m,'o')
title(sprintf('Number of neurons in image %s%s during culture time',char(b),char(c)));
xlabel('Days');
ylabel('Number of neurons');

end

% --------------------------------------------------------------------
function count_plot_unique_Callback(hObject, eventdata, handles)
% hObject    handle to count_plot_unique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pathname2;

[filename, pathname2] = uigetfile({ '*.mat','MAT-files (*.mat)'}, 'Pick vectors', 'MultiSelect', 'on');

str = strcat(pathname2, filename);  %complete directory
nu=numel(str); 

addpath(path,pathname2); 

l = zeros(1,nu);
 
for i = 1:numel(filename)
[a b c d] = strread(filename{i}, '%s %s %s %s', 'delimiter', '_');
[d e] = strread(char(d), '%s %s', 'delimiter', '.');
l(i) = str2num(char(d));
end;

% l

m = NaN(nu,max(l));

if iscell(filename)
    figure
    for i=1:numel(filename)
a=load(str{i});
cell=struct2cell(a);
m(i,:)=cell2mat(cell);
[a b c d] = strread(filename{i}, '%s %s %s %s', 'delimiter', '_');
[d e]= strread(char(d), '%s %s', 'delimiter', '.');
hold on
plot(m,'-o')
title(sprintf('Number of neurons in image %s%s during culture time',char(b),char(c)));
xlabel('Days');
ylabel('Number of neurons');
    end

else
    
a=load(str);
cell=struct2cell(a);
m=cell2mat(cell);
[a b c] = strread(filename, '%s %s %s', 'delimiter', '_');
[c d]= strread(char(c), '%s %s', 'delimiter', '.');
figure
plot(m,'o')
title(sprintf('Number of neurons in image %s%s during culture time',char(b),char(c)));
xlabel('Days');
ylabel('Number of neurons');

end;

% --------------------------------------------------------------------
function count_plote_separate_Callback(hObject, eventdata, handles)
% hObject    handle to count_plot_separate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% % % % % % % --------------------------------------------------------------------
% % % % % % function prova2_Callback(hObject, eventdata, handles)
% % % % % % % hObject    handle to count_plot_unique (see GCBO)
% % % % % % % eventdata  reserved - to be defined in a future version of MATLAB
% % % % % % % handles    structure with handles and user data (see GUIDATA)
% % % % % % 
% % % % % % 
% % % % % % global neuron;
% % % % % % global pathname;
% % % % % % global filename;
% % % % % % 
% % % % % % 
% % % % % % % addpath(path,'Programs\functions')
% % % % % % 
% % % % % % [numberOfneurons]=nonNEU(neuron, pathname, filename);


% % % % % % --------------------------------------------------------------------
% % % % % function prova_Callback(hObject, eventdata, handles)
% % % % % % hObject    handle to prova (see GCBO)
% % % % % % eventdata  reserved - to be defined in a future version of MATLAB
% % % % % % handles    structure with handles and user data (see GUIDATA)
% % % % % % 
% % % % % % global neuron;
% % % % % % global pathname;
% % % % % % global filename;
% % % % % 
% % % % % 
% % % % % % addpath(path,'Programs\functions')
% % % % % 
% % % % % [numberOfneurons]=nonNEUfluo;

% --------------------------------------------------------------------
function datamatrix_Callback(hObject, eventdata, handles)
% hObject    handle to datamatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


creation;

choice;
uiwait

DMglobale;
    

% --------------------------------------------------------------------
function colt_menu_Callback(hObject, eventdata, handles)
% hObject    handle to colt_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msgbox('Work in progress!')

%%global pathname2;

%%[filename, pathname2] = uigetfile({ '*.mat','MAT-files (*.mat)'}, 'Pick vectors', 'MultiSelect', 'on');

%%str = strcat(pathname2, filename);  %complete directory
%%nu=numel(str); 

%%addpath(path,pathname2); 

% l=zeros(1,nu);
% m= NaN(nu,max(l))
% 
% if iscell(filename)
%     figure
%     for i=1:numel(filename)
% a=load(str{i});
% cell=struct2cell(a);
% m(i,:)=cell2mat(cell);
% plot(m,'-o')
% title('Number of neurons in image');
% xlabel('Days');
% ylabel('Number of neurons');
%     end
% 
% else
% a=load(str);
% cell=struct2cell(a);
% m=cell2mat(cell);
% [a b c] = strread(filename, '%s %s %s', 'delimiter', '_')
% [c d]= strread(char(c), '%s %s', 'delimiter', '.')
% figure
% plot(m,'o')
% title(sprintf('Number of neurons in image %s%s during culture time',char(b),char(c)));
% xlabel('Days');
% ylabel('Number of neurons');
% 
% end



% --------------------------------------------------------------------
%function PlotS_Callback(hObject, eventdata, handles)
% hObject    handle to PlotS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function top_menu_Callback(hObject, eventdata, handles)
% hObject    handle to top_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Prova_Callback(hObject, eventdata, handles)
% hObject    handle to Prova (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function slice_menu_Callback(hObject, eventdata, handles)
% hObject    handle to slice_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global neuron;

ToSli(neuron);

% % --------------------------------------------------------------------
% function tophelp_menu_Callback(hObject, eventdata, handles)
% % hObject    handle to tophelp_menu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global olddir
% 
%  msgbox('All the documentation is in .doc. If you can''t open this file, you can find all the documentation in .pdf in the Help! folder');
%  uiwait
% 
% cd (sprintf('%s\\Help!', olddir'));
% open('Help_TopAnalysis.doc');
% cd(olddir)


% --------------------------------------------------------------------
function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% DMglobale;
dc = questdlg ('Did you create the datamatrix?');

if dc(1) == 'N'
    
    %helpdlg ('Create the datamatrix going on Plot Variables --> Datamatrix Creation')
    creation;
    
else
    
    choice;
    uiwait
    
    DMglobale;
    
end;

choice;
uiwait

DMglobale;



% --------------------------------------------------------------------
function PlotS_Callback(hObject, eventdata, handles)
% hObject    handle to PlotS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Plot_Slice;




% --------------------------------------------------------------------
function DataCreation_Callback(hObject, eventdata, handles)
% hObject    handle to DataCreation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global olddir;

DMPCA;

cd(olddir);


% % --------------------------------------------------------------------
% function Hneuroncount_Callback(hObject, eventdata, handles)
% % hObject    handle to Hneuroncount (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global olddir
% 
%  msgbox('All the documentation is in .doc. If you can''t open this file, you can find all the documentation in .pdf in the Help! folder');
%  uiwait
% 
%  cd (sprintf('%s\\Help!', olddir'));
%  open ('Help Neuron Count.doc')
%  cd(olddir)
%  


% 
% % --------------------------------------------------------------------
% function Organize_Callback(hObject, eventdata, handles)
% % hObject    handle to Organize (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global olddir
% 
%  msgbox('All the documentation is in .doc. If you can''t open this file, you can find all the documentation in .pdf in the Help! folder');
%  uiwait
% 
%  cd (sprintf('%s\\Help!', olddir'));
%  open ('How to organize folders in NeMo.doc')
%  cd(olddir)



% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global olddir;

TopColture;

cd(olddir)
