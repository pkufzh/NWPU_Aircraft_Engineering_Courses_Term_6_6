%%%%%%%%%%%%%%%%%% 图片效果修饰 %%%%%%%%%%%%%%%%%%
close,clear
x=-4:4;  y=x;
[x,y]=meshgrid(x,y);      %生成 x-y 坐标“格点”矩阵
z=x.^2+y.^2;                   %计算格点上的函数值
surf(x,y,z);    %三维曲面图
colormap(hot); 
colorbar()
shading flat
shading faceted
shading interp
brighten(0.7)
colormap(jet);shading faceted; 

caxis([0,20])
caxis auto; 

xlabel('x','fontsize',22);
ylabel('y','fontsize',22);
zlabel('z','fontsize',22);
light('Position',[-4,-4,0],'Style','infinite'); 
lighting flat %默认
lighting none
shading interp
hidden on

close all,clc,clear,disp('view  立体观察点视角')
x1=0:pi/50:10*pi;
y1=sin(x1);
x2=x1;
y2=y1*1.5;
z1=cos(x1);
z2=z1*1.5;
plot3(x1,y1,z1,'rx',x2,y2,z2,'b');
xlabel('x'); zlabel('z'); ylabel('y');
pause
view(20,20)
pause
view(20,-20)
pause

close all,clc,clear,disp('立体观察点视角，鼠标旋转操作，透视')
[x,y,z]=peaks(30);
subplot(1,2,1);
title('surf exam');
surf(x,y,z);
xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);
surfc(x,y,z);
pause
rotate3d on %打开了旋转操作功能，尝试用鼠标转动图形
pasue
rotate3d off %关闭旋转操作功能
pause
subplot(2,2,2);hidden off; %定位其中一个子图并打开透视效果
pause

close all,clc,clear,disp('色彩')
[X,Y]=meshgrid([-4:0.5:4]);
z=sqrt(X.^2+Y.^2);
surf(z);
colorbar('horiz','location','North')
pause
colormap(hot);
pause
colormap(hot)  %hot也可以改成gray   hsv  cool  autumn 等
pause
caxis([1,4])  %颜色条码上下限修改
pause
shading flat
pause
shading interp %曲面着色方式  默认为faceted
pause
brighten(-0.5) %着色明暗微调 -1至1
pause


%%%%%%%%%%%%%句柄
close,clear
h1=line([0:10],[0:10])
get(h1)
get(gca) %轴是线对象的父代，可查轴的句柄
get(gca,'colororder') %可查色序
set(h1,'color',[1 0 0]) %设置线颜色为红色
get(h1); 
box on;
get(gca) %打开边框，再次查看轴对象属性

%%%%%%%%%%%%%句柄 继承缺省值
close,clear
x=0:2*pi/180:2*pi;
y=sin(2*x); 
set(gca,'DefaultLineColor',[1 0 0]);
h=line(x,y);
set(h,'color','default')

%%%%%%%%%%%%%句柄例子，修改线型
close,clear
x=0:2*pi/180:2*pi;
y1=sin(x);  y2=cos(x);
plot(x,y1,x,y2,x,zeros(size(x) ))
get(gcf)  %首先查询各对象的属性
h=get(gcf,'children')
hh=get(gca,'children')
y11=get(hh(2),'ydata');
y22=y11/2;
set(hh(2),'ydata',y22)
set(hh(3),'linestyle',':')