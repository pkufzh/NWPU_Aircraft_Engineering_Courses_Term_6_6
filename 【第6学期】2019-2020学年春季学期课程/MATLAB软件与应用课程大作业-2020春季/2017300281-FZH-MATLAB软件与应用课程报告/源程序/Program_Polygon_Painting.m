%% ����MATLABʵ�ֶ����͹��������GUI���
%% GUI�����ʼ��
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

%% ����ģ��ʵ��
%% ģ��0����������뻹ԭ
% --- Executes on button press in Clearance_Screen.
function Clearance_Screen_Callback(hObject, eventdata, handles)
axes(handles.axes1); % ��axes1��Ϊ��ǰ�����ᣬ����ͼ���ڵ�ǰ�������л���
cla reset;
zero=num2str(0); %ת��Ϊ�ַ��� 
set(handles.Input_Number,'String',zero); % ��Input_Number�ռ��string����
set(handles.Output_Convex_Area,'String',zero); % ��Output_Convex_Area�ռ��string����
guidata(hObject,handles); % ���½ṹ��

%% ģ��1�����������������ı���
function Input_Number_Callback(hObject, eventdata, handles)
input=str2num(get(hObject,'String')); % ��������Ƿ�Ϊ�գ����Ϊ��,��Ĭ����ʾΪ0
if (isempty(input))	
    set(hObject,'String','0')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Input_Number_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% ģ��2������ƽ�������
% --- Executes on button press in Point_Generator.
function Point_Generator_Callback(hObject, eventdata, handles)

global n x y; % ����ȫ�ֱ����������������

a=get(handles.Input_Number,'String'); % ��ȡ������������
n=str2num(a); % ���ַ���ת��Ϊ��ֵ
x=100*rand(1,n); % ��[0,100]֮���������x����㣨���޸ģ�
y=100*rand(1,n); % ��[0,100]֮���������y����㣨���޸ģ�
% ����Figure 1��ԭʼ������ɵ�ʾ��ͼ
% �������ɵ�100�������
axes(handles.axes1); % ��axes1��Ϊ��ǰ�����ᣬ����ͼ���ڵ�ǰ�������л���
cla reset;
plot(x,y,'b*','MarkerSize',6);
xlabel('\itx����'),ylabel('\ity����'),title('ͼ1��ԭʼ������ɵ�ʾ��ͼ');
grid on
box on

%% ģ��3������͹���㼯
% --- Executes on button press in Display_Convex_Enveloping_Points.
function Display_Convex_Enveloping_Points_Callback(hObject, eventdata, handles)
% Ѱ��͹�������㷨���
% ����͹���㼯��־��1Ϊ���������㣬0Ϊ������������

global n x y cnt pp; % ����ȫ�ֱ���

p_flag=zeros(1,n);
xmax=10000;
% Ѱ����Сx����㣬�˵�ض���͹���㣬�Դ˵���Ϊ͹�����
for i=1:n
    if (x(i)<xmax) && (p_flag(i)==0)
        pj=i; % ��¼��Сx�����ĵ����
        xmax=x(i); % ������С��xmaxֵ
    end
end
p_flag(pj)=1;

flag_1=0; % ��������ֹͣ�жϱ�־������㿪ʼ������һ���㣬�ж��Ƿ��Ѿ��ҵ�͹���������˳���־Ϊ��һ���������
st=pj; % �����
cnt=1; % ��¼͹����������ʼ״̬����һ�������
pp=zeros(1,n); % pp�����¼��˳�����У�˳ʱ�����ʱ�룩��͹���㼯�����������ͼ
pp(1)=pj; % ������Сx�����Ϊ��һ��͹���㣨��㣩

