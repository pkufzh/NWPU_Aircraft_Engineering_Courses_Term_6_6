%基础
10   ,   10.0 %两种写法是相同的
0.3  ,    .3    %两种写法是相同的
-123e-2       %即1.23
2-3.5i           %3.5与i之间不能有空格
1+25e-1j       %即1.0000 + 2.5000i
'a'
'abc'

%常量变量基础
clear;
A=20, a=10
b='ok'  %注意引号
c=1+i
d=1+2i
1+2e-1i  % 1+0.2i
ans
1+(i+j)/10  % 1+0.2i
ans
ans-1  %ans此时为0.2i
'i can''t.' ;
'i can"t'  ;
syms x1 ;
x2=x1+2
2/0
(x2-2-x1)/0
whos

%数据类型与转换
clear
y1='c'          %定义y1为字符型
y2=int16(3.5)    %y2赋值并自动定义为int16型
syms y3          	%y3为符号型

y4=y3+2 		%x赋值并自动定义为符号型
y5=5 			%x重新赋值并自动定义为double型

x=int8(65)        %转换为8位整数65
y=char(65)        %转换为65号ASCII码代表的字符A
z=num2str(65)   %转换为字符串65，相当于z='65'
whos x y z % x y z都与65相关，但他们是不同的

%数值显示格式
clear
b=2/3
format long
b
b*2
format long e
b
b*2
format +
b
b-100

%赋值即定义
x1=20 ,  x2=20.0,  x3=0.5  %自动成为double浮点数
y1='c'                 %y1自动成为字符型
y2=int16(3.5)     %y2自动成为int16整型
syms y3      % 定义y3为符号型
x=y3+2 		% x被赋值并自动成为符号型
x=5 			% x重新赋值又成为double浮点型

%复数
clear
z1=1+2*i,   z2=2+2*i,   z=z1+z2
z_real=real(z),   z_image=imag(z)
z_angle=angle(z),   z_length=abs(z)
angle(1+i)
angle(1)
angle(i)

%存储和载入
clear
y1='c'
y2=int16(3.5)    
syms y3
y4=2/3
save
save mydata1
save mydata2.mat
save c:/mydata3 y1 y3
clear
load,whos
clear
load mydata2.mat y4
whos
clear
load c:/mydata3
whos

%建立矩阵, 用[ ]
clear %以下创建A1 A2 A3是相同的
 A1=[1 2 3;  4,5,6;  7 8 9;  11 12 13]
 A2=[1 2 3;  4,5,6;  7 8 9
          11, 12, 13]
 A3=[1,2 3;  4,5,6;  7 8 9;  11 ...
    12 13]

%建立矩阵, 用冒号 :
clear %以下创建A1 A2 A3是相同的
A=1:2:10         %得到行向量 1 3 5 7 9
B=1:2:9           %得到行向量 1 3 5 7 9
C1=(1:3)'           %C1 C2相同
C2=[1;2;3]
D=[1:3 , 2:4]    %得到行向量 1  2  3  2  3  4
E=[1:3 ; 2:4]    %得到 2x3 矩阵
F1 =[1:0.5:2.4]
F2 =[2.4:-0.5:1]  %F1 F2并非元素顺序颠倒那么简单

%矩阵拼接
clear
a=[1, 3-1, 3]     %注意表达式3-1
b=[a, 3, 4]        %矩阵a作为组件参与矩阵b的创建
c=[0, a, 3] 	
d=[b+c ; a,5,6]
e=b(1:2:5)       % b(1:2:5) 提取了矩阵b的一部分
f=b([1   5])      % 提取b的第一第四元素构成矩阵f


%建立矩阵, 用专门函数
clear
linspace(0,2,3) % 0     1     2
linspace(0,2,5) % 0  0.5000  1.0000  1.5000  2.0000
linspace(2,0,5) % 2.0000  1.5000  1.0000  0.5000   0
logspace(2,3,3) % 100     316.2278     1000

%建立特殊矩阵
clear
ones(3)
zeros(3)
zeros(3,3)
zeros(1,3)
zeros(3,1)
zeros(2,3)
zeros(2,2,3)
a=-4:4
b=reshape(a, 3, 3)
c=eye(3)
d=hilb(5)
e=rand(3)
f=randn(3,2)

%建立矩阵, 用excel
clear
a=xlsread( 'myxls1.xlsx', 'sheet1', 'b2:c3' )
b=xlsread( 'myxls1.xlsx',2, 'a1:z99' )
xlswrite( 'myxls2.xlsx',b)
xlswrite( 'c:\myxls3.xlsx',b,3)

%建立空矩阵
clear
a=[]
b=ones(0,5)


