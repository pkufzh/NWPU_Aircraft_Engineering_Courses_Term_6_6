%���ű�������
clc,clear,close all
disp('������ű���')
syms a;  % a����Ϊ���ű���
syms b  c;  % b c ����Ϊ���ű���'
f=sym('a*b+2/3*y^2'); % f����Ϊ���ű���������ֵΪ
e=f - a*b % eͨ�����ʽ��ֵ����Ϊ���ű���,ֵΪ(2*y^2)/3

pause
A=sym('aa') %������������ֵ��ͬ
A=sym('bb')

pause
clc,clear,close all
disp('������ű���  ����ʾ��')
try
x=sym x;  x=sym 'x';  syms x,y,z;
catch
    disp('�����Ǵ���ʾ')
end

pause
clear
sym a  %�������У���Ҳ��������ģ�����һ�µõ�ʲô? �����˱���a ?  ��whos��һ��
whos
sym(a)
whos

pause
clc,clear,close all
a=sin(pi/4)      % sin(pi/4)Ϊ��ֵ����
b=sym('sin(pi/4)')   % ����sin(pi/4)Ϊ���ų���


pause
clc,clear,close all
disp('������ű���  sym')
f= sym('sin(x)^2+ cos(x)^2')                   
A=0.25 
sym(A)   %�����1/4
sym('A')  %�����A
A='1/5'   %A���ַ���
A=sym('1/8')
sym('sqrt(3)') 
sym(sqrt(3))

%��sym�����������ű��ʽ��
f1=sym('a*x^2+b*x+c'); 
solve(f1)
%ʹ���Ѿ�����ķ��ű�����ɷ��ű��ʽ��
syms  x  y  a  b  c
f2=a*x^2+b*x+c  %���ӵ�����
solve(f2)
%????   
f3='a*x^2+b*x+c'    %f���ַ�������
solve(f3)

      	sym('x', 'real')
        sym('y', 'real')
        syms x y 'real'
        conj(x)
        sym('x', 'unreal')
        conj(x)

		sym(1/3,'f')
		sym(1/3,'e')
		sym(1/3,'r')
		sym(1/3,'d')
        
pause
clc,clear,close all
disp('Ĭ�ϱ���')
syms a b c x y t i j
sin(a*x+b*y),subs(ans,1)
a*x^2+b*x+c,subs(ans,1)
1/(4+cos(t)),subs(ans,1)
4*x/y,subs(ans,1)
2*a+b,subs(ans,1)
2*i+4*j,subs(ans,1)

pause
clc,clear,close all
disp('�Զ���ȡĬ���Ա���')
f=sym('sin(a*x+b*y)'); findsym(f)
f=sym('sin(a*x+b*y)'); findsym(f,1)
f=sym('sin(a*x+b*y)'); findsym(f,2)

pause
clc,clear,close all
disp('���š����ž���Ļ�������')
syms a b c x y z v w
f=(a*x+b*y-c*z)/2*v*w^2
A=[a,b;2*a,-b]*[2*x,b;2*a,-3*c]
inv(A)
det(A)
p=[1,2,3], s=poly2sym(p)  %����ʽ/���ű��ʽ��ת��
expand(s*s), sym2poly(s*s)


%������ֵ������������������㣩�� �󲿷���ֵ���㺯��Ҳ�����ڷ������㡣
syms a b c d
m1=[a,b]; m2=[c,d]
x=m1+m2
y=[m1;m2]
z1=y.^2
z2=y^2
inv(z1)
det(z2)




pause
clc,clear,close all
disp('���ų������㺯��numden')
f1=sym('1/(a-b)')
f2=sym('2*a/(a+b)')
[n,d]=numden(f1+f2)    %n/d����f1+f2

pause
clc,clear,close all
disp('���ų������㺯��collect')
f=sym('x^2*y+y*x-x^2-2*x')
collect(f) 
syms x y;
collect(x^2*y+y*x-x^2-2*x)

pause
clc,clear,close all
disp('���ų������㺯��expand')
f=sym('(x-2)*(x-4)'); 
expand(f)   %�����x^2 - 6*x + 8
%expand((x-2)*(x-4))�Ƿ����

pause
clc,clear,close all
disp('���ų������㺯��factor')
syms x
factor(x^3-6*x^2+11*x-6)

pause
clc,clear,close all
disp('���ų������㺯��horner')
syms x;
horner(x^3-6*x^2+11*x-6)

