%% MATLAB软件与应用（第2次上机MATLAB程序源代码）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月9日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format short
fprintf('MATLAB软件与应用（第2次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月9日\n');
fprintf('\n');
fprintf('部分程序运行结果如下：\n');
fprintf('\n');

%% Problem_001（分别将100、'China'、A赋值给数值变量x1、字符变量y1、符号变量z1，然后利用whos查看各变量的相关属性。）
x1=100; % 创建数值变量x1
y1='China'; % 创建字符变量y1
syms A;
z1=A; % 创建符号变量z1

fprintf('【1】第一问：各变量的相关属性如下：\n');
whos x1 % 显示x1变量的相关属性
whos y1 % 显示y1变量的相关属性
whos z1 % 显示z1变量的相关属性
fprintf('\n');

%% Problem_002 （矩阵保存与读取操作）
A=rand(3,3); % 步骤一：创建3行3列的随机数矩阵A
save('data_A.mat','A'); % 步骤二：将A矩阵保存到硬盘上的MATLAB数据文件data_A.mat中
clear all % 步骤三：清空内存
load data_A.mat; % 步骤四，将硬盘上data_A.mat文件中的数据载入内存中

%% Problem_003 （创建行向量和列向量操作）
hang=0:2:100; % 创建0到100、公差为2的等差数列的行向量
lie=(0:2:100)'; % 创建0到100、公差为2的等差数列的列向量
fprintf('【3】第三问：创建0到100、公差为2的等差数列的行、列向量分别为工作区中的hang,lie变量\n');
fprintf('\n');

%% Problem_004 （数组综合操作）
fprintf('【4】第四问：各数组操作产生数据结果如下：\n');
x=linspace(100,1,20) % 步骤一：产生100到1的等差数列，数据点为20个（线性），赋值给x
x1=x(10) % 步骤二：获取x的第10个单元的值，赋值给x1
x2=x(1:10) % 步骤三：获取x的前10个单元的值，赋值给x2
x3=x((end-4):end) % 步骤四：获取x的后5个单元的数据，赋值给x3
x4=x(2:2:20) % 步骤五：获取x的偶数单元的数据，赋值给x4
x5=x(end:(-1):1) % 步骤六：将x的数据倒排，赋值给x5
fprintf('\n');

%% Problem_005 （Excel文件交互数据操作）
fprintf('【5】第五问：读取Excel文件"data.xls"的Sheet1中[A3:E8]区域数据如下：\n');
Pro_005_data=xlsread('data.xls',1,'A3:E8')
fprintf('\n');

%% Problem_006 （魔方矩阵操作）
fprintf('【6】第六问：对初始5行5列的魔方矩阵所做操作结果如下：\n');
A=magic(5) % 步骤一：生成一个5行5列的魔方矩阵A
A([1:3],[1:3])=eye(3) % 步骤二：将A矩阵的前3行和前3列赋值为单位矩阵
A(4,:)=0 % 步骤三：将A矩阵第4行赋值为0行向量
A(5,:)=[]; A(:,5)=[] % 步骤四：最后删除A矩阵的第5列和第5行
fprintf('\n');

%% Problem_007 （字符串操作）
fprintf('【7】第七问：对初始字符数组与数值变量进行操作结果如下：\n');
s1='adAsaBfCd' % 步骤一：创建一个大小写字母构成的字符串'adAsaBfCd'
num_1=12345 % 步骤二：创建一个数值变量12345
s2=num2str(num_1) % 步骤三：将创建完毕的数值变量转换成数字构成的字符串
s3=[s1 s2] % 步骤四：将两个字符串拼接成一个字符串

% 步骤五：找出字符串中的大写字母，并将大写字母转换成小写字母
upper_pos=find(s3>='A' & s3<='Z');
s3(upper_pos)=s3(upper_pos)+32

% 步骤六：找出字符串中的数字字符，并将其转换成数值，然后将数字字符从字符串中删除
number_pos=find(s3>='0' & s3<='9');
s4=s3(number_pos);
num_2=str2num(s4)
s3(number_pos)=[]

fprintf('\n');

%% Problem_008 （结构数组创建与操作）
fprintf('【8】第八问：创建结构数组family并进行操作结果如下：\n');
% 步骤一：创建一个名为family的结构数组，记录家庭成员的姓名、性别、年龄、爱好四种信息
family=struct('Name',{'Me','Dad','Mum'},'Sex',{'Male','Male','Female'},...
              'Age',{21,45,44},'Hobby',{'Study','Movie','Sport'});
