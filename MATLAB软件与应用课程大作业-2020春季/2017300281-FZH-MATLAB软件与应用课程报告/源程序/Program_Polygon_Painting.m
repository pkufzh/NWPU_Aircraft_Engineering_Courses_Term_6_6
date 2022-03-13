%% 利用MATLAB实现多边形凸包构造结果GUI设计
%% GUI界面初始化
function varargout = Program_Polygon_Painting(varargin)
% PROGRAM_POLYGON_PAINTING MATLAB code for Program_Polygon_Painting.fig
% Last Modified by GUIDE v2.5 10-Jun-2020 19:45:46
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Program_Polygon_Painting_OpeningFcn, ...
                   'gui_OutputFcn',  @Program_Polygon_Painting_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Program_Polygon_Painting is made visible.
function Program_Polygon_Painting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

% Choose default command line output for Program_Polygon_Painting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Program_Polygon_Painting wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Program_Polygon_Painting_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%% 核心模块实现
%% 模块0：界面清除与还原
% --- Executes on button press in Clearance_Screen.
function Clearance_Screen_Callback(hObject, eventdata, handles)
axes(handles.axes1); % 将axes1作为当前坐标轴，函数图形在当前坐标轴中绘制
cla reset;
zero=num2str(0); %转化为字符串 
set(handles.Input_Number,'String',zero); % 将Input_Number空间的string置零
set(handles.Output_Convex_Area,'String',zero); % 将Output_Convex_Area空间的string置零
guidata(hObject,handles); % 更新结构体

%% 模块1：输入随机点个数（文本框）
function Input_Number_Callback(hObject, eventdata, handles)
input=str2num(get(hObject,'String')); % 检查输入是否为空；如果为空,则默认显示为0
if (isempty(input))	
    set(hObject,'String','0')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Input_Number_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% 模块2：生成平面随机点
% --- Executes on button press in Point_Generator.
function Point_Generator_Callback(hObject, eventdata, handles)

global n x y; % 定义全局变量，方便参数传递

a=get(handles.Input_Number,'String'); % 提取输入随机点个数
n=str2num(a); % 将字符串转化为数值
x=100*rand(1,n); % 在[0,100]之内随机生成x坐标点（可修改）
y=100*rand(1,n); % 在[0,100]之内随机生成y坐标点（可修改）
% 绘制Figure 1：原始随机生成点示意图
% 绘制生成的100个随机点
axes(handles.axes1); % 将axes1作为当前坐标轴，函数图形在当前坐标轴中绘制
cla reset;
plot(x,y,'b*','MarkerSize',6);
xlabel('\itx坐标'),ylabel('\ity坐标'),title('图1：原始随机生成点示意图');
grid on
box on

%% 模块3：绘制凸包点集
% --- Executes on button press in Display_Convex_Enveloping_Points.
function Display_Convex_Enveloping_Points_Callback(hObject, eventdata, handles)
% 寻找凸包核心算法设计
% 设置凸包点集标志，1为满足条件点，0为非满足条件点

global n x y cnt pp; % 定义全局变量

p_flag=zeros(1,n);
xmax=10000;
% 寻找最小x坐标点，此点必定是凸包点，以此点作为凸包起点
for i=1:n
    if (x(i)<xmax) && (p_flag(i)==0)
        pj=i; % 记录最小x坐标点的点序号
        xmax=x(i); % 更新最小的xmax值
    end
end
p_flag(pj)=1;

flag_1=0; % 设置搜索停止判断标志：从起点开始搜索下一个点，判断是否已经找到凸包，程序退出标志为下一个点是起点
st=pj; % 起点编号
cnt=1; % 记录凸包点数，初始状态已有一个点加入
pp=zeros(1,n); % pp数组记录按顺序排列（顺时针或逆时针）的凸包点集，方便后续画图
pp(1)=pj; % 设置最小x坐标点为第一个凸包点（起点）

