%plot Slice Variables

olddir = pwd;  %così sto in NE.MO.
mkdir(sprintf('%s\\PLOT', olddir'));
pathname1 = sprintf('%s\\PLOT', olddir');
mkdir(sprintf('%s\\P_Slice', pathname1));
pathname2 = sprintf('%s\\P_Slice', pathname1);

numberslice = str2num(cell2mat(inputdlg('How many slices do you want to analyze?', 'Slice Number')));


for num = 1 : numberslice
    
[datas, paths] = uigetfile({'*.mat','All Files'}, 'Select datamatrixes', 'MultiSelect', 'on');


cd(paths); %entro in DatamatrixSlice    
v = genvarname(datas(1 : end-4));
eval (['load(v)'])
cd .. % e sono di nuovo in NE.MO.

[m,n,z] = size(DM);
%DM=DM1;

for i = 1:m
    
    for j = 1:n
        
        for k = 1:z
            
            if DM(i,j,k) == 0
                
                DM(i,j,k) = NaN;
                
            end
            
        end
        
    end
    
end;
         
%helpdlg('Now, select what variables do you want to analyze:');


str = {'Intensity'; 'Distance'; 'Lenght Left';...
    'Lenght Right'; 'Mean width left'; 'Mean width right'; 'Max width left'; 'Max width right'; 'Min width left';  ...
    'Min width right'; 'Fit error left'; 'Fit error right'};

[var,v] = listdlg('PromptString','Select Variables:',...
                'SelectionMode','single',...
                'ListString',str);
            
            
if var == 1
    
a=zeros(1,z);

for i=1:z
    a(i)=DM(1,1,i);
end

figure
plot(1:z,a,'*')

cd(pathname2);
saveas(gcf, sprintf('Intensity%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress

elseif var == 2

a=zeros(1,z);

for i=1:z
    a(i)=DM(1,12,i);
end

figure
plot(1:z,a,'*')
cd(pathname2);
saveas(gcf, sprintf('Distance%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress

  
elseif var == 3

b=zeros(1,z);

for i=1:z
    b(i)=DM(1,2,i);
end

figure
plot(1:z,b,'*')

cd(pathname2);
saveas(gcf, sprintf('Lenght Left%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress

elseif var == 4

s=zeros(1,z);

for i=1:z
    s(i)=DM(1,7,i);
end

figure
plot(1:z,s,'*')

cd(pathname2);
saveas(gcf, sprintf('Lenght Right%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress


elseif var == 5

c=zeros(1,z);

for i=1:z
    c(i)=DM(1,3,i);
end

figure
plot(1:z,c,'*')

cd(pathname2);
saveas(gcf, sprintf('Mean width left%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress


elseif var == 6

u=zeros(1,z);

for i=1:z
    u(i)=DM(1,8,i);
end

figure
plot(1:z,u,'*')

cd(pathname2);
saveas(gcf, sprintf('Mean width right%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress

elseif var == 7

d=zeros(1,z);

for i=1:z
    d(i)=DM(1,5,i);
end

figure
plot(1:z,c,'*')

cd(pathname2);
saveas(gcf, sprintf('Max Width Left%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress

elseif var == 8

v=zeros(1,z);

for i=1:z
    v(i)=DM(1,10,i);
end

figure
plot(1:z,v,'*')

cd(pathname2);
saveas(gcf, sprintf('Max Width Right%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress


elseif var == 9

h=zeros(1,z);

for i=1:z
    h(i)=DM(1,4,i);
end

figure
plot(1:z,h,'*')

cd(pathname2);
saveas(gcf, sprintf('Min Width Left%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress



elseif var == 10

x=zeros(1,z);

for i=1:z
    x(i)=DM(1,9,i);
end

figure
plot(1:z,x,'*')

cd(pathname2);
saveas(gcf, sprintf('Min Width Right%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress


elseif var == 11

l=zeros(1,z);

for i=1:z
    l(i)=DM(1,6,i);
end

figure
plot(1:z,l,'*')

cd(pathname2);
saveas(gcf, sprintf('Fit error left%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved. You can visualize it untill  you click a mouse button');
uiwait

waitforbuttonpress


elseif var == 12

y=zeros(1,z);

for i=1:z
    y(i)=DM(1,11,i);
end

figure
plot(1:z,y,'*')

cd(pathname2);
saveas(gcf, sprintf('Fit error right%s.bmp', datas(4:(end-4))),'bmp');
cd(olddir);

h = helpdlg ('Plot is saved in PLOT\P_Slice folder. You can visualize it untill you click a mouse button');
uiwait

waitforbuttonpress


end;

end;




