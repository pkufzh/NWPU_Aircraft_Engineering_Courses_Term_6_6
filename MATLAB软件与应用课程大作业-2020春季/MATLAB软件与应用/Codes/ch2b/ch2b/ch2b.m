%基础
str1 = 'I like MATLAB,';	 % 建立字串变量 str1
str2 = '  JavaScript, and Perl!';	 % 建立字串变量str2
str3 = [str1  str2]	      % 直接连接str1及str2，以建立str3

[str1 , str2]
[str1 ; str2]

 str1 = 'Let''s go.';    % 字符串为let’s go.
 length(str1)    % 计算字符串长度9
 
x = 'A';
y = double(x)    %查看 s 的 ASCII 码
z = char(y)          %将ASCII 码恢复成字符串
y2=num2str(y)
whos y  y2    %注意y  y2的不同


%
clear
chinese = '今日事，今日毕';
out1 = class(chinese)      % out1 的值是 “char”
x = chinese+1;
out2 = ischar(x)   % out2 是 0 代表 不是字符串变量
out3 = class(x)  % out3是double代表 x 不是字符串

%
clear
s = ['aa  '; 'bb  '; 'cccc']  %注意空格
d= char('aa', 'bb', 'cccc')
d1 = d(1,:);	              % (1,:)代表第一行的全部元素  
d2 = deblank(d1);       % 使用 deblank 指令清除尾部的空格字符   
length(d1)	  % 显示变量 d1 的长度=4
length(d2)	  % 显示变量 d2 的长度=2


%
clear
 str1 = 'today';  
 str2 = 'tomorrow';  
 str3 = 'today';  
 out1 = strcmp(str1, str2)	   % 比较字符串 str1 和 str2 
 out2 = strcmp(str1, str3)	

%
clear
a(1,1) = {[1 4 3; 0 5 8; 7 2 9]};
a(1,2) = {'Anne Smith'};
a(2,1) = {3+7i};
a(2,2) = {-pi:pi/10:pi};
a
%a2与a是相同的，定义方式都是元胞索引
a2={[1 4 3; 0 5 8; 7 2 9],'Anne Smith'; 3+7i,-pi:pi/10:pi} 

b{1,1} = 'James Bond' ;  %定义方式是元胞内容索引
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
a{2, 2} %显示某元胞具体内容
a{:} %显示全部元胞内容(比a详细)
celldisp(a) %显示详细内容
cellplot(a) %图形方式显示元胞结构


%
clear
b = {'James Bond',[1 2;3 4;5 6];pi,zeros(5)} 
f1=b{1, 2}
f11=b(1, 2) %f1  f11有什么区别
whos f1 f11
f2 = b{1,2}(3,1)

a={[1 4 3; 0 5 8; 7 2 9],'Anne Smith'; 3+7i,-pi:pi/10:pi} ;
f3=a(1,:)
a(1,:) = []	 %如果是  a(1,:)={[]}  , 结果是什么？


%
clear
	clear student			% 清除现有的 student 变量以防干扰
	student.name = '张三';		% 加入 name 字段
	student.id = '010012';		% 加入 id字段
	student.scores = [88, 75, 90];	% 加入 scores字段
	student				% 显示结构变量的数据
	student(2).name = '李四';	  % 加入 name 字段
	student(2).id = '010013';	  % 加入 id字段
	student(2).scores=[68, 85, 92];  % 加入 scores字段
	student				     % 此时不再显示详细信息
    
    student(2)
    student(2).name

%
clear
student = struct('name' , {'张三', '李四'},...
                            'scores', {[70 60], [80 70]});
student(1), student(2) 

%
clear
    student = struct('name', {'张三', '李四'}); 
	student(1).course(1).title = 'Fluid Mechanics';
	student(1).course(1).credits = 2; 
	student(1).course(2).title = 'Structural Mechanics';
	student(1).course(2).credits = 3;
	student(2).course(1).title = 'Fluid Mechanics';
	student(2).course(1).credits = 2; 
	student(2).course(2).title = 'CFD';
	student(2).course(2).credits = 1;
	student(1).course %course是内嵌的另一结构，含两个字段
 cat(1, student.scores)
 cat(2, student.scores)