while (flag_1~=1)  % 若不满足退出条件，则进行while循环
    
    % 提取起点的x,y坐标为(x1,y1)
    x1=x(st);
    y1=y(st);
    
    % 设置i变量遍历所有点坐标,寻找下一个在凸包内的点
    for i=1:n
        
        if (i~=st) % 如果下一个点不在凸包内   
            % 两点构造直线，提取当前点的x,y坐标为(x2,y2)
            x2=x(i);
            y2=y(i);
            % 直线方程已化简为Ax+By+C=0的形式
            A=(y2-y1);
            B=(x1-x2);
            C=((x2-x1)*y1-(y2-y1)*x1);
            
            tot=1; % 关键点1：tot用以判断是否该直线为凸包边线
                   % 由于将在落在直线两边的点坐标代入直线方程后，Ax+By+C的值异号
                   % 利用该特点，设置累乘器tot，逐次代入这些点坐标，只要检索到tot<=0，则可排除该点为凸包点；
                   % 若其他98个点依次代入后tot始终为正，则该点为凸包点，标志为flag_2=1
             
            flag_2=1; % 判断i编号点是否为凸包点的标志
            for j=1:n % 遍历所有点集检验是否满足凸包条件
                if (j~=st) && (j~=i) % 排除构造直线的两个点，因为其使得Ax+By+C=0将使tot=0，无法判断结果
                    xj=x(j);
                    yj=y(j);
                    t=(A*xj)+(B*yj)+C;
                        % t=t*100;
                        % 考虑由于tot每次乘的量若很小的情况，或者结果非常接近0的情况时，可乘以一个放大系数（可选择）
                    tot=tot*t;
                    if (tot<=0)
                        flag_2=0;
                        break;  % 剪枝操作，提高程序效率
                    end
                end
            end
            
             % 若成功，即找到凸包点
            if (flag_2==1)
                en=i; % 记录当前点编号
                p_flag(en)=1; % 标记该点已经进入凸包集合
                cnt=cnt+1; % 凸包点个数加1
                pp(cnt)=en;
                st=en; % 关键点2：将找到的新的下一个凸包点作为新的起点，循环再寻找下一个凸包点
                if (en==pj) % 关键点3：凸包封闭标志，也即程序退出标志为：寻找到的新的凸包点回到了起点
                    flag_1=1;  % 完成凸包封闭操作，flag_1置1，退出整个迭代程序
                    break;
                end
            end
            
        end
        
    end % 结束i（编号）循环
end % 结束while循环

% 绘制Figure 2：封闭凸包点示意图
% 完成凸包求解，记录各凸包点的x,y坐标（无序）——显示凸包点
ppx=zeros(1,cnt-1); % 各凸包点x坐标（无序）
ppy=zeros(1,cnt-1); % 各凸包点y坐标（无序）
cntt=0;
for k=1:n
    if (p_flag(k)==1) % 若该点为凸包点
        cntt=cntt+1;
        ppx(cntt)=x(k);
        ppy(cntt)=y(k);
    end
end

% 设置绘图坐标轴
axes(handles.axes1); % 将axes1作为当前坐标轴，函数图形在当前坐标轴中绘制
cla reset;
hold on
% 绘制生成的100个随机点
plot(x,y,'b*','MarkerSize',6);
% 绘制凸包点集
plot(ppx,ppy,'r.','MarkerSize',16);
hold off
% 添加图例、坐标信息
legend('原始随机生成点','构成凸包点');
xlabel('\itx坐标'),ylabel('\ity坐标'),title('图2：封闭凸包点示意图');
grid on
box on

%% 模块4：绘制凸包边线
% --- Executes on button press in Display_Convex_Enveloping_Boundary.
function Display_Convex_Enveloping_Boundary_Callback(hObject, eventdata, handles)

global n x y cnt pp; % 定义全局变量

p_flag=zeros(1,n);
xmax=10000;
% 寻找最小x坐标点，此点必定是凸包点，以此点作为凸包起点
for i=1:n
    if (x(i)<xmax) && (p_flag(i)==0)
        pj=i; % 记录最小x坐标点的点序号
        xmax=x(i); % 更新最小的xmax值
    end
end
p_flag(pj)=1;

flag_1=0; % 设置搜索停止判断标志：从起点开始搜索下一个点，判断是否已经找到凸包，程序退出标志为下一个点是起点
st=pj; % 起点编号
cnt=1; % 记录凸包点数，初始状态已有一个点加入
pp=zeros(1,n); % pp数组记录按顺序排列（顺时针或逆时针）的凸包点集，方便后续画图
pp(1)=pj; % 设置最小x坐标点为第一个凸包点（起点）

