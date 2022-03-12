function varargout = gui_test4(varargin)
%GUI_TEST4 M-file for gui_test4.fig
%      GUI_TEST4, by itself, creates a new GUI_TEST4 or raises the existing
%      singleton*.
%
%      H = GUI_TEST4 returns the handle to a new GUI_TEST4 or the handle to
%      the existing singleton*.
%
%      GUI_TEST4('Property','Value',...) creates a new GUI_TEST4 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to gui_test4_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_TEST4('CALLBACK') and GUI_TEST4('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_TEST4.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_test4

% Last Modified by GUIDE v2.5 20-Mar-2020 10:45:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_test4_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_test4_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before gui_test4 is made visible.
function gui_test4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for gui_test4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_test4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_test4_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input1_Callback(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of input1 as text
%        str2double(get(hObject,'String')) returns contents of input1 as a double
%以字符串的形式来存储数据文本框1的内容. 如果字符串不是数字，则现实空白内容
input=str2num(get(hObject,'String'));%检查输入是否为空. 如果为空,则默认显示为0
if (isempty(input))	
set(hObject,'String','0')
end
guidata(hObject,handles);%保存handles结构体，只要在handles结构体有改变时，才需要保存 %guidata(hObject, handles);%这里由于handles没有改变，故这里其实没有必要，但是为了避免潜在的不必要麻烦，建议在所有Callback都添加该命令。


% --- Executes during object creation, after setting all properties.
function input1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function answer_Callback(~, eventdata, handles)
% hObject    handle to answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of answer as text
%        str2double(get(hObject,'String')) returns contents of answer as a double


% --- Executes during object creation, after setting all properties.
function answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input2_Callback(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of input2 as text
%        str2double(get(hObject,'String')) returns contents of input2 as a double
input=str2num(get(hObject,'String'));%检查输入是否为空. 如果为空,则默认显示为0
if (isempty(input))
set(hObject,'String','0')
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function input2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.input1,'String');
b=get(handles.input2,'String'); 
%a和b是字符串变量，我们需要使用str2double函数将其转换为数值，然后才能相加，否则字符串是没法相加的
total=str2num(a)+str2num(b); %格式转换为数值
c=num2str(total); %转化为字符串 
set(handles.answer,'String',c);%保存结构体，将结果赋值给answer_static Text空间的string属性，于是就可以显示结果了
guidata(hObject,handles);%更新结构体
