function[x,res,iter]=mygaussseidel(A,b,x0,eps,M)
%MYGAUSSSEIDEL 高斯赛德尔迭代法
%如果没有输入则自动设置求解精确解为1的200阶希尔伯特方程组
%input
%       A为系数矩阵
%       b为右端项，列向量
%       x0为初值
%       eps为误差标准
%       M为最大迭代次数
%output
%       x为解，列向量
%       res，残值的模
%       iter，实际迭代次数

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
B=inv(D-L)*U;        %B为迭代矩阵
g=inv(D-L)*b;        %g为右端项
k=0; tol=1;
while tol>=eps 
    x = B*x0+g;
    k = k+1;         %迭代步数
    %tol = norm(x-x0);%前后两步迭代结果的误差
    tol=sqrt((A*x-b)'*(A*x-b)); %两种不同的误差估计方法
    x0 = x;
    if(k>=M)
    disp('Warning: 达到最大迭代次数');
    break;
    end
end
