% if ,error and warning
r=input('请输入半径') %尝试输入 0，-1和10查看运行结果
if r==0
  warning('半径为零，无限小的圆')  %提示并继续运行
elseif r<0
  error('半径为负，无法计算')   %提示并终止运行
end
c=2*pi*r;
disp('周长为')
c

%try
clear;close all;
A=[1 2 3;4 5 6];
B=[7 8 9;10 11 12];
try
    C=A*B;
catch
    C=A.*B;
end
C
lasterr

%switch,error,warning  计算折扣率
clear;close all;
price=input('请输入商品价格:')
if price<=0
    warning('价格应大于0');
    price=input('再给次机会，请输入商品价格:')
end
if price<=0
    error('故意捣乱是吧');
end
switch  fix(price/100)   %与fix相似的函数还有floor或ceil
    case {0,1}          %商品价格小于200
        rate=0;
    case{2,3,4}         %商品价格大于200小于500
        rate=3/100;
    case num2cell(5:9)   %商品价格大于500小于1000
        rate=5/100;
    case num2cell(10:24)   %商品价格大于1000小于2500
        rate=8/100;
    case num2cell(25:49)   %商品价格大于2500小于5000
        rate=10/100;       
    otherwise               %商品价格大于等于5000
        rate=14/100;
end
fprintf('折扣率=%f', rate*100),disp('%')   %输出折扣率


%1~100中奇数求和 for
s=0;
for n=1:2:100;
    s=s+n;
end
s

%1~100中奇数求和 while
s=0;
n=1;
while n<=100
    s=s+n;
    n=n+2;
end
s

%while , input从键盘输入若干个数，当输入0时结束运算，并求这些数的平均值以及它们的和。
clear,clc,close
s=0;
n=0;
x=input('输入一个数(以0结束):');
while(x~=0)
    s=s+x;
    n=n+1;
    x=input ('输入一个数(以0结束):');
end
if (n>0)
    s
    mean=s/n
end 

%输出103到120之间的第一个能被7整除的整数 continue
clear,clc,close
for n=103:120
   if rem(n,7)~=0
      continue %不能整除
      disp('b') %b从不显示出来
   end
   disp('a')
   break %得到第一个数就终止
end

%输出103到120之间的第一个能被7整除的整数 break
clear,clc,close
for n=103:120
   if rem(n,7)==0
       break %能整除
   end
   disp('a')
end
n


%内联函数
fx=inline('sin(x).*y','x','y'); %‘x’和‘y’指定了函数的自变量
x=[0:0.1:2*pi]; 
y(1:31)=0.5; y(32:63)=-1;
f1=fx(x,y);
plot(x,f1,'rx-',x,y,'go ')
legend('f1','y')



%匿名函数
m=1000; f=@(a,b)a.^2+b.^2+m; %匿名函数除了自变量a与b，还可
                                   %以有额外参数传递，例如 m
x=-4:0.5:4; y=x;
[x,y]=meshgrid(x,y); 
z=f(x,y); %自变量
surf(x,y,z); 
%多重匿名函数
close,clear
f=@(x,y)@(a)x.^2+y.^a;
f1=f(2,3), f2=f1(4)








%----------------其他补充---------------



%2d曲线绘图plot  分段函数
clc,clear,disp('2d曲线绘图plot  分段函数 灵活运用比较运算和逻辑运算')
tic %计时开始
x=-6:0.1:6;
y=(x<=0).*sin(x)+(x>=0&x<=3).*x+(x>3).*(-x+6);
plot(x,y),grid on
toc %显示计时时间



%自定义函数 mysub2ind , 功能类似于matlab自带函数sub2ind
clc,clear
a=1:3       %a为行向量
a=[a;a+3] %a扩为2行3列
a=[a;a+6] %a扩为4行3列
a(:,:,2)= -a %a扩为4行3列2层， 行/列/层对应第1/2/3维
disp('here is 4*3*3 array')
a(:,:,3)= -a(:,:,1)*10 %a扩为4*3*3
index=[3,2,3] %定义需要转换的坐标为3,2,3
% 根据matlab矩阵的存储规则“优先遍历低维”
% 在2维矩阵中，就是按列来存储，先存第一列，再存第二列，存每列的时候，从前到后遍历各行，行相对列是较低维
% 3*4*5*6矩阵中，最低维是3行，最高维是6 whatever. (行、列、层之后实在难以命名)
% 根据以上规则，4*3*3的a矩阵，全坐标3,2,3对应单坐标应为  (3层-1层)*(4行*3列)+(2列-1列)(4行)+3行=31

mysub2ind(a,index)  %见mysub2ind.m
sub2ind(size(a),3,2,3)

%更复杂的例子
b=a
b(:,:,:,2)=  2*a
b(:,:,:,3)= -2*a
b(:,:,:,4)= -3*a
b(:,:,:,5)=  7*a %b扩为4*3*3*5
index=[3,2,3,5]
%4*3*3*5的b矩阵，全坐标3,2,3,5对应单坐标应为
%(5-1)*(4*3*3)+(3层-1层)*(4行*3列)+(2列-1列)(4行)+3行=175
mysub2ind(b,index)  %见mysub2ind.m
sub2ind(size(b),3,2,3,5)