family

% 步骤二：在结构数组family中添加第五个信息身高
family(1).Height=178;
family(2).Height=172;
family(3).Height=162;
family

% 步骤三：删除年龄信息
family=rmfield(family,'Age');
family
fprintf('\n');

%% Problem_009 （元胞数组创建与操作）
fprintf('【9】第九问：创建元胞数组friend并进行操作结果如下：\n');
% 步骤一：创建一个名为friend的元胞数组，记录4个最要好朋友的信息
friend(1,1)={['Stu_001';'Stu_002';'Stu_003';'Stu_004']};
friend(1,2)={['Male  ';'Male  ';'Female';'Male  ']};
friend(1,3)={['19990328';'19990716';'19990430';'19990520']};
friend(1,4)={['Reading    ';'Basketball ';'Dressing   ';'Programming']};
friend

% 步骤二：在元胞数组friend中添加第五个信息身高
friend(1,5)={[180,174,168,172]};
friend

% 步骤三：删除爱好信息
friend(4)=[];
friend
fprintf('\n');

%% Problem_010 （矩阵运算）
% 创建3*3的两个随机数据数组A与B
A=rand(3,3);
B=rand(3,3);
fprintf('【10.1】第十问第一小问：对随机产生的3*3矩阵A，B进行“非点”运算结果保存至工作区Y1~Y7：\n');
% 类型一：进行“非点”运算
Y1=A+B;
Y2=A-B;
Y3=A*B;
Y4=A\B;
Y5=A/B;
Y6=A^2;
Y7=3^B;
% Y8=A^B; % 用于对矩阵求幂的维度不正确，报错！
fprintf('【10.2】第十问第二小问：对随机产生的3*3矩阵A，B进行“点”运算结果保存至工作区Z3~Z8：\n');
% 类型二：进行“点”运算
% Z1=A.+B; % 无“点加”运算符，报错！
% Z2=A.-B; % 无“点减”运算符，报错！
Z3=A.*B;
Z4=A.\B;
Z5=A./B;
Z6=A.^2;
Z7=3.^B;
Z8=A.^B;
fprintf('\n');

%% Problem_011 （数组索引练习）
fprintf('【11】第十一问：A向量已保存在工作区，满足筛选条件的数保存在A_meeting_condition数组如下：\n');
% 步骤一：生成向量A，其元素为区间[1,999]内的整数
A=1:999;
% 步骤二：然后找出A中能被13整除且大于500的数
A_meeting_condition=A(find(rem(A,13)==0 & A>500))
fprintf('\n');

%% Problem_012 （求解线性方程组）
fprintf('【12】第十二问：对线性方程组的系数矩阵计算的一系列性质，以及求解方程组结果X矩阵如下：\n');
% 步骤一：定义线性方程组的系数矩阵为A
A=[1,-1,1;2,1,1;1,-1,-2]

% 步骤二：求解系数矩阵的行列式、迹、秩、逆
A_det=det(A) % 求解系数矩阵行列式
A_trace=trace(A) % 求解系数矩阵迹
A_rank=rank(A) % 求解系数矩阵秩
A_inv=inv(A) % 求解系数矩阵逆

% 步骤三：求解线性方程组
B=[1;2;-4]
X=A\B

fprintf('\n');

%% Problem_013 （请用两种方法求解方程2x^5+3x^3+x^2-4*x+10=0）
fprintf('【13】第十三问：用两种方式求解多项式方程2x^5+3x^3+x^2-4*x+10=0：\n');
% 方法一：用求特征值的方法求解上述方程
p=[2,0,3,1,0,-4,10]; % 导入方程左端多项式p的系数
A=compan(p); % 求解p的伴随矩阵A
fprintf('方法一：利用特征值求解多项式方程结果x1如下：\n');
x1=eig(A) % 求解A的特征值，即为p=0的根

% 方法二：直接用roots函数求解多项式p的零点
fprintf('方法二：直接用roots函数求解多项式p的零点结果x2如下：\n');
x2=roots(p)

fprintf('比较可观察到两种方法求解的结果一致：\n');
fprintf('\n');
