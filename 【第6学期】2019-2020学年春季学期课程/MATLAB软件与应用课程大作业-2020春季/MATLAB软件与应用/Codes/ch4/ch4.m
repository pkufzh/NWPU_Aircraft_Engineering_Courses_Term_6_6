% if ,error and warning
r=input('������뾶') %�������� 0��-1��10�鿴���н��
if r==0
  warning('�뾶Ϊ�㣬����С��Բ')  %��ʾ����������
elseif r<0
  error('�뾶Ϊ�����޷�����')   %��ʾ����ֹ����
end
c=2*pi*r;
disp('�ܳ�Ϊ')
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

%switch,error,warning  �����ۿ���
clear;close all;
price=input('��������Ʒ�۸�:')
if price<=0
    warning('�۸�Ӧ����0');
    price=input('�ٸ��λ��ᣬ��������Ʒ�۸�:')
end
if price<=0
    error('���⵷���ǰ�');
end
switch  fix(price/100)   %��fix���Ƶĺ�������floor��ceil
    case {0,1}          %��Ʒ�۸�С��200
        rate=0;
    case{2,3,4}         %��Ʒ�۸����200С��500
        rate=3/100;
    case num2cell(5:9)   %��Ʒ�۸����500С��1000
        rate=5/100;
    case num2cell(10:24)   %��Ʒ�۸����1000С��2500
        rate=8/100;
    case num2cell(25:49)   %��Ʒ�۸����2500С��5000
        rate=10/100;       
    otherwise               %��Ʒ�۸���ڵ���5000
        rate=14/100;
end
fprintf('�ۿ���=%f', rate*100),disp('%')   %����ۿ���


%1~100��������� for
s=0;
for n=1:2:100;
    s=s+n;
end
s

%1~100��������� while
s=0;
n=1;
while n<=100
    s=s+n;
    n=n+2;
end
s

%while , input�Ӽ����������ɸ�����������0ʱ�������㣬������Щ����ƽ��ֵ�Լ����ǵĺ͡�
clear,clc,close
s=0;
n=0;
x=input('����һ����(��0����):');
while(x~=0)
    s=s+x;
    n=n+1;
    x=input ('����һ����(��0����):');
end
if (n>0)
    s
    mean=s/n
end 

%���103��120֮��ĵ�һ���ܱ�7���������� continue
clear,clc,close
for n=103:120
   if rem(n,7)~=0
      continue %��������
      disp('b') %b�Ӳ���ʾ����
   end
   disp('a')
   break %�õ���һ��������ֹ
end

%���103��120֮��ĵ�һ���ܱ�7���������� break
clear,clc,close
for n=103:120
   if rem(n,7)==0
       break %������
   end
   disp('a')
end
n


%��������
fx=inline('sin(x).*y','x','y'); %��x���͡�y��ָ���˺������Ա���
x=[0:0.1:2*pi]; 
y(1:31)=0.5; y(32:63)=-1;
f1=fx(x,y);
plot(x,f1,'rx-',x,y,'go ')
legend('f1','y')



%��������
m=1000; f=@(a,b)a.^2+b.^2+m; %�������������Ա���a��b������
                                   %���ж���������ݣ����� m
x=-4:0.5:4; y=x;
[x,y]=meshgrid(x,y); 
z=f(x,y); %�Ա���
surf(x,y,z); 
%������������
close,clear
f=@(x,y)@(a)x.^2+y.^a;
f1=f(2,3), f2=f1(4)








%----------------��������---------------



%2d���߻�ͼplot  �ֶκ���
clc,clear,disp('2d���߻�ͼplot  �ֶκ��� ������ñȽ�������߼�����')
tic %��ʱ��ʼ
x=-6:0.1:6;
y=(x<=0).*sin(x)+(x>=0&x<=3).*x+(x>3).*(-x+6);
plot(x,y),grid on
toc %��ʾ��ʱʱ��



%�Զ��庯�� mysub2ind , ����������matlab�Դ�����sub2ind
clc,clear
a=1:3       %aΪ������
a=[a;a+3] %a��Ϊ2��3��
a=[a;a+6] %a��Ϊ4��3��
a(:,:,2)= -a %a��Ϊ4��3��2�㣬 ��/��/���Ӧ��1/2/3ά
disp('here is 4*3*3 array')
a(:,:,3)= -a(:,:,1)*10 %a��Ϊ4*3*3
index=[3,2,3] %������Ҫת��������Ϊ3,2,3
% ����matlab����Ĵ洢�������ȱ�����ά��
% ��2ά�����У����ǰ������洢���ȴ��һ�У��ٴ�ڶ��У���ÿ�е�ʱ�򣬴�ǰ����������У���������ǽϵ�ά
% 3*4*5*6�����У����ά��3�У����ά��6 whatever. (�С��С���֮��ʵ����������)
% �������Ϲ���4*3*3��a����ȫ����3,2,3��Ӧ������ӦΪ  (3��-1��)*(4��*3��)+(2��-1��)(4��)+3��=31

mysub2ind(a,index)  %��mysub2ind.m
sub2ind(size(a),3,2,3)

%�����ӵ�����
b=a
b(:,:,:,2)=  2*a
b(:,:,:,3)= -2*a
b(:,:,:,4)= -3*a
b(:,:,:,5)=  7*a %b��Ϊ4*3*3*5
index=[3,2,3,5]
%4*3*3*5��b����ȫ����3,2,3,5��Ӧ������ӦΪ
%(5-1)*(4*3*3)+(3��-1��)*(4��*3��)+(2��-1��)(4��)+3��=175
mysub2ind(b,index)  %��mysub2ind.m
sub2ind(size(b),3,2,3,5)