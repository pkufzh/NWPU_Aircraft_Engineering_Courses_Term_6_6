%���´������е�pause����ͣ���������������

%%%%%%%%%%%%
close all,clc,clear
x=-pi:pi/10:pi; y=sin(x);  %21�����ݵ�
plot(y)    %plot(y��)�Ľ��Ҳ��ͬ
z=[y;y+0.1;y+0.2];  %3*21����
plot(z')

%%%%%%%%%%%%
close all,clc,clear
x=-pi:pi/10:pi; y=sin(x);  %21�����ݵ�
z=[y;y+0.1;y+0.2]; %3*21
hold on;
plot(x,z);   %��4�������ͬ���Ƿ��������
plot(x,z');
plot(x',z);
plot(x',z')
hold off;
plot(z,x);  %����������ǰ���෴

%%%%%%%%%%%%
close all,clc,clear
x = -pi:pi/10:pi; %1*21
x=[x;x+7;x-7];
y=sin(x); %x��y  3*21
plot(x',y') %x'��y'  21*3

%%%%%%%%%%%%%%%%%%%%%% 2ά��ͼ %%%%%%%%%%%%%%%%%%%%%%
close all,clc,clear,disp('2d���߻�ͼplot')
x = -pi:pi/10:pi;
y = sin(x);
plot(x,y)
hold on %ʲô����
plot(x-2,y,'-rx',x-2,y.^2,'-bx')
%axis([-8,4,-1,1])  %�ɵ��������᷶Χ xmin xmax ymin ymax
pause

close all,clc,clear,disp('2d���߻�ͼplot   ˫������')
x = 0:0.01:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
hold off
plotyy(x,y1,x,y2);
pause


close all,clc,clear,disp('2d���߻�ͼplot  ������ɫ�ȶ��� �Լ� ����ͼ')
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

close all,clc,clear,disp('2d���߻�ͼplot  ��������  ע������')
x=0:0.1*pi:2*pi;
y=sin(x);
subplot(1,1,1)  %��д��һ�л���ʲô  ������close all�ر����л�ͼ����
plot(x,y)
axis([0,2*pi,-1,1])
grid on
pause

close all,clc,clear,disp('plot,ע��������')
t=0:2*pi/99:2*pi;
x=1.15*cos(t); y=3.25*sin(t);    % yΪ���ᣬxΪ����
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

close all,clc,clear,disp('plot��ע��̶�')
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


close all,clc,clear,disp('plot��ע��������ʾ��Χ')
x=0:0.1*pi:2*pi;   y=sin(x);
plot(x,y);
xlim([-1,10]);
pause

close all,clc,clear,disp('plot��ע��̶Ⱥͱ߿�')
x=0:0.1*pi:2*pi;   y=sin(x);
plot(x,y);
pause
box off;  
set(gca,'xtick',0:pi/2:2*pi,'ytick',[-1,-0.5,0,0.5,1])
pause


close all,clc,clear,disp('plot��ע���ı�')
t=(0:100)/100*2*pi;
y=sin(t);
plot(t, y)
text(3*pi/4,sin(3*pi/4), '\fontsize{16}\leftarrowsin(t) = .707 ')
text(pi, sin(pi), '\fontsize{16}\leftarrowsin(t) = 0 ')
text(5*pi/4, sin(5*pi/4), '\fontsize{16}sin(t) = -.707\rightarrow',...
       'HorizontalAlignment','right')
pause


close all,clc,clear,disp('plot��ע��ͼ��')
x=0:0.1*pi:2*pi;
y=sin(x); plot(x,y,x,y.*y);
axis([0,2*pi,-1,1])
xlabel('x(0-\pi)','fontweight','bold');
ylabel('y=sin(x)','fontweight','bold');
title('���Һ���','fontsize',12,'fontname','It')
legend('sin','sin^2')
pause

close all,clc,clear,disp('plot��ע��ͼ��λ��')
x = 0:pi/6:pi;     y1=sin(x);     y2=y1+0.2;
plot(x,y1,'ro-.',x,y2,'b*-')
title('��������','fontsize',18)
legend('����','ƫ������','location','NorthWest')
pause

close all,clc,clear,disp('plot��ע�ⱳ��')
x=0:0.1*pi:2*pi;   y=sin(x);  
back1=[0.3   0.6   0.4]
figure('color',back1)  %Ҳ����set(gcf,....)�����ñ�����ɫ
plot(x,y)
pause

close all,clc,clear,disp('����2dͼ   ��������')
x=0:0.001*pi:pi;
y=sin(x).^2+0.0001;
semilogy(x,y,'-*')
pause


close all,clc,clear,disp('����2dͼ   ������')
x=0:0.01*pi:4*pi;
y=sin(x/2)+x;
polar(x,y,'-')
pause


close all,clc,clear,disp('����2dͼ   ��״ͼ')
x=1:10;y=rand(10,1);
bar(x,y)
pause


close all,clc,clear,disp('����2dͼ   ��״ͼ')
x=0:0.1*pi:2*pi; y=sin(x).*x;
feather(x,y)
pause


close all,clc,clear,disp('����2dͼ   ��״ͼ')
x=[2,4,6,8];
pie(x,{'math','english','chinese','music'})
pause

close all,clc,clear,disp('����2dͼ  ��ɢ��ͼ  ����ͼ  ')
t=2*pi*(0:20)/20; 
y=cos(t).*exp(-0.4*t);
stem(t,y,'g');  hold on;  %��ɫ��ɢ��ͼ
stairs(t,y,'r'); hold off ; %��ɫ����ͼ 
pause

close all,clc,clear,disp('�ú���������ͼ')
lim=[0,2*pi,-1,1]; %xmin xmax ymin ymax
fplot('[sin(x),cos(x)]',lim) %����һ�λ���������ߣ�Ҳ����ʹ���Զ��庯��
pause

close all,clc,clear,disp('��contour��quiver���ƶ�ά�ȸ���ͼ��ʸ��ͼ')
[x,y]=meshgrid(-2:0.2:2);
z=x.*exp(-x.^2-y.^2);
[dx,dy]=gradient(z,0.2,0.2);
contour(x,y,z,'ShowText','on');
hold on
pause
quiver(x,y,dx,dy);
pause

%%%%%%%%%%%%%%%%%%%%%% 3ά��ͼ %%%%%%%%%%%%%%%%%%%%%%

close all,clc,clear,disp('3d���߻�ͼplot3')
x1=0:pi/50:10*pi;
y1=sin(x1);
x2=x1;
y2=y1*1.5;
z1=cos(x1);
z2=z1*1.5;
plot3(x1,y1,z1,'rx',x2,y2,z2,'b');
pause


close all,clc,clear,disp('plot3 �����ÿ�л���һ����')
[x,y]=meshgrid(-2:1:2,-2:0.1:2);      %5*41�ľ�γ��
z=x.*exp(-x.^2-y.^2);
plot3(x,y,z)      %5���ߣ�ÿ����Ӧz��һ��
pause

close all,clc,clear,disp('3d��������  mesh   meshc  meshz   meshgrid')
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

close all,clc,clear,disp('3d����  surf')
[x,y,z]=peaks(30);
subplot(1,2,1);
title('surf exam');
surf(x,y,z);
xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);
surfc(x,y,z);
pause

close all,clc,clear,disp('3d����  surfl   surfnorm')
[x,y,z]=peaks(30);
subplot(1,2,1);
title('surf exam');
surfl(x,y,z);
xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);
surfnorm(x,y,z);
pause

close all,clc,clear,disp('׼4d��ͼ')
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

close all,clc,clear,disp('��д�޸�ͼƬ�ļ�')
img1=imread('mudan.jpg');    % ����ͼƬ
img2=imread('shock.bmp');
whos  img1 img2
imshow(img1); % Display image
lighter = 2 * img1;
subplot(1,2,1);
imshow(img1); % ��ʾԭʼͼƬ
pause
title('Original');  
subplot(1,2,2);
imshow(lighter); % ��ʾ�������ͼƬ
title('Lighter'); 
pause





%%%%%%%%%%%%%%%%%% ������ �ӽǡ�ɫ�� %%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%% ����ͼ�βü����任�Լ������ͼ����ο��̲��е�ʾ����
