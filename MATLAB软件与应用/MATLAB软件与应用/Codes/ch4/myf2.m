function [x,y] = myf2(a,b,c)
fprintf('nargin=%d\n',nargin);
fprintf('nargout=%d\n',nargout);
if nargin==0 x=0;end
if nargin==1 x=a;y=99;end
if nargin==2 x=a+b;end
if nargin==3 x=a+b+c;end

%����myf2
%[x]=myf2() %0����д()
%[x,y]=myf2() %���ô���
%[x]=myf2(2,3,4) %9
%[x,y]=myf2(2) %2,99
