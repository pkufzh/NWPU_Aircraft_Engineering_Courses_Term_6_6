%%%%%%%%%%%%%%%%%% ͼƬЧ������ %%%%%%%%%%%%%%%%%%
close,clear
x=-4:4;  y=x;
[x,y]=meshgrid(x,y);      %���� x-y ���ꡰ��㡱����
z=x.^2+y.^2;                   %�������ϵĺ���ֵ
surf(x,y,z);    %��ά����ͼ
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
lighting flat %Ĭ��
lighting none
shading interp
hidden on

close all,clc,clear,disp('view  ����۲���ӽ�')
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

close all,clc,clear,disp('����۲���ӽǣ������ת������͸��')
[x,y,z]=peaks(30);
subplot(1,2,1);
title('surf exam');
surf(x,y,z);
xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);
surfc(x,y,z);
pause
rotate3d on %������ת�������ܣ����������ת��ͼ��
pasue
rotate3d off %�ر���ת��������
pause
subplot(2,2,2);hidden off; %��λ����һ����ͼ����͸��Ч��
pause

close all,clc,clear,disp('ɫ��')
[X,Y]=meshgrid([-4:0.5:4]);
z=sqrt(X.^2+Y.^2);
surf(z);
colorbar('horiz','location','North')
pause
colormap(hot);
pause
colormap(hot)  %hotҲ���Ըĳ�gray   hsv  cool  autumn ��
pause
caxis([1,4])  %��ɫ�����������޸�
pause
shading flat
pause
shading interp %������ɫ��ʽ  Ĭ��Ϊfaceted
pause
brighten(-0.5) %��ɫ����΢�� -1��1
pause


%%%%%%%%%%%%%���
close,clear
h1=line([0:10],[0:10])
get(h1)
get(gca) %�����߶���ĸ������ɲ���ľ��
get(gca,'colororder') %�ɲ�ɫ��
set(h1,'color',[1 0 0]) %��������ɫΪ��ɫ
get(h1); 
box on;
get(gca) %�򿪱߿��ٴβ鿴���������

%%%%%%%%%%%%%��� �̳�ȱʡֵ
close,clear
x=0:2*pi/180:2*pi;
y=sin(2*x); 
set(gca,'DefaultLineColor',[1 0 0]);
h=line(x,y);
set(h,'color','default')

%%%%%%%%%%%%%������ӣ��޸�����
close,clear
x=0:2*pi/180:2*pi;
y1=sin(x);  y2=cos(x);
plot(x,y1,x,y2,x,zeros(size(x) ))
get(gcf)  %���Ȳ�ѯ�����������
h=get(gcf,'children')
hh=get(gca,'children')
y11=get(hh(2),'ydata');
y22=y11/2;
set(hh(2),'ydata',y22)
set(hh(3),'linestyle',':')