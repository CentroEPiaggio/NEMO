%
%         ANALISI A COMPONENTI PRINCIPALI      
%
% Ingressi alla funzione:
%     x       : matrice dei dati, sulle righe vanno gli individui e sulle colonne le variabili
%     prob    : probabilità con cui viene tracciato il cluster, se 0
%     traccia il cluster corrispondente al punto più lontano (esclude qll + lontani secondo 1 certa probabilita???)
%     nn      : numero di gruppi di individui
%     cl      : se è uguale ad 1 traccia i cluster, se è 0 o qualsiasi altro valore non li traccia 
%     de      : densità dei punti con cui vengono tracciati i cluster [0.01-1] (0.5 è il valore che ottimizza velocità e visibilità dei cluster) 
%     m1..m30 : numero di righe per ogni individuo  
%
% 
%
% Uscite della funzione:
%     mx      : vettore valori medi di x
%     S       : matrice di covarianza di x 
%     R       : matrice di correlazione dei dati (p*p)
%     l       : matrice autovalori di R
%     a       : matrice autovettori di R
%     C       : cerchio di correlazione
%     y       : componenti principali(n*p)
%
%
%
% Comando     : [mx,S,R,l,a,y,Y1_Y2]=pca(x,prob,nn,cl,de,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30);
% Esempio     : [mx,S,R,l,a,y,Y1_Y2]=pca(x,.9,3,1,0.5,9,9,9);
%
%


function [mx,S,R,l,a,C,y,Y1_Y2,ellix,elliy]=pca_ll(x,prob,nn,cl,de,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30);

[m,n]=size(x)   %dim matrice in

ellix = cell(1,nn);
elliy = cell(1,nn); %cluster forma d ellissoidi nn e' detto ass perp

g=std(x);              %%%%%%%%%% standardizzazione delle variabili
g=inv(diag(g));  %calcolo matrice diag e faccio inv per dividere dati in per varianza
x=x*g; %divido dati per varianza