while (flag_1~=1)  % 若不满足退出条件，则进行while循环
    
    % 提取起点的x,y坐标为(x1,y1)
    x1=x(st);
    y1=y(st);
    
    % 设置i变量遍历所有点坐标,寻找下一个在凸包内的点
    for i=1:n
        
        if (i~=st) % 如果下一个点不在凸包内   
            % 两点构造直线，提取当前点的x,y坐标为(x2,y2)
            x2=x(i);
            y2=y(i);
            % 直线方程已化简为Ax+By+C=0的形式
            A=(y2-y1);
            B=(x1-x2);
            C=((x2-x1)*y1-(y2-y1)*x1);
            
            tot=1; % 关键点1：tot用以判断是否该直线为凸包边线
                   % 由于将在落在直线两边的点坐标代入直线方程后，Ax+By+C的值异号
                   % 利用该特点，设置累乘器tot，逐次代入这些点坐标，只要检索到tot<=0，则可排除该点为凸包点；
                   % 若其他98个点依次代入后tot始终为正，则该点为凸包点，标志为flag_2=1
             
            flag_2=1; % 判断i编号点是否为凸包点的标志
            for j=1:n % 遍历所有点集检验是否满足凸包条件
                if (j~=st) && (j~=i) % 排除构造直线的两个点，因为其使得Ax+By+C=0将使tot=0，无法判断结果
                    xj=x(j);
                    yj=y(j);
                    t=(A*xj)+(B*yj)+C;
                        % t=t*100;
                        % 考虑由于tot每次乘的量若很小的情况，或者结果非常接近0的情况时，可乘以一个放大系数（可选择）
                    tot=tot*t;
                    if (tot<=0)
                        flag_2=0;
                        break;  % 剪枝操作，提高程序效率
                    end
                end
            end
            
             % 若成功，即找到凸包点
            if (flag_2==1)
                en=i; % 记录当前点编号
                p_flag(en)=1; % 标记该点已经进入凸包集合
                cnt=cnt+1; % 凸包点个数加1
                pp(cnt)=en;
                st=en; % 关键点2：将找到的新的下一个凸包点作为新的起点，循环再寻找下一个凸包点
                if (en==pj) % 关键点3：凸包封闭标志，也即程序退出标志为：寻找到的新的凸包点回到了起点
                    flag_1=1;  % 完成凸包封闭操作，flag_1置1，退出整个迭代程序
                    break;
                end
            end
            
        end
        
    end % 结束i（编号）循环
end % 结束while循环

% 绘制Figure 3：封闭凸包轮廓示意图
% 完成凸包求解，记录各凸包点的x,y坐标（按照顺时针或逆时针方向）
ptx=zeros(1,cnt);
pty=zeros(1,cnt);
for i=1:cnt
    ptx(i)=x(pp(i));
    pty(i)=y(pp(i));
end

% 设置绘图坐标轴
axes(handles.axes1); % 将axes1作为当前坐标轴，函数图形在当前坐标轴中绘制
cla reset;
hold on
plot(x,y,'b*','MarkerSize',6);
plot(ptx,pty,'r-','LineWidth',2);
hold off
legend('原始随机生成点','凸包轮廓线');
xlabel('\itx坐标'),ylabel('\ity坐标'),title('图3：封闭凸包轮廓示意图');
grid on
box on

%% 模块5：计算凸包面积
% --- Executes on button press in Calculation_Convex_Area.
function Calculation_Convex_Area_Callback(hObject, eventdata, handles)

global x y cnt pp; % 定义全局变量

S=0; % 记录凸包面积
x11=x(pp(1)); % 以第一个点为三角形公共顶点
y11=y(pp(1));
for k=2:(cnt-2)
    x22=x(pp(k));
    y22=y(pp(k));
    x33=x(pp(k+1));
    y33=y(pp(k+1));
    % 两点之间距离公式
    a=sqrt((x11-x22)*(x11-x22)+(y11-y22)*(y11-y22));
    b=sqrt((x11-x33)*(x11-x33)+(y11-y33)*(y11-y33));
    c=sqrt((x22-x33)*(x22-x33)+(y22-y33)*(y22-y33));
    p=(a+b+c)/2; % 计算三角形半周长
    dS=sqrt(p*(p-a)*(p-b)*(p-c)); % 利用海伦-秦九韶公式计算三角形面积
    S=dS+S;
end

c=num2str(S); %转化为字符串 
set(handles.Output_Convex_Area,'String',c); % 保存结构体，将结果赋值给Output_Convex_Area空间的string属性，显示结果
guidata(hObject,handles); % 更新结构体

%% 模块6：输出凸包面积（文本框）
function Output_Convex_Area_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Output_Convex_Area_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