while (flag_1~=1)  % ���������˳������������whileѭ��
    
    % ��ȡ����x,y����Ϊ(x1,y1)
    x1=x(st);
    y1=y(st);
    
    % ����i�����������е�����,Ѱ����һ����͹���ڵĵ�
    for i=1:n
        
        if (i~=st) % �����һ���㲻��͹����   
            % ���㹹��ֱ�ߣ���ȡ��ǰ���x,y����Ϊ(x2,y2)
            x2=x(i);
            y2=y(i);
            % ֱ�߷����ѻ���ΪAx+By+C=0����ʽ
            A=(y2-y1);
            B=(x1-x2);
            C=((x2-x1)*y1-(y2-y1)*x1);
            
            tot=1; % �ؼ���1��tot�����ж��Ƿ��ֱ��Ϊ͹������
                   % ���ڽ�������ֱ�����ߵĵ��������ֱ�߷��̺�Ax+By+C��ֵ���
                   % ���ø��ص㣬�����۳���tot����δ�����Щ�����ֻ꣬Ҫ������tot<=0������ų��õ�Ϊ͹���㣻
                   % ������98�������δ����totʼ��Ϊ������õ�Ϊ͹���㣬��־Ϊflag_2=1
             
            flag_2=1; % �ж�i��ŵ��Ƿ�Ϊ͹����ı�־
            for j=1:n % �������е㼯�����Ƿ�����͹������
                if (j~=st) && (j~=i) % �ų�����ֱ�ߵ������㣬��Ϊ��ʹ��Ax+By+C=0��ʹtot=0���޷��жϽ��
                    xj=x(j);
                    yj=y(j);
                    t=(A*xj)+(B*yj)+C;
                        % t=t*100;
                        % ��������totÿ�γ˵�������С����������߽���ǳ��ӽ�0�����ʱ���ɳ���һ���Ŵ�ϵ������ѡ��
                    tot=tot*t;
                    if (tot<=0)
                        flag_2=0;
                        break;  % ��֦��������߳���Ч��
                    end
                end
            end
            
             % ���ɹ������ҵ�͹����
            if (flag_2==1)
                en=i; % ��¼��ǰ����
                p_flag(en)=1; % ��Ǹõ��Ѿ�����͹������
                cnt=cnt+1; % ͹���������1
                pp(cnt)=en;
                st=en; % �ؼ���2�����ҵ����µ���һ��͹������Ϊ�µ���㣬ѭ����Ѱ����һ��͹����
                if (en==pj) % �ؼ���3��͹����ձ�־��Ҳ�������˳���־Ϊ��Ѱ�ҵ����µ�͹����ص������
                    flag_1=1;  % ���͹����ղ�����flag_1��1���˳�������������
                    break;
                end
            end
            
        end
        
    end % ����i����ţ�ѭ��
end % ����whileѭ��

% ����Figure 2�����͹����ʾ��ͼ
% ���͹����⣬��¼��͹�����x,y���꣨���򣩡�����ʾ͹����
ppx=zeros(1,cnt-1); % ��͹����x���꣨����
ppy=zeros(1,cnt-1); % ��͹����y���꣨����
cntt=0;
for k=1:n
    if (p_flag(k)==1) % ���õ�Ϊ͹����
        cntt=cntt+1;
        ppx(cntt)=x(k);
        ppy(cntt)=y(k);
    end
end

% ���û�ͼ������
axes(handles.axes1); % ��axes1��Ϊ��ǰ�����ᣬ����ͼ���ڵ�ǰ�������л���
cla reset;
hold on
% �������ɵ�100�������
plot(x,y,'b*','MarkerSize',6);
% ����͹���㼯
plot(ppx,ppy,'r.','MarkerSize',16);
hold off
% ���ͼ����������Ϣ
legend('ԭʼ������ɵ�','����͹����');
xlabel('\itx����'),ylabel('\ity����'),title('ͼ2�����͹����ʾ��ͼ');
grid on
box on

%% ģ��4������͹������
% --- Executes on button press in Display_Convex_Enveloping_Boundary.
function Display_Convex_Enveloping_Boundary_Callback(hObject, eventdata, handles)

global n x y cnt pp; % ����ȫ�ֱ���

p_flag=zeros(1,n);
xmax=10000;
% Ѱ����Сx����㣬�˵�ض���͹���㣬�Դ˵���Ϊ͹�����
for i=1:n
    if (x(i)<xmax) && (p_flag(i)==0)
        pj=i; % ��¼��Сx�����ĵ����
        xmax=x(i); % ������С��xmaxֵ
    end
end
p_flag(pj)=1;

flag_1=0; % ��������ֹͣ�жϱ�־������㿪ʼ������һ���㣬�ж��Ƿ��Ѿ��ҵ�͹���������˳���־Ϊ��һ���������
st=pj; % �����
cnt=1; % ��¼͹����������ʼ״̬����һ�������
pp=zeros(1,n); % pp�����¼��˳�����У�˳ʱ�����ʱ�룩��͹���㼯�����������ͼ
pp(1)=pj; % ������Сx�����Ϊ��һ��͹���㣨��㣩

