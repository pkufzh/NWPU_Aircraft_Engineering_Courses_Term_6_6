%% MATLAB软件与应用（第3次上机MATLAB程序源代码）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月14日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format short
fprintf('MATLAB软件与应用（第3次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月14日\n');
fprintf('\n');
fprintf('部分程序运行结果如下：\n');
fprintf('\n');

%% Problem_001（用红色点画线方式绘制y=sin(x)+cos(10x)在[-pi,pi上的曲线]，并以函数为标题）
figure; % 创建一个新的图层
x=-pi:(pi/60):pi;
y=sin(x)+cos(10*x);
plot(x,y,'r-.','LineWidth',2); % 绘制曲线
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),title('Figure 1: y=sin(x)+cos(10x),x=[-\pi,\pi]');
grid on;
box on;

%% Problem_002（用多子图方式分别绘制曲线y1=sin(x+1),y2=e^(2x),y3=y1+y2在[0,5*pi]上的曲线）
x=0:(pi/60):(5*pi);
y1=sin(x+1);
y2=exp(2*x);
y3=y1+y2;
% 依次创建三个子图
figure;
subplot(3,1,1),plot(x,y1,'r-','LineWidth',2),xlabel('Coordinate \itx'),ylabel('Coordinate \ity1'),title('Figure 2.1: y1=sin(x+1),x=[0,5\pi]');
subplot(3,1,2),plot(x,y2,'b-','LineWidth',2),xlabel('Coordinate \itx'),ylabel('Coordinate \ity2'),title('Figure 2.2: y2=e^{2x},x=[0,5\pi]');
subplot(3,1,3),plot(x,y3,'m-','LineWidth',2),xlabel('Coordinate \itx'),ylabel('Coordinate \ity3'),title('Figure 2.3: y3=y1+y2=sin(x+1)+e^{2x},x=[0,5\pi]');

%% Problem_003（采用多图叠绘方式分别绘制正弦曲线y1=sin(x+1)、余弦曲线y2=cos(x)+1在区间[0,2*pi]上的曲线）
x=0:(pi/60):(2*pi);
y1=sin(x+1);
y2=cos(x)+1;
% 采用多图叠绘的方式绘制
figure;
hold on; % 开启叠绘模式
plot(x,y1,'r-','LineWidth',2);
plot(x,y2,'g--','LineWidth',2);
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),title('Figure 3: 多图叠绘操作示意图')
legend('正弦曲线','余弦曲线','Location','Best');
grid on;
box on;

%% Problem_004（分别以柱状图和饼状图的方式绘制出该专业学生各状态的比例）
% 导入数据
stu_tot=120; % 该专业大四学生总人数
% type=['考研学生';'出国学生';'工作学生';'创业学生';'留级学生'];
type=1:5;
stu_each=[18,12,72,6,12];
figure;
subplot(2,1,1);bar(type,stu_each); % 绘制柱状图
set(gca,'XTickLabel',{'考研学生','出国学生','工作学生','创业学生','留级学生'});
title('Figure 4.1: 该专业学生各状态的比例柱状图');
subplot(2,1,2);pie(stu_each,[1 1 1 1 1]); % 绘制饼状图
title('Figure 4.2: 该专业学生各状态的比例饼状图');
legend({'考研学生','出国学生','工作学生','创业学生','留级学生'},'Location','Best');

%% Problem_005（绘制三维曲线）
t=1:0.05:10;
x=3*t.*sin(t);
y=3*t.*cos(t);
z=t;
figure;
plot3(x,y,z,'r-','LineWidth',2);
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),zlabel('Coordinate \itz');
title('Figure 5: 三维曲线绘制');
grid on;
box on;

%% Problem_006（在XY平面内选择区域[0,-6]*[0,-6]绘制二维高斯函数z=e^(-((x-3)^2+(y-3)^2))的三维网格曲面）
x=-6:0.05:6;
y=-6:0.05:6;
[X,Y]=meshgrid(x,y); % 生成x,y坐标“格点”矩阵
Z=exp(-(((X-3).^2)+((Y-3).^2)));
figure;
mesh(X,Y,Z); % 生成二维高斯函数的三维网格曲面
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),zlabel('Coordinate \itz');
title('Figure 6: 生成二维高斯函数的三维网格曲面');
grid on;
box on;

%% Problem_007（在XY平面内选择区域[-6,+6]*[-6,+6]绘制二维高斯函数z=sin((x^2+y^2)^(1/2))/((x^2+y^2)^(1/2))的三维网格曲面）
x=-6:0.2:6;
y=-6:0.2:6;
[X,Y]=meshgrid(x,y); % 生成x,y坐标“格点”矩阵
Z=(sin(sqrt((X.^2)+(Y.^2))))./(sqrt((X.^2)+(Y.^2)));
figure;
surf(X,Y,Z); % 生成二维高斯函数的三维网格曲面
shading interp
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),zlabel('Coordinate \itz');
title('Figure 7: 生成函数z的三维光滑曲面');
grid on;
box on;

