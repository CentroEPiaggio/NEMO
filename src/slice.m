A1=rgb2gray(A);


I_filter = im2double (A);

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

im_adjust = image_gray;
level = graythresh (im_adjust);
im_bw = im2bw (im_adjust, level);

[y,x]=find(im_bw==1);
[y1,i]=sort(y);

[l,p]=size(i);

x1=zeros(l,1);
for k=1:l
    x1(k)=x(i(k));
    
end



  [m,n]= size(im_bw);
% % med=n/2;
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
% 
% % imshow(im_bw)
% % hold on
% % plot(med,1:m)
% 
% a= zeros(1,m);
 x2=zeros(m,n);

%         
% 
[f,g]=size(x2);

for i=1:f
    for j=1:g
            if x2(i,j)==0
                x2(i,j)=NaN;
            end
      
    end
end
%     
% for k=1:m
%         i=1;
%         N=isnan(x2(k,:));
%         M=find(N,1,'first');
%         if M==1
%             a(k)=NaN;
%         else
%         d =x2(k,i+1)-x2(k,i);
%         e=x2(k,i+2)-x2(k,i+1);
%         while d<250 && e<250 && i<M
%              d =x2(k,i+1)-x2(k,i);
%             e=x2(k,i+2)-x2(k,i+1);
%             i=i+1;
%         end
% %         if i==M-1 || i==M
% %             if (n-x2(i))>x2(i)
% %         a(k)=x2(k,1)-1;
% %             else a(k)=x2(k,M-1);
% %             end
% %         else
% %             a(k)=x2(k,1)+((x2(k,i+1)-x2(k,i))/2);
% %         end
%         end
% end
% 
% 
% ay=x(1);
% ax=y(1);
% by=x1(1);
% bx=y1(1);
% 
% mm=(by-ay)/(bx-ax);
% 
% q=(bx*ay-ax*by)/(bx-ax);
% 
% xx=1:m;
% 
% imshow(im_bw)
% hold on
% yy=mm*xx+q;
% plot( yy,xx, 'r')
% 
% yy1=floor(yy);
% for i=1:length(yy1)
% if yy1(i)==0
%             yy1(i)=1;
% end
% end
%     for i=1:m
%           ind=find(im_bw(yy1(i),xx(i))>0);
%     end      
% 
% while ind>0
%     for i=1:m
%           ind=find(im_bw(yy1(i),xx(i))>0);
%     end
%        q=q+1;
%         yy=mm*xx+q;
%         yy1=floor(yy);
%         if yy1==0
%             yy1=1;
%         end
%  end







[a,b,v]=impixel(im_bw);
mm=(a(2)-a(1))/(b(2)-b(1));
q=(b(2)*a(1)-b(1)*a(2))/(b(2)-b(1));
xx=1:m;
yy=mm*xx+q;

 imshow(im_bw)
hold on
yy=mm*xx+q;
plot( yy,xx, 'g')        
    


  [m,n]= size(im_bw);


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
        k
        j=j+1;
        j
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
min1=min(seg1);
min2=min(seg2);
av1=mean(seg1);
av2=mean(seg2);

mean1=zeros(l1,2);
m1=zeros(l2,1);
for i=1:l1
m(i)=(s1(i,2)-s1(i,1))/2;
mean1(i,2)=s1(i,1)+m(i);
mean1(i,1)=s1(i,3);
end

mean2=zeros(l2,2);
m2=zeros(l2,1);
for i=1:l2
m1(i)=(s2(i,2)-s2(i,1))/2;
mean2(i,2)=s2(i,1)+m1(i);
mean2(i,1)=s2(i,3);
end

imshow(im_bw)

hold on
[p,ErrorEst]=polyfit(mean1(:,2),mean1(:,1),1);
                    pop_fit=polyval(p,mean1(:,2),ErrorEst);
                    [pop_fit,delta] = polyval(p,mean1(:,2),ErrorEst);
                    % Plot dei dati, del fit e degli intervalli di
                    % confidenza
                    plot(mean1(:,2),mean1(:,1),'+',mean1(:,2),pop_fit,'g-',mean1(:,2),pop_fit+2*delta,'r:',mean1(:,2),pop_fit-2*delta,'r:')
                    
hold on
                    
[p,ErrorEst]=polyfit(mean2(:,2),mean2(:,1),1);
pop_fit=polyval(p,mean2(:,2),ErrorEst);
[pop_fit,delta] = polyval(p,mean2(:,2),ErrorEst);
% Plot dei dati, del fit e degli intervalli di confidenza
plot(mean2(:,2),mean2(:,1),'+',mean2(:,2),pop_fit,'g-',mean2(:,2),pop_fit+2*delta,'r:',mean2(:,2),pop_fit-2*delta,'r:')

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