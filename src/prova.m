[m,n]=size(im_bw);


s1=[0 0];
s2=[0 0];
d1=[0 0];
d2=[0 0];

v=0;

[r c]=find(im_bw);

        

cnew=zeros(length(c));


for i=i:length(c)
    if IX(i)==c(i)
        cnew(i)