%% Problem_008（用sphere函数产生球表面坐标，绘制不透明网线图、透明网线图、表面图）
% 生成三维球表面坐标，球半径为30
[X,Y,Z]=sphere(30);
figure;
subplot(2,2,1);mesh(X,Y,Z);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 8.1: 绘制球体不透明网线图');
subplot(2,2,2);mesh(X,Y,Z);hidden off;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 8.2: 绘制球体透明网线图');
subplot(2,2,3);surf(X,Y,Z);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 8.3: 绘制球体表面图');

%% Problem_009（绘制peaks函数的表面图，用colormap函数改变预置的色图，观察色彩的分布情况）
[X,Y,Z]=peaks(30);
figure;
surf(X,Y,Z);colormap('hot');
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 9.1: 绘制peaks函数表面图，色图为暖色色图hot');
figure;
surf(X,Y,Z);colormap('cool');
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 9.2: 绘制peaks函数表面图，色图为冷色色图cool');
figure;
surf(X,Y,Z);colormap('autumn');
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 9.3: 绘制peaks函数表面图，色图为红黄色图autumn');

%% Problem_010（绘制光照处理后的球面，取三个不同的光照位置进行比较，并使用多子图的方式表达）
[X,Y,Z]=sphere(30);
figure;
subplot(2,2,1);surf(X,Y,Z);shading interp;
light('position',[2,-2,2]);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 10.1: 球面光照模式①');
subplot(2,2,2);surf(X,Y,Z);shading interp;
light('position',[1,1,1]);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 10.2: 球面光照模式②');
subplot(2,2,3);surf(X,Y,Z);shading interp;
light('position',[0.5,-0.5,2]);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 10.3: 球面光照模式③');

%% Problem_011（图形句柄操作）
t=0:0.05:10;
x=sin(t);
y=cos(t);
z=t;
figure;
fprintf('【11】问题11：未修改时（默认）的三维曲线句柄如下：\n');
fig_1=plot3(x,y,z) % 用默认属性绘制三维曲线，并返回其句柄值到fig，在工作区显示句柄信息
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 11: 图形句柄操作示意图');
set(fig_1,'Color',[0,1,0]); % 利用图形句柄操作将曲线的颜色改为绿色
set(fig_1,'LineStyle','--'); % 利用图形句柄操作将曲线线型改为虚线
set(fig_1,'LineWidth',2); % 利用图形句柄操作将曲线线宽设置为2
fprintf('修改后的三维曲线句柄如下：\n');
fig_1 % 显示经过图形句柄操作修改后的曲线句柄信息
fprintf('\n');

%% Problem_012（绘制一条曲线，采用搜索法根据线型属性获取曲线句柄，并修改曲线线型）
% 绘制一条正弦函数曲线
x=0:(pi/60):(2*pi);
y1=sin(x);y2=cos(x);y3=sin(2*x);
figure;
hold on;
plot(x,y1,'r-','LineWidth',2);
plot(x,y2,'b--','LineWidth',2);
plot(x,y3,'m-.','LineWidth',2);
grid on
box on
hold off
xlabel('Coordinate \itx'),ylabel('Coordinate \ity');
% 利用搜索法根据线型属性获取曲线句柄
fig_line=get(gca,'Children'); % 获得所有包含曲线的句柄集合
tot_line=0; % 记录所有满足搜索线型条件的曲线条数
for k=1:size(fig_line)
    if strcmp((get(fig_line(k),'LineStyle')),'--')==1 % 搜索线型为虚线的曲线
        tot_line=tot_line+1;
        num_target_line(tot_line)=k; % 记录所有满足搜索条件的曲线序号
        fig_target_line=fig_line(k); % 返回搜索目标曲线句柄到fig_target_Line
        set(fig_target_line,'LineStyle','-'); % 将句柄fig_target_Line对应曲线线性（虚线）修改为直线
    end
end
title('Figure 12: 利用搜索法寻找到多条曲线中所有线型为虚线的曲线，并将线型修改为直线');
fprintf('【12】问题12：利用搜索法获得所有曲线中满足线型为虚线的曲线共有%d条，编号为：',tot_line);
for i=1:tot_line-1
    fprintf('%d号,',num_target_line(i));
end
fprintf('%d号\n',num_target_line(tot_line));
fprintf('\n');

%% Problem_013（读取一张.fig格式的图片，获取其中的标题句柄，并根据句柄修改标题）
open('Figure 1.fig'); % 打开.fig格式的图片
title_fig=get(gca,'Title');
set(title_fig,'String','Figure 13: 图片标题修改（利用句柄方法）'); % 根据句柄修改标题