mx=mean(x);  %valor medio dati
S=cov(x);  %nn vien usata oerche' uso dati stabndardizzati qbd estraggo autoalori dalla matrice di correlazione
R=corrcoef(x); 
[a,l]=eig(R) % autovettori (a) e autovalori (l)
for i=1:n-1;       % ordinamento    1colonna penultima colonn ???
	kk=i;          
	w=l(i,i);
	for j=i+1:n;    %j [ un passo avanti rispetto a i, quindi permette il confronto tra autovalori consecutivi
		if l(j,j)>w      % SE TROVA CHE UN VALORE E' MAGGIORE  dell'altro li scambia
		kk=j;
		w=l(j,j);
		end;
	end;
	if kk~=i       
	l(kk,kk)=l(i,i);
	l(i,i)=w;
		for j=1:n;
		w=a(j,i);
		a(j,i)=a(j,kk);
		a(j,kk)=w;
		end
	end
end
y=[]; %matrice comp princ
k=[]; % matrice medie 
for i=1:m;
k=[k;mx];  
end
y=(x-k)*a


%%%%%%%%%%%%cerchio delle correlazioni
r1=[];
zq=[];
for i=1:n
 for j=1:n
% zq=cov(y(:,j),x(:,i));
% r1(i,j)=zq(1,2)/(std(x(:,i))*std(y(:,j)));  %%%%% sono equivalenti

  r1(i,j)=a(i,j)*sqrt(l(j,j))/(std(x(:,i))) %%%%%     FORMULA DEI COEEF DI CORRELAZIONE

% zq=corrcoef(y(:,j),x(:,i));                 %%%%% 
% r1(i,j)=zq(1,2);                           

 end
end
r1

C = [];
figure    %% cerchio correlazioni e plotto i vari coeff
hold on
xlabel('Y1');
ylabel('Y2');
for i=1:n;
 plot(r1(i,1),r1(i,2),'r*');             % N.B. 1 e 3 sovrapposti
 C = [C;r1(i,1),r1(i,2)];
 text(r1(i,1)+.05,r1(i,2),num2str(i));  %scrive nome della variabile spostato di 0.5
end
hold on
[xx,yy,zz] = cylinder(1,200);   %qst e' cerchio
plot(xx(1,:),yy(1,:))
axis equal
ww=[0 0]; qq=[-1 1];  %visualizzo assi grafico
line(ww,qq);
ww=[-1 1]; qq=[0 0];
line(ww,qq);
title('               Circle of Correlations                 ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure 
hold on
xlabel('Y1');
per=num2str(((l(1,1)+l(2,2))/n)*100);
ylabel('Y2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=[];  % fa classificazione cioe num elementi classificati cm calsse n
if nn>=1 f(1)=m1; end;        % mette in f il numero di elementi per ciascuna classe
if nn>=2 f(2)=m2; end;
if nn>=3 f(3)=m3; end;
if nn>=4 f(4)=m4; end;
if nn>=5 f(5)=m5; end;
if nn>=6 f(6)=m6; end;
if nn>=7 f(7)=m7; end;
if nn>=8 f(8)=m8; end;
if nn>=9 f(9)=m9; end;
if nn>=10 f(10)=m10; end;
if nn>=11 f(11)=m11; end;
if nn>=12 f(12)=m12; end;
if nn>=13 f(13)=m13; end;
if nn>=14 f(14)=m14; end;
if nn>=15 f(15)=m15; end;
if nn>=16 f(16)=m16; end;
if nn>=17 f(17)=m17; end;
if nn>=18 f(18)=m18; end;
if nn>=19 f(19)=m19; end;
if nn>=20 f(20)=m20; end;
if nn>=21 f(21)=m21; end;
if nn>=22 f(22)=m22; end;
if nn>=23 f(23)=m23; end;
if nn>=24 f(24)=m24; end;
if nn>=25 f(25)=m25; end;
if nn>=26 f(26)=m26; end;
if nn>=27 f(27)=m27; end;
if nn>=28 f(28)=m28; end;
if nn>=29 f(29)=m29; end;
if nn>=30 f(30)=m30; end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

str1=str2mat('g*','r*','b*','m*','c*','y*','g+','r+','b+','m+');  %matrici cn caratteri e colori del plot dati
str2=str2mat('c+','y+','go','ro','bo','mo','co','yo','gx','rx');
str3=str2mat('bx','mx','cx','yx','g-','r-','b-','m-','c-','y-');


%%%%%%%%Punti dei cluster   RIGUARDA BENE IL CODICE
w=0;
v=1;
u=1;
str=str1;
for j=1:nn;
 q=f(j);
 for i=1:q;
  plot(y(i+w,1),y(i+w,2),str(u,:));
 end
 v=v+1;
 u=u+1;
 if v==11 str=str2; u=1; end;
 if v==21 str=str3; u=1; end;
 w=w+f(j);
end

%%%%%%%%%%%%Calcola i limiti degli assi

ff=axis;      % restituisce un vettore riga contenente i limiti degli assi
t1=ff(1);
t2=ff(2);
t3=ff(3);
t4=ff(4);


%%%%%%%%%%%%%Stampa i numeri accanto all' asterisco del punto della pca

w=0;
for j=1:nn;
 q=f(j);
 for i=1:q;
  text(y(i+w,1)+(t2-t1)/30,y(i+w,2),num2str(i));
 end
 w=w+f(j);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if cl==1                                                          % se voglio tracciare i cluster conrolla qndi cl
 str1=str2mat('g.','r.','b.','m.','c.','y.','g.','r.','b.','m.');  % ogni cluster ha colore classe corrispondente
 str2=str2mat('c.','y.','g.','r.','b.','m.','c.','y.','g.','r.');
 str3=str2mat('b.','m.','c.','y.','g.','r.','b.','m.','c.','y.');

%%%%%%%%%%%%Traccia i cluster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 IX=[0.001 0.01 0.05 0.1 0.2 0.3 0.5 0.7 0.8 0.9 0.95 0.99];
 IY=[13.815 9.210 5.991 4.605 3.219 2.408 1.386 0.713 0.446 0.211 0.103 0.020];
 IXi=[0.01:.01:0.99];
 IYi=interp1(IX,IY,IXi);
 in=size(IXi);
 in=in(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if prob==0                % controllo su prob, per vedere se devop prendere anke valori molto lontani,
                            % anche se nn ha molto senso xke' e' probabile siano outliner
  
  JXi=[13.81:-.01:0.02];
  JYi=interp1(IY,IX,JXi);
  jn=size(JXi);
  jn=jn(2);
  ZXi=[13.815:-.001:0.020];
  ZYi=interp1(IY,IX,ZXi);
  zn=size(ZXi);
  zn=zn(2);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 eu=[];
 w=0;
 v=1;
 u=1;
 str=str1;
 for j=1:nn
  q=f(j);
  yy=y(1+w:w+q,1:2);
  if prob==0
   [ellisx,ellisy,rmax,xo,yo,pro]=cluster(yy,t1,t2,JXi,JYi,jn,ZXi,ZYi,zn,de);
  else
   [ellisx,ellisy,rmax,xo,yo]=clust(yy,t1,t2,prob,IXi,IYi,in,de);
   pro=prob;
  end

  ellix{j} = ellisx;
  elliy{j} = ellisy;
  
  plot(ellisx,ellisy,str(u,:));  %traccia i punti dell' ellisse   PUNTI ESTERNI SCARTATI intersezione cluster zona di interclassificazione??? posso scegliere prob minore, qndi cluster + piccoli
  cc=[xo yo];                    %(xo,yo) é il centro del cluster
  eu(j,1)=xo;
  eu(j,2)=yo;
  ww=num2str(pro);
  text(xo-rmax,yo-rmax,ww);      %punto in cui scrive la probabilità
  v=v+1;
  u=u+1;
  if v==11 str=str2; u=1; end;
  if v==21 str=str3; u=1; end;
  w=w+f(j);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distcm=[];          %calcolo delle distanze fra i centri delle ellissi
for j=1:nn
 for i=1:nn
  distcm(j,i)=0;
 end
end
for j=1:(nn-1)
 for i=(j+1):nn
  distcm(j,i)=sqrt((eu(i,1)-eu(j,1))^2+(eu(i,2)-eu(j,2))^2);
  distcm(i,j)=distcm(j,i); 
 end;
end
distcm;
%%save C:\Users\Lucia\Documents\MODELLI\Matlab-files\PCA\distcm.txt distcm -ascii -tabs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distpu=[];          %calcolo delle distanze fra i punti piu sn distanti + punti separabili tra loro
for j=1:m            % distanze picole grande correlazione tra dati quindi migliori
 for i=1:m
  distpu(j,i)=0;
 end
end
for j=1:(m-1)
 for i=(j+1):m
  distpu(j,i)=sqrt((y(i,1)-y(j,1))^2+(y(i,2)-y(j,2))^2);
  distpu(i,j)=distpu(j,i);
 end;
end
distpu;
%%% save C:\Users\Lucia\Documents\MODELLI\Matlab-files\PCA\distpu.txt distpu -ascii -tabs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%Calcolo dei limiti dei nuovi assi per la funz. discriminante

%ff=axis;
%t1=ff(1);
%t2=ff(2);
%t3=ff(3);
%t4=ff(4);
%axis(axis);

%%%%%%%%%%%%%%%Calcolo e tracciamento della funzione discriminante

%[x1,x2,x3,tt3,x4,tt4,x5,tt5]=discr(aaa,bbb,ccc,cc1,cc2,cc3,t3,t4);
%XXX=[];YYY=[];% (x1,x2) punto in cui si annullano le funzioni discriminanti
%XXX(1)=x1;YYY(1)=x2;
%XXX(2)=x3;YYY(2)=tt3;
%line(XXX,YYY);
%XXX(2)=x4;YYY(2)=tt4;
%line(XXX,YYY);
%XXX(2)=x5;YYY(2)=tt5;
%line(XXX,YYY);

%%%%%%%%%%%%%%%Discrimina l' eventuale misura incognita


%if l==1
% v1=y(1+m1+m2+m3,1);      
% v2=y(1+m1+m2+m3,2);
% [h12,h13,h23]=discr1(aaa,bbb,ccc,v1,v2);
% if (h12>0)&(h13>0)
%  [pro]=clu(aaa,v1,v2);
%  text(t1+(t2-t1)/2+3,t3-3,' ESANOLO con probab. :');
%  text(t1+(t2-t1)/2+28,t3-3,num2str(pro)); 
% end
% if (h12<0)&(h23>0)
%  [pro]=clu(bbb,v1,v2);
%  text(t1+(t2-t1)/2+3,t3-3,' ESANALE con probab. :');
%  text(t1+(t2-t1)/2+28,t3-3,num2str(pro));
% end
% if (h13<0)&(h23<0)
%  [pro]=clu(ccc,v1,v2);
%  text(t1+(t2-t1)/2+3,t3-3,' NONANALE con probab. :' );
%  text(t1+(t2-t1)/2+29,t3-3,num2str(pro));
% end
%end


%%%%%%%%%%%%%%%Scrive la quantità di informazione ottenuta

%tt=axis;
%text(tt(1)+2.5,tt(3)-2.5,per);

%%%%%%%%%%%%%%%

Y1_Y2 = y(:,1:2);
title('            PRINCIPAL COMPONENT ANALYSIS               ')





