% program tucker3 performs a 3-way PCA of a 3-dimensional matrix
% Input matrix x must be a "double" unfolded matrix.
% With n objects, v variables and c conditions it is a n*c,v matrix:
% Conditions can be different observations, different years, different
% replicates, different operators, ...
% The order of the rows has to be the following:
% obj. 1, cond. 1
% obj. 2, cond. 1
% ...............
% obj. n, cond. 1
% obj. 2, cond. 2
% ...............
% obj. n, cond. c
%
% It works with 2 components for each dimension
%
function [lo,lv,lc,g] = main_PCA(x)
format compact
clc
xo=[];xv=[];xc=[];
a=str2num(cell2mat(inputdlg('j-scaling? (1=yes, 0=no) ')));
if a==1
  x=autosc(x);
end
% j-scaling
[oc,v]=size(x);
c=str2num(cell2mat(inputdlg ('How many conditions? ')));
maxci=str2num(cell2mat(inputdlg('Maximum number of iterations? [20] ')));
if isempty(maxci);
  maxci=20;
end;
o=oc/c;
for p=1:c
  xo=[xo x((p-1)*o+1:p*o,:)];
end
for p=1:c
  xv=[xv xo(:,(p-1)*v+1:p*v)'];
end
for r=1:c
  t=[];
  for p=1:o
    t=[t xv(:,(r-1)*o+p)'];
  end
  xc=[xc; t];
end
save xo xo
save xv xv
save xc xc
clear xv xc
varin=sum(sum(x.^2));
disp(' ')
disp(['Initial variance ' num2str(varin)])
disp(' ')
%start computing starting loadings for ALS
[lo,s]=autovettori(xo');
% the "objects" in the score plot have the following numbering:
% var. 1, cond. 1
% var. 2, cond. 1
% ...............
% var. v, cond. 1
% var. 1, cond. 2
% ...............
% var. v, cond. c
save lo lo
clear s xo lo
load xv
[lv,s]=autovettori(xv');
% the "objects" in the score plot have the following numbering:
% obj. 1, cond. 1
% obj. 2, cond. 1
% ...............
% obj. n, cond. 1
% obj. 1, cond. 2
% ...............
% obj. v, cond. c
save lv lv
clear lv xv s
load xc
[lc,s]=autovettori(xc');
% the "objects" in the score plot have the following numbering:
% var. 1, obj. 1
% var. 2, obj. 1
% ...............
% var. v, obj. 1
% var. 1, obj. 2
% ...............
% var. v, obj. n
clear s xc
load lv
load lo
% end computing starting loadings for ALS
% ALS
g2=zeros(2,4);
d=10000;
ci=0;
dp=[];
fip=[];
perc=[];
while d>0.001 & ci<maxci+1
  if ci>0
    load xo
    m=xo*kron(lc'*lc,lv'*lv)*xo';
    lo=(m*lo'*(lo*m^2*lo')^(-0.5))';
    clear xo
    load xv
    m=xv*kron(lc'*lc,lo'*lo)*xv';
    lv=(m*lv'*(lv*m^2*lv')^(-0.5))';
    clear xv
    load xc
    m=xc*kron(lo'*lo,lv'*lv)*xc';
    lc=(m*lc'*(lc*m^2*lc')^(-0.5))';
    clear xc
    % end of ALS
  end
  load xo
  g=lo*xo*kron(lc',lv');
  [a,b]=max(max(abs(g')));
  if b==2
    lo2=lo;
    lo2(1,:)=lo(2,:);
    lo2(2,:)=lo(1,:);
    lo=lo2;
    clear lo2
    g=lo*xo*kron(lc',lv');
  end
  [a,b]=max(max(abs(g)));
  if b==2 | b==4
    lc2=lc;
    lc2(1,:)=lc(2,:);
    lc2(2,:)=lc(1,:);
    lc=lc2;
    clear lc2
    g=lo*xo*kron(lc',lv');
  end
  if b>2
    lv2=lv;
    lv2(1,:)=lv(2,:);
    lv2(2,:)=lv(1,:);
    lv=lv2;
    clear lv2
  end
  load xo
  ci
  g=lo*xo*kron(lc',lv')
  sscore=sum(sum(g.^2));
  percvarexp=sscore/varin*100;
  disp(['% expl. var.: ' num2str(percvarexp)])
  perc=[perc percvarexp];
  if ci>0
    d=perc(ci+1)-perc(ci);
  end
  ci=ci+1;
end

figure
vx=0:length(perc)-1;
plot(vx,perc)
title(['Evolution of the explained variance' ]);
figure(gcf)

fi=(g(1,1)^2+g(2,4)^2)/sum(sum(g.^2))
fin=0;
fimax=fi;
while fimax>fin
  disp(' ')
  fin=fimax;
  % rotation of the objects
  disp('Rotation of objects')
  rotb=0;
  for rot=-90:90  
      rm=[cos(rot*pi/180) -sin(rot*pi/180);sin(rot*pi/180) cos(rot*pi/180)];
      lo2=rm*lo;
      g2=lo2*xo*kron(lc',lv');
      fi2=(g2(1,1)^2+g2(2,4)^2)/sum(sum(g2.^2));
      if fi2>fimax
        lob=lo2;
        fimax=fi2;
        rotb=rot;
      end
  end
  if rotb~=0
    rotb
    fimax
    lo=lob;
  end
  % rotation of the variables
  disp('Rotation of variables')
  rotb=0;
  for rot=-90:90  
      rm=[cos(rot*pi/180) -sin(rot*pi/180);sin(rot*pi/180) cos(rot*pi/180)];
      lv2=rm*lv;
      g2=lo*xo*kron(lc',lv2');
      fi2=(g2(1,1)^2+g2(2,4)^2)/sum(sum(g2.^2));
      if fi2>fimax
        lvb=lv2;
        fimax=fi2;
        rotb=rot;
      end
  end
  if rotb~=0
    rotb
    fimax
    lv=lvb;
  end
  % rotation of the conditions
  disp('Rotation of conditions')
  rotb=0;
  for rot=-90:90
      rm=[cos(rot*pi/180) -sin(rot*pi/180);sin(rot*pi/180) cos(rot*pi/180)];
      lc2=rm*lc;
      g2=lo*xo*kron(lc2',lv');
      fi2=(g2(1,1)^2+g2(2,4)^2)/sum(sum(g2.^2));
      if fi2>fimax
        lcb=lc2;
        fimax=fi2;
        rotb=rot;
      end
  end
  if rotb~=0
    rotb
    fimax
    lc=lcb;
  end
end
% **********************************************************
[nc,k]=size(lo);
for z=1:nc
  m=mean(lo(z,:));
  clear t
  t=0;
  for i=1:v
    l=0;
    for w=1:o
      l=l+mean(x(w:o:oc,i))*(lo(z,w)-m);
    end
    t=t+l*lv(z,i);
  end 
  if t<0 
    lo(z,:)=-lo(z,:);
  end
  m=mean(lc(z,:));
  t=0;
  for i=1:v
    l=0;
    for w=1:c
      l=l+mean(x((w-1)*o+1:w*o,i))*(lc(z,w)-m);
    end
    t=t+l*lv(z,i);
  end  
  if t<0
    lc(z,:)=-lc(z,:);
  end
end
g=lo*xo*kron(lc',lv');

[a,b]=max(max(abs(g')));
if b==2
  lo2=lo;
  lo2(1,:)=lo(2,:);
  lo2(2,:)=lo(1,:);
  lo=lo2;
  clear lo2
  g=lo*xo*kron(lc',lv');
end
[a,b]=max(max(abs(g)));
if b==2 | b==4
  lc2=lc;
  lc2(1,:)=lc(2,:);
  lc2(2,:)=lc(1,:);
  lc=lc2;
  clear lc2
end
if b>2
  lv2=lv;
  lv2(1,:)=lv(2,:);
  lv2(2,:)=lv(1,:);
  lv=lv2;
  clear lv2
end
% ***********************************************
k=1;
twocomponents(lo',k);
title(['Plot of objects' ]);
figure(gcf)
k=2;
twocomponents(lv',k);
title(['Plot of variables' ]);
figure(gcf)
k=3;
twocomponents(lc',k);
title(['Plot of conditions' ]);
figure(gcf)
g=lo*xo*kron(lc',lv')
figure
hold on
k=1;
plot_PCA(lo',k);
k=2;
plot_PCA(lv',k);
k=3;
plot_PCA(lc',k);
xt=[lo';lv';lc'];
set(gca,'XLim',[(min(xt(:,1))-(0.05*(max(xt(:,1))-min(xt(:,1))))) (max(xt(:,1))+(0.05*(max(xt(:,1))-min(xt(:,1)))))]);
set(gca,'YLim',[(min(xt(:,2))-(0.05*(max(xt(:,2))-min(xt(:,2))))) (max(xt(:,2))+(0.05*(max(xt(:,2))-min(xt(:,2)))))]);
plot(0,0,'+')
axis('equal')
title(['Plot_PCA(red=objects, green=variables, blue=conditions)' ]);
set(gca,'xlabel',text(0,0,['Axis 1' ]));
set(gca,'ylabel',text(0,0,['Axis 2' ]));
figure(gcf)
hold off

rm=zeros(o*c,v);
for i=1:o
  for j=1:v
    for k=1:c
      rv=lo(1,i)*lv(1,j)*lc(1,k)*g(1,1);
      rv=rv+lo(1,i)*lv(2,j)*lc(1,k)*g(1,2);
      rv=rv+lo(1,i)*lv(1,j)*lc(2,k)*g(1,3);
      rv=rv+lo(1,i)*lv(2,j)*lc(2,k)*g(1,4);
      rv=rv+lo(2,i)*lv(1,j)*lc(1,k)*g(2,1);
      rv=rv+lo(2,i)*lv(2,j)*lc(1,k)*g(2,2);
      rv=rv+lo(2,i)*lv(1,j)*lc(2,k)*g(2,3);
      rv=rv+lo(2,i)*lv(2,j)*lc(2,k)*g(2,4);
      rm(o*(k-1)+i,j)=rv;
    end
  end
end
d=(rm-x).^2;
rv=zeros(v);
ro=zeros(o);
rc=zeros(c);
rv=sum(d);
rv=rv./(o*c);
roc=sum(d');
for i=1:o
  ro(i)=sum(roc(i:o:o*c));
end
ro=ro./(v*c);
for i=1:c
  rc(i)=sum(roc((i-1)*o+1:i*o));
end
rc=rc./(o*v);
figure
bar(ro)
title(['RMSE of objects'])
figure(gcf)
figure
bar(rv)
title(['RMSE of variables'])
figure(gcf)
figure
bar(rc)
title(['RMSE of conditions'])
figure(gcf)