while (flag_1~=1)  % ���������˳������������whileѭ��
    
    % ��ȡ����x,y����Ϊ(x1,y1)
    x1=x(st);
    y1=y(st);
    
    % ����i�����������е�����,Ѱ����һ����͹���ڵĵ�
    for i=1:n
        
        if (i~=st) % �����һ���㲻��͹����   
            % ���㹹��ֱ�ߣ���ȡ��ǰ���x,y����Ϊ(x2,y2)
            x2=x(i);
            y2=y(i);
            % ֱ�߷����ѻ���ΪAx+By+C=0����ʽ
            A=(y2-y1);
            B=(x1-x2);
            C=((x2-x1)*y1-(y2-y1)*x1);
            
            tot=1; % �ؼ���1��tot�����ж��Ƿ��ֱ��Ϊ͹������
                   % ���ڽ�������ֱ�����ߵĵ��������ֱ�߷��̺�Ax+By+C��ֵ���
                   % ���ø��ص㣬�����۳���tot����δ�����Щ�����ֻ꣬Ҫ������tot<=0������ų��õ�Ϊ͹���㣻
                   % ������98�������δ����totʼ��Ϊ������õ�Ϊ͹���㣬��־Ϊflag_2=1
             
            flag_2=1; % �ж�i��ŵ��Ƿ�Ϊ͹����ı�־
            for j=1:n % �������е㼯�����Ƿ�����͹������
                if (j~=st) && (j~=i) % �ų�����ֱ�ߵ������㣬��Ϊ��ʹ��Ax+By+C=0��ʹtot=0���޷��жϽ��
                    xj=x(j);
                    yj=y(j);
                    t=(A*xj)+(B*yj)+C;
                        % t=t*100;
                        % ��������totÿ�γ˵�������С����������߽���ǳ��ӽ�0�����ʱ���ɳ���һ���Ŵ�ϵ������ѡ��
                    tot=tot*t;
                    if (tot<=0)
                        flag_2=0;
                        break;  % ��֦��������߳���Ч��
                    end
                end
            end
            
             % ���ɹ������ҵ�͹����
            if (flag_2==1)
                en=i; % ��¼��ǰ����
                p_flag(en)=1; % ��Ǹõ��Ѿ�����͹������
                cnt=cnt+1; % ͹���������1
                pp(cnt)=en;
                st=en; % �ؼ���2�����ҵ����µ���һ��͹������Ϊ�µ���㣬ѭ����Ѱ����һ��͹����
                if (en==pj) % �ؼ���3��͹����ձ�־��Ҳ�������˳���־Ϊ��Ѱ�ҵ����µ�͹����ص������
                    flag_1=1;  % ���͹����ղ�����flag_1��1���˳�������������
                    break;
                end
            end
            
        end
        
    end % ����i����ţ�ѭ��
end % ����whileѭ��

% ����Figure 3�����͹������ʾ��ͼ
% ���͹����⣬��¼��͹�����x,y���꣨����˳ʱ�����ʱ�뷽��
ptx=zeros(1,cnt);
pty=zeros(1,cnt);
for i=1:cnt
    ptx(i)=x(pp(i));
    pty(i)=y(pp(i));
end

% ���û�ͼ������
axes(handles.axes1); % ��axes1��Ϊ��ǰ�����ᣬ����ͼ���ڵ�ǰ�������л���
cla reset;
hold on
plot(x,y,'b*','MarkerSize',6);
plot(ptx,pty,'r-','LineWidth',2);
hold off
legend('ԭʼ������ɵ�','͹��������');
xlabel('\itx����'),ylabel('\ity����'),title('ͼ3�����͹������ʾ��ͼ');
grid on
box on

%% ģ��5������͹�����
% --- Executes on button press in Calculation_Convex_Area.
function Calculation_Convex_Area_Callback(hObject, eventdata, handles)

global x y cnt pp; % ����ȫ�ֱ���

S=0; % ��¼͹�����
x11=x(pp(1)); % �Ե�һ����Ϊ�����ι�������
y11=y(pp(1));
for k=2:(cnt-2)
    x22=x(pp(k));
    y22=y(pp(k));
    x33=x(pp(k+1));
    y33=y(pp(k+1));
    % ����֮����빫ʽ
    a=sqrt((x11-x22)*(x11-x22)+(y11-y22)*(y11-y22));
    b=sqrt((x11-x33)*(x11-x33)+(y11-y33)*(y11-y33));
    c=sqrt((x22-x33)*(x22-x33)+(y22-y33)*(y22-y33));
    p=(a+b+c)/2; % ���������ΰ��ܳ�
    dS=sqrt(p*(p-a)*(p-b)*(p-c)); % ���ú���-�ؾ��ع�ʽ�������������
    S=dS+S;
end

c=num2str(S); %ת��Ϊ�ַ��� 
set(handles.Output_Convex_Area,'String',c); % ����ṹ�壬�������ֵ��Output_Convex_Area�ռ��string���ԣ���ʾ���
guidata(hObject,handles); % ���½ṹ��

%% ģ��6�����͹��������ı���
function Output_Convex_Area_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Output_Convex_Area_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