pause
clc,clear,close all
disp('���ų������㺯��simplify')
syms x
simplify(sin(x)^2 + cos(x)^2)   %���Ϊ1
simplify((x^2+5*x+6)/(x+2))  %���x+3
%simplify(sqrt(16))  %�������У���Ϊsqrt(16)ϵͳĬ��Ϊ��ֵ
f0=simplify(sqrt(sym('16')))  %�������Ϊ4��sqrt( sym('16') )����Ϊ������
f1=sqrt(sym(16))
f2=sqrt(sym('16'))
f3=sqrt(16)
f4=sym(16)
f5=sqrt(f3)
f6=sqrt(f4)
whos    %��whos �ɲ鿴���϶������������

pause
clc,clear,close all
disp('���ų������㺯��simple')
syms x
f=2*cos(x)^2-sin(x)^2;
simple(f)
[r,how]=simple(f) 

pause
clc,clear,close all
disp('���ŷ���')
f1=sym('a*x^2+b*x=-c'); %���ŷ���
syms x y a b c
f2=a*x^2+b*x+c
f3='a*x^2+b*x+c'    %�Ա�f1 f2 f3 f4
f4='a*x^2+b*x+c=0'   %���ŷ���
s1=solve(f1)
s2=solve(f2)
s3=solve(f3)%�Ա�s1 s2 s3 s4
s4=solve(f4)
subs(s3,a,1)
s5=subs(subs(subs(s3,a,1),b,1),c,1)

pause
clc,clear,close all
disp('���ž��� ���ŷ�����1')
syms a b1 b2
b1=a
b2=3*a
b=[b1;b2]
A=[2,-1;2,1]
x=A\b   %��������������ֵ�ͷ�������

pause
clc,clear,close all
disp('���ŷ�����2')
f1=sym('x+y+z-10*a');
f2=sym('x-y+z');
f3=sym('2*x-y-z+4*a');
solve(f1,f2,f3);
[x,y,z]=solve(f1,f2,f3) %���鲻Ҫʡ������б�
s=[x,y,z]
subs(s,'a',1) %ͨ�����Ŵ���ɵõ���2,5,3

pause
clc,clear,close all
disp('subs���÷�')
syms a b
subs(a+b,a,4)      

pause
f=sym('a+b')
subs(f,'a',4)       % 'a'�ĳ�a��������
subs('a+b+c','a',4) % 'a'�ĳ�a��������
syms a
subs(f,a,4)      % a������Ϊ���ű����󣬿�������
subs('a+b+c',a,4)% a������Ϊ���ű����󣬿�������


pause
clc,clear,close all
disp('����-��ֵ��ת��')

s=solve('3*x^2+2*x-6=0')
f1=vpa(s) %�۲�f1 f2
f2=vpa(s,6)

syms x;
y=x-cos(x);
z1=subs(y,x,'pi')   %�۲�z1 z2
digits(15)
z2=vpa(z1)

pause
clc,clear,close all
disp('���ų������㺯��  �ϼ� symsum')
syms k n;
f1=symsum(k)
f2=symsum(k^2,0,n)
f3=subs(f2,n,10)
f4=symsum(k^2,0,10)  %f3 f4Ӧ�����



pause
clc,clear,close all
disp('�ݶȺ���   ����f(x,y)���ݶ�')
[x,y]=meshgrid(-2:0.1:2);
f=x.*exp(-x.^2-y.^2);
subplot(1,2,1);
surfc(x,y,f);title('����');%������ά�����ͶӰ�͵ȸ���ͼ
xlabel('x');ylabel('y');zlabel('f');
subplot(1,2,2);
contourf(x,y,f);title('�ȸ��ߺ��ݶ�');hold;%��������͵ȸ���ͼ
[dx,dy]=gradient(f,0.1,0.1);%�����ݶ�
quiver(x,y,dx,dy)    %������͵ȸ���ͼ�ϵ����ݶ�ʸ��ͼ


pause
clc,clear,close all
disp('diff ΢��  ,��diff�����ݶȣ�����gradient������ͼ')
syms x y a b c
f=sym('x*exp(-x^2-y^2)')
dx= diff(f,x,1)
dy= diff(f,y,1)
[x1,y1]=meshgrid(-2:0.1:2);
dx1=vpa(subs(dx,{x,y},{x1,y1}))
dy1=vpa(subs(dy,{x,y},{x1,y1}))
quiver(x1,y1,dx1,dy1)    %�ݶ�ʸ��ͼ 
