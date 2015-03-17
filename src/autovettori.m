 % NIPALS
function [lmat,smat]=autovettori(x);

[r,c]=size(x);
xt=x;
t=0;   %era0
vp=[];
vartot=sum(sum(x.^2));
while t<2
  t=t+1;
  ss=sum(xt.^2);
  [a,b]=sort(ss);
  xmax=xt(:,b(c));
  s=xmax'*xmax;
  diff=1000;
  while diff>0.0000001
    rmax=xmax'*xt/s;
    rmaxsq=rmax*rmax';
    rmax=rmax/sqrt(rmaxsq);
    xmax=xt*rmax';
    s2=xmax'*xmax;
    diff=abs(s2-s);
    s=s2;
  end
  smat(:,t)=xmax;
  lmat(t,:)=rmax;
  varexp(t)=xmax'*xmax;
  vp(t)=varexp(t)/vartot*100;
  xt=xt-xmax*rmax;
end;
disp(vp)
disp(cumsum(vp))
disp(' ')
[a,b]=size(smat);
if b>1;
    v1=1;
    v2=2;
    figure
    plot(smat(:,v1),smat(:,v2),'.')
    %set(gca,'XLim',[(min(smat(:,v1))-(0.05*(max(smat(:,v1))-min(smat(:,v1))))) (max(smat(:,v1))+(0.05*(max(smat(:,v1))-min(smat(:,v1)))))]);
    %set(gca,'YLim',[(min(smat(:,v2))-(0.05*(max(smat(:,v2))-min(smat(:,v2))))) (max(smat(:,v2))+(0.05*(max(smat(:,v2))-min(smat(:,v2)))))]);
    %set(gca,'xlabel',text(0,0,['Eigenvector ' int2str(v1) ' (' int2str(vp(:,v1)) '% of variance)' ]));
    %set(gca,'ylabel',text(0,0,['Eigenvector ' int2str(v2) ' (' int2str(vp(:,v2)) '% of variance)' ]));
    tot=[vp(:,v1) vp(:,v2)];
    totcum=cumsum(tot);
    title(['Object scores on eigenvectors ' int2str(v1) '-' int2str(v2) ' (' int2str(totcum(1,2)) '% of total variance)']); 
    for a=1:r;
      text(smat(a,v1),smat(a,v2),int2str(a))
    end
    axis('equal')
    figure
    plot(lmat(v1,:),lmat(v2,:),'.')
    limax=[max(abs(lmat(v1,:))) max(abs(lmat(v2,:)))];
    limite=max(limax);
    %set(gca,'XLim',[(-limite-(0.1*limite)) (limite+(0.1*limite))]);
    %set(gca,'YLim',[(-limite-(0.1*limite)) (limite+(0.1*limite))]);
    %set(gca,'xlabel',text(0,0,['Eigenvector ' int2str(v1) ' (' int2str(vp(:,v1)) '% of variance)' ]));
    %set(gca,'ylabel',text(0,0,['Eigenvector ' int2str(v2) ' (' int2str(vp(:,v2)) '% of variance)' ]));
    title(['Variable loadings on eigenvectors ' int2str(v1) '-' int2str(v2) ' (' int2str(totcum(1,2)) '% of total variance)' ]);
    hold on
    plot(0,0,'+')
    for a=1:c;
     text(lmat(v1,a),lmat(v2,a),int2str(a))
    end
    axis('equal')
    hold off
end;