%矩阵元素的标识，寻访，赋值
clear
x=zeros(2,3)
x(2,1)=1 %第2行第1列元素
A=[1,2,3,4,5; 10,20,30,40,50]
A(1, :)   %引用第1行
A(:, 1:3);  A(:,[1 3]) %这2个相同吗？
A(:, :)   %引用全部行和列
A(1,2:3)  %引用第1行的2,3列
B=A(1:2,1:2:5) %引用第1,2行的第1,3,5列形成2x3矩阵

clear
a = 1:2:16
a
a(2)
a(3:5)
a(5:-1:2)
a([2,6,8])
a(end-1)


%矩阵赋值与扩展
clear
x=[-1.3, sqrt(3), (1+2+3)*4/5]
x(5)=abs(x(1))  %x的三个元素扩展为5个，没有明确赋值的元素用0补齐
x(2,1)=10   %x进一步扩展为2行，没有明确赋值的元素用0补齐
x=[x ; 11  12  13  14  15] %x进一步扩展为3行

clear
x=[1  1  1]
y=[11 12 13]
z1=[x, y]
z2=[x  y]
z3=[x; y]      %z1 z2 z3 相同吗？
x=[x;2,2,2]  %通过拼接可以扩展自身

clear
a=[10,20,30], b=a(3:-1:2)
c=[a(1:2:3);b]

%单下标
clear
A=[10:10:30;  40,50,60]
A(3)

clear
a = zeros(2, 5);
a(:) = -4:5
b= -4:5   %a b不同
whos a b

%单下标 更高维情况1
clear
a=zeros(2,3,4)
a(10)=5    %相当于a(2,2,2)=5

%单下标 更高维情况2
clear
a=zeros(2, 4) 
a(:,end)
a(:,end-1)
a(:, end:-1:3)

%单下标 更高维情况3
clear
a=zeros(2, 4) 
a(end,:)
a(end,[2:4])
a ([4 6])=6:7
a(end,[2:end-1])

%size, length
clear
a=ones(4,6)*6
m=size(a)     % 结果是4   6，表示形状是4行6列
n=length(a)  % 结果是6

b=1:6
x=length(b)    % 结果是6
c=b'     
y=length(c)    % 结果是6

%sub2ind   全下标转换为单下标
clear
A = [17  24  1  8;  2  22  7  14;  4  6  13  20];
A(:,:,2) = A - 10   %在3*4二维矩阵基础上又扩了一维
A(2,1,2)
n=sub2ind(size(A),2,1,2)    % n=14
A(n)

%ind2sub  单下标转换为全下标
clear
b = zeros(3);
b(:) = 10:10:90
IND = [3  4  5  6]   %这里的数字将作为单下标
[I,J] = ind2sub(size(b),IND)  %函数可有多个结果

%reshape
clear
a= -4:4
b= reshape(a, 3, 3)
c=reshape(a,3,2) %?

%数量同矩阵进行点运算
clear
A=[1,   4 ,  8]
B=A.*3   %等价于B=[A(1)*3 ,A(2)*3 ,A(3)*3 ] 或3*A
C=A.^2  % 1   16  65,  A^2是有问题的
D=A./10  % 0.1  0.4  0.8
E=A.\2    %  2  0.5  0.25
F=A+1
G=A-1  %不用 .-    .+

%两个矩阵之间对应元素进行点运算
clear
A=[1,   4]
B=[1,   2]
A.*B     %等价于[A(1)*B(1) ,A(2)*B(2)]

C=[4,    3,    1,   2]
A.*C(4:-2:1)     %等价于 [A(1)*C(4) ,A(2)*C(2)]

%矩阵的比较(关系)运算
clear
A=[-1,  4],   B=[-1,  2]
C=[4,    3,    1,   2,   5]
D1=A>=B
D2=A~=B
D3=A<2

%矩阵的逻辑运算
clear
a = [-2; -1;  0; 0; 1;  2]
b = [-2;  1; -1; 0; 0;  2]
x = ~a        %[0;  0;  1;  1;  0;  0]
y = ~b        %[0;  0;  0;  1;  1;  0]
z = a&b      %[1;  1;  0;  0;  0;  1]

clear
A=[2,  2],  B=[1,  0],   C=[2,  -1]
D1= A&B,    D2= A|B,    D3=A&C,   D4=~C,  D5=B&5 

clear
a=[  -1.4   -0.3    0.2]
a+2>2 & a.^2<1

%矩阵作为内置函数的输入变量
clear
x = 0:pi/50:3*pi; %产生一系列x坐标
y = sin(x);            %计算一系列y坐标
y1 = (y>=0).*y;   %y消去负半波，注意运算优先级，如果这   
                             %里的括号（）删掉，将是什么结果？
plot(x,y1,'o')

%
clear
A = [4,15,-45,10,6; 56,0,17,-45,0]
find(A>=10 & A<=20)
[x,y]=find(A>=10 & A<=20)

%矩阵乘 反除
clear
a=[1,2; 3,4]
b=[1;2]
a*b
b*a %不能运算，why
a\b
b/a %也不能运算，why，与a\b并不等价


