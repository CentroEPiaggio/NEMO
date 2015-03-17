function [z]=chisq(prob,IXi,IYi,in);  % vede prob di ingr data per tracciare i cluster

prob=1-prob;
prob=prob*100;
prob=fix(prob);
prob=prob/100;

%X=[0.001 0.01 0.05 0.1 0.2 0.3 0.5 0.7 0.8 0.9 0.95 0.99];
%Y=[13.815 9.210 5.991 4.605 3.219 2.408 1.386 0.713 0.446 0.211 0.103 0.020];
%Xi=[0.01:.01:0.99];
%Yi=interp1(X,Y,Xi);
%n=size(Xi);
%n=n(2);

for i=1:in
 if IXi(i)==prob
  z=IYi(i);
 end 
end
