%plot of the 2 components of the 3-way PCA
function vartuck(x,k)
figure
color=['r' 'g' 'b'];
[o,v]=size(x);
h=plot(x(:,1),x(:,2),'.');
set(h,'color',color(k))
set(gca,'XLim',[(min(x(:,1))-(0.05*(max(x(:,1))-min(x(:,1))))) (max(x(:,1))+(0.05*(max(x(:,1))-min(x(:,1)))))]);
set(gca,'YLim',[(min(x(:,2))-(0.05*(max(x(:,2))-min(x(:,2))))) (max(x(:,2))+(0.05*(max(x(:,2))-min(x(:,2)))))]);
for a=1:o
  h=text(x(a,1),x(a,2),int2str(a));
  set(h,'color',color(k))
end
set(gca,'xlabel',text(0,0,['Axis 1' ]));
set(gca,'ylabel',text(0,0,['Axis 2' ]));
hold on
plot(0,0,'+')
axis('equal')
