function[x,res,iter]=mygaussseidel(A,b,x0,eps,M)
%MYGAUSSSEIDEL ��˹���¶�������
%���û���������Զ�������⾫ȷ��Ϊ1��200��ϣ�����ط�����
%input
%       AΪϵ������
%       bΪ�Ҷ��������
%       x0Ϊ��ֵ
%       epsΪ����׼
%       MΪ����������
%output
%       xΪ�⣬������
%       res����ֵ��ģ
%       iter��ʵ�ʵ�������

if nargin==0
    nnn=200;
    A=hilb(nnn); b=A*ones(nnn,1); eps=1e-8; M=200000;x0=zeros(nnn,1);
end
[n,m]=size(A); nb=length(b);
L  =zeros(n,n); U =zeros(n,n); D =zeros(n,n);
for i=2:n
for j=1:i-1
L(i,j)=-A(i,j);
end
end
for i=1:n-1
    for j=i+1:n
    U(i,j)=-A(i,j);
    end
end
for i=1:n
    D(i,i)=A(i,i);
end
B=inv(D-L)*U;        %BΪ��������
g=inv(D-L)*b;        %gΪ�Ҷ���
k=0; tol=1;
while tol>=eps 
    x = B*x0+g;
    k = k+1;         %��������
    %tol = norm(x-x0);%ǰ������������������
    tol=sqrt((A*x-b)'*(A*x-b)); %���ֲ�ͬ�������Ʒ���
    x0 = x;
    if(k>=M)
    disp('Warning: �ﵽ����������');
    break;
    end
end
