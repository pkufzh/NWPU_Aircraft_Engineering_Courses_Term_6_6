%����
str1 = 'I like MATLAB,';	 % �����ִ����� str1
str2 = '  JavaScript, and Perl!';	 % �����ִ�����str2
str3 = [str1  str2]	      % ֱ������str1��str2���Խ���str3

[str1 , str2]
[str1 ; str2]

 str1 = 'Let''s go.';    % �ַ���Ϊlet��s go.
 length(str1)    % �����ַ�������9
 
x = 'A';
y = double(x)    %�鿴 s �� ASCII ��
z = char(y)          %��ASCII ��ָ����ַ���
y2=num2str(y)
whos y  y2    %ע��y  y2�Ĳ�ͬ


%
clear
chinese = '�����£����ձ�';
out1 = class(chinese)      % out1 ��ֵ�� ��char��
x = chinese+1;
out2 = ischar(x)   % out2 �� 0 ���� �����ַ�������
out3 = class(x)  % out3��double���� x �����ַ���

%
clear
s = ['aa  '; 'bb  '; 'cccc']  %ע��ո�
d= char('aa', 'bb', 'cccc')
d1 = d(1,:);	              % (1,:)�����һ�е�ȫ��Ԫ��  
d2 = deblank(d1);       % ʹ�� deblank ָ�����β���Ŀո��ַ�   
length(d1)	  % ��ʾ���� d1 �ĳ���=4
length(d2)	  % ��ʾ���� d2 �ĳ���=2


%
clear
 str1 = 'today';  
 str2 = 'tomorrow';  
 str3 = 'today';  
 out1 = strcmp(str1, str2)	   % �Ƚ��ַ��� str1 �� str2 
 out2 = strcmp(str1, str3)	

%
clear
a(1,1) = {[1 4 3; 0 5 8; 7 2 9]};
a(1,2) = {'Anne Smith'};
a(2,1) = {3+7i};
a(2,2) = {-pi:pi/10:pi};
a
%a2��a����ͬ�ģ����巽ʽ����Ԫ������
a2={[1 4 3; 0 5 8; 7 2 9],'Anne Smith'; 3+7i,-pi:pi/10:pi} 

b{1,1} = 'James Bond' ;  %���巽ʽ��Ԫ����������
b{1,2} = [1 2;3 4;5 6];
b{2,1} = pi;
b{2,2} = zeros(5); 
b

c1=[a b]
c2=[a;b]

%
clear
a=cell(2,3)
a(1,3) = {1:3};
a{2,3} = 1:5;
a

%
clear
a={[1 4 3; 0 5 8; 7 2 9],'Anne Smith'; 3+7i,-pi:pi/10:pi};
a
a{2, 2} %��ʾĳԪ����������
a{:} %��ʾȫ��Ԫ������(��a��ϸ)
celldisp(a) %��ʾ��ϸ����
cellplot(a) %ͼ�η�ʽ��ʾԪ���ṹ


%
clear
b = {'James Bond',[1 2;3 4;5 6];pi,zeros(5)} 
f1=b{1, 2}
f11=b(1, 2) %f1  f11��ʲô����
whos f1 f11
f2 = b{1,2}(3,1)

a={[1 4 3; 0 5 8; 7 2 9],'Anne Smith'; 3+7i,-pi:pi/10:pi} ;
f3=a(1,:)
a(1,:) = []	 %�����  a(1,:)={[]}  , �����ʲô��


%
clear
	clear student			% ������е� student �����Է�����
	student.name = '����';		% ���� name �ֶ�
	student.id = '010012';		% ���� id�ֶ�
	student.scores = [88, 75, 90];	% ���� scores�ֶ�
	student				% ��ʾ�ṹ����������
	student(2).name = '����';	  % ���� name �ֶ�
	student(2).id = '010013';	  % ���� id�ֶ�
	student(2).scores=[68, 85, 92];  % ���� scores�ֶ�
	student				     % ��ʱ������ʾ��ϸ��Ϣ
    
    student(2)
    student(2).name

%
clear
student = struct('name' , {'����', '����'},...
                            'scores', {[70 60], [80 70]});
student(1), student(2) 

%
clear
    student = struct('name', {'����', '����'}); 
	student(1).course(1).title = 'Fluid Mechanics';
	student(1).course(1).credits = 2; 
	student(1).course(2).title = 'Structural Mechanics';
	student(1).course(2).credits = 3;
	student(2).course(1).title = 'Fluid Mechanics';
	student(2).course(1).credits = 2; 
	student(2).course(2).title = 'CFD';
	student(2).course(2).credits = 1;
	student(1).course %course����Ƕ����һ�ṹ���������ֶ�
 cat(1, student.scores)
 cat(2, student.scores)
