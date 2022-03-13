%以下代码运行到pause处暂停，按任意键继续。

%%%%%%%%%%%%
close all,clc,clear
x=-pi:pi/10:pi; y=sin(x);  %21个数据点
plot(y)    %plot(y’)的结果也相同
z=[y;y+0.1;y+0.2];  %3*21矩阵
plot(z')

%%%%%%%%%%%%
close all,clc,clear
x=-pi:pi/10:pi; y=sin(x);  %21个数据点
z=[y;y+0.1;y+0.2]; %3*21
hold on;
plot(x,z);   %这4个结果相同，是否总是如此
plot(x,z');
plot(x',z);
plot(x',z')
hold off;
plot(z,x);  %横纵坐标与前面相反

%%%%%%%%%%%%
close all,clc,clear
x = -pi:pi/10:pi; %1*21
x=[x;x+7;x-7];
y=sin(x); %x和y  3*21
plot(x',y') %x'和y'  21*3

%%%%%%%%%%%%%%%%%%%%%% 2维绘图 %%%%%%%%%%%%%%%%%%%%%%
close all,clc,clear,disp('2d曲线绘图plot')
x = -pi:pi/10:pi;
y = sin(x);
plot(x,y)
hold on %什么作用
plot(x-2,y,'-rx',x-2,y.^2,'-bx')
%axis([-8,4,-1,1])  %可调整坐标轴范围 xmin xmax ymin ymax
pause

close all,clc,clear,disp('2d曲线绘图plot   双纵坐标')
x = 0:0.01:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
hold off
plotyy(x,y1,x,y2);
pause


close all,clc,clear,disp('2d曲线绘图plot  曲线颜色等定义 以及 多子图')
t=(0:15)*2*pi/15;
y=sin(t);
subplot(3,2,1), plot(t, y); title('Lins style is default')
subplot(3,2,2), plot(t, y, 'o'); title('Lins style is o')
subplot(3,2,3), plot(t, y, 'k:'); title('Lins style is k:')
subplot(3,2,4), plot(t, y, 'k:*'); title('Lins style is k:*')
subplot(3,2,5), plot(t, y, 'm-d'); title('Lins style is m-d')
subplot(3,2,6), plot(t, y, 'r-p'); title('Lins style is r-p')
pause

close all
t=(pi*(0:1000)/1000)';
y1=sin(t);y2=sin(10*t);y12=sin(t).*sin(10*t);
subplot(2,2,1), plot(t,y1); axis([0,pi,-1,1])
subplot(2,2,2), plot(t,y2); axis([0,pi,-1,1])
subplot('position',[0.2,0.05,0.6,0.45])
plot(t,y12,'b-',t,[y1,-y1],'r:');
pause

close all,clc,clear,disp('2d曲线绘图plot  其他功能  注意网格')
x=0:0.1*pi:2*pi;
y=sin(x);
subplot(1,1,1)  %不写这一行会变成什么  或者用close all关闭所有绘图窗口
plot(x,y)
axis([0,2*pi,-1,1])
grid on
pause

close all,clc,clear,disp('plot,注意坐标轴')
t=0:2*pi/99:2*pi;
x=1.15*cos(t); y=3.25*sin(t);    % y为长轴，x为短轴
subplot(2,2,1); plot(x, y);
axis off
title('axis off'); 
subplot(2,2,2); plot(x,y);
axis image;
title('axis image'); 
subplot(2,2,3); plot(x,y);
axis equal;
title('axis Equal'); 
subplot(2,2,4); plot(x,y);
axis square;
title('axis Square');
pause

close all,clc,clear,disp('plot，注意刻度')
t=6*pi*(0:100)/100;
y=1-exp(-0.3*t).*cos(0.7*t);
tt=t(find(abs(y-1)>0.05)); 
ts=max(tt);       
subplot(1,1,1)
plot(t,y,'r-');
grid on;            
axis([0,6*pi,0.6,max(y)]);                                              
title('y=1-exp(-\alpha*t)*cos(\omega*t)');                      
hold on;
plot(ts,0.95,'bo');
hold off;           
set(gca,'xtick',[2*pi,4*pi,6*pi],'ytick',[0.95,1,1.05,max(y)]); 
grid on;
pause


close all,clc,clear,disp('plot，注意坐标显示范围')
x=0:0.1*pi:2*pi;   y=sin(x);
plot(x,y);
xlim([-1,10]);
pause

close all,clc,clear,disp('plot，注意刻度和边框')
x=0:0.1*pi:2*pi;   y=sin(x);
plot(x,y);
pause
box off;  
set(gca,'xtick',0:pi/2:2*pi,'ytick',[-1,-0.5,0,0.5,1])
pause


close all,clc,clear,disp('plot，注意文本')
t=(0:100)/100*2*pi;
y=sin(t);
plot(t, y)
text(3*pi/4,sin(3*pi/4), '\fontsize{16}\leftarrowsin(t) = .707 ')
text(pi, sin(pi), '\fontsize{16}\leftarrowsin(t) = 0 ')
text(5*pi/4, sin(5*pi/4), '\fontsize{16}sin(t) = -.707\rightarrow',...
       'HorizontalAlignment','right')
pause


close all,clc,clear,disp('plot，注意图例')
x=0:0.1*pi:2*pi;
y=sin(x); plot(x,y,x,y.*y);
axis([0,2*pi,-1,1])
xlabel('x(0-\pi)','fontweight','bold');
ylabel('y=sin(x)','fontweight','bold');
title('正弦函数','fontsize',12,'fontname','It')
legend('sin','sin^2')
pause

close all,clc,clear,disp('plot，注意图例位置')
x = 0:pi/6:pi;     y1=sin(x);     y2=y1+0.2;
plot(x,y1,'ro-.',x,y2,'b*-')
title('两个函数','fontsize',18)
legend('正弦','偏置正弦','location','NorthWest')
pause

close all,clc,clear,disp('plot，注意背景')
x=0:0.1*pi:2*pi;   y=sin(x);  
back1=[0.3   0.6   0.4]
figure('color',back1)  %也可用set(gcf,....)来设置背景颜色
plot(x,y)
pause

close all,clc,clear,disp('特殊2d图   对数坐标')
x=0:0.001*pi:pi;
y=sin(x).^2+0.0001;
semilogy(x,y,'-*')
pause


close all,clc,clear,disp('特殊2d图   极坐标')
x=0:0.01*pi:4*pi;
y=sin(x/2)+x;
polar(x,y,'-')
pause


close all,clc,clear,disp('特殊2d图   柱状图')
x=1:10;y=rand(10,1);
bar(x,y)
pause


close all,clc,clear,disp('特殊2d图   羽状图')
x=0:0.1*pi:2*pi; y=sin(x).*x;
feather(x,y)
pause


close all,clc,clear,disp('特殊2d图   饼状图')
x=[2,4,6,8];
pie(x,{'math','english','chinese','music'})
pause

close all,clc,clear,disp('特殊2d图  离散杆图  阶梯图  ')
t=2*pi*(0:20)/20; 
y=cos(t).*exp(-0.4*t);
stem(t,y,'g');  hold on;  %绿色离散杆图
stairs(t,y,'r'); hold off ; %红色阶梯图 
pause

close all,clc,clear,disp('用函数绘曲线图')
lim=[0,2*pi,-1,1]; %xmin xmax ymin ymax
fplot('[sin(x),cos(x)]',lim) %可以一次绘出多条曲线，也可以使用自定义函数
pause

close all,clc,clear,disp('用contour和quiver绘制二维等高线图和矢量图')
[x,y]=meshgrid(-2:0.2:2);
z=x.*exp(-x.^2-y.^2);
[dx,dy]=gradient(z,0.2,0.2);
contour(x,y,z,'ShowText','on');
hold on
pause
quiver(x,y,dx,dy);
pause

%%%%%%%%%%%%%%%%%%%%%% 3维绘图 %%%%%%%%%%%%%%%%%%%%%%

close all,clc,clear,disp('3d曲线绘图plot3')
x1=0:pi/50:10*pi;
y1=sin(x1);
x2=x1;
y2=y1*1.5;
z1=cos(x1);
z2=z1*1.5;
plot3(x1,y1,z1,'rx',x2,y2,z2,'b');
pause


close all,clc,clear,disp('plot3 矩阵的每列画出一条线')
[x,y]=meshgrid(-2:1:2,-2:0.1:2);      %5*41的经纬线
z=x.*exp(-x.^2-y.^2);
plot3(x,y,z)      %5条线，每条对应z的一列
pause

close all,clc,clear,disp('3d网格曲面  mesh   meshc  meshz   meshgrid')
[X,Y]=meshgrid([-4:0.5:4]);
z=sqrt(X.^2+Y.^2);
subplot(2,2,1)
mesh(z)
subplot(2,2,2)
meshc(z)
subplot(2,2,3)
meshz(z)
subplot(2,2,4)
surf(z)
pause

close all,clc,clear,disp('3d曲面  surf')
[x,y,z]=peaks(30);
subplot(1,2,1);
title('surf exam');
surf(x,y,z);
xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);
surfc(x,y,z);
pause

close all,clc,clear,disp('3d曲面  surfl   surfnorm')
[x,y,z]=peaks(30);
subplot(1,2,1);
title('surf exam');
surfl(x,y,z);
xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);
surfnorm(x,y,z);
pause

close all,clc,clear,disp('准4d绘图')
[x,y,z,v]=flow;
sx=2:2:10
subplot(1,2,1);
slice(x,y,z,v,sx,0,0)
shading interp;
subplot(1,2,2);
vmin=min(min(min(v)));
vmax=max(max(max(v)));
sv=linspace(vmin+1,vmax-1,20);
contourslice(x,y,z,v,sx,0,0,sv);
view([-45,30]);  
grid on;
pause

close all,clc,clear,disp('读写修改图片文件')
img1=imread('mudan.jpg');    % 读入图片
img2=imread('shock.bmp');
whos  img1 img2
imshow(img1); % Display image
lighter = 2 * img1;
subplot(1,2,1);
imshow(img1); % 显示原始图片
pause
title('Original');  
subplot(1,2,2);
imshow(lighter); % 显示增亮后的图片
title('Lighter'); 
pause





%%%%%%%%%%%%%%%%%% 其他： 视角、色彩 %%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%% 关于图形裁剪、变换以及句柄绘图，请参考教材中的示例。
