function [ellisx,ellisy,rmax,xo,yo,prob]=cluster(y,n1,n2,JXi,JYi,jn,ZXi,ZYi,zn,de);

 m=mean(y);
 xo=m(1);yo=m(2);
 ss=cov(y);
 s=inv(ss);
 count=1;ellisx=[];ellisy=[];

%calcolo delle distanze fra i punti rispetto al centroide dell' ellisse
 j=sqrt(-1);
 AA=y(:,1)+j*y(:,2);
 n=size(y);
 n=n(1);
 if n==1 
  DD=0;
 else
  for i=1:n
  BB(i)=AA(i)-m(1)-j*m(2);
  DD(i)=abs(BB(i));
  end
 end 

%calcolo della distanza massima dal centroide dell' ellisse 
 if n==1
  maxima = 0;
 else
  maxima=DD(1);ii=1;
  for i=1:n
   if DD(i)>maxima
    maxima=DD(i);
    ii=i;
   end
  end
 end
 assemag=maxima;
 rmax=maxima;
 
%calcolo della 'co' corrispondente al punto più lontano
 if n==1
  co=0;
 else
  co=s(2,2)*y(ii,2)*y(ii,2)+m(2)*m(2)*s(2,2)-y(ii,1)*m(2)*s(2,1)+m(1)*m(2)*s(2,1)-y(ii,1)*m(2)*s(1,2)+m(1)*m(2)*s(1,2)+(y(ii,1)-m(1))*(y(ii,1)-m(1))*s(1,1)-(2*m(2)*s(2,2)-y(ii,1)*s(2,1)+m(1)*s(2,1)-y(ii,1)*s(1,2)+m(1)*s(1,2))*y(ii,2);
 end
 

%CALCOLO DELLA PROBABILITA' CHE UN PUNTO STIA DENTRO L'ELLISSE
 prob=chisqr(co,JXi,JYi,jn);
 if num2str(prob)==''
  prob=chisqrt(co,ZXi,ZYi,zn);
 end


%parte ok
if n==1
 ellisx=y(1);
 ellisy=y(2);
else
for y1=n1:de:n2 
 a=s(2,2);
 b=-2*m(2)*s(2,2)+y1*s(2,1)-m(1)*s(2,1)+y1*s(1,2)-m(1)*s(1,2);
 c=m(2)*m(2)*s(2,2)-y1*m(2)*s(2,1)+m(1)*m(2)*s(2,1)-y1*m(2)*s(1,2)+m(1)*m(2)*s(1,2)+(y1-m(1))*(y1-m(1))*s(1,1)-co;
 d=[a b c];
 yyy=roots(d);
 v=yyy(1);
 v=imag(v);
 if v==0
  ellisx(count)=y1;
  ellisy(count)=yyy(1);
  count=count+1;
  ellisx(count)=y1;
  ellisy(count)=yyy(2);
  count=count+1;
  end
 end
end

%calcolo delle distanze fra i punti dell' ellisse rispetto al centroide dell' ellisse
% AAA=ellisx+j*ellisy;
% nn=size(ellisx);
% if nn==1
%  DDD=0;
% else         
%  for i=1:nn
%   BBB(i)=AAA(i)-m(1)-j*m(2);
%   DDD(i)=abs(BBB(i));
%  end
% end

%calcolo della distanza minima dal centroide dell' ellisse, asse minore 
%if nn==1
% minima=0;
%else 
% minima=DDD(1);iii=1;
% for i=1:nn
%  if DDD(i)<minima
%   minima=DDD(i);
%   iii=i;
%  end
% end
%end
%assemin=minima;
%Area_cluster=pi*assemin*assemag
%if n==1
% Centro_del_cluster=y
%else
% Centro_del_cluster=m
%end
