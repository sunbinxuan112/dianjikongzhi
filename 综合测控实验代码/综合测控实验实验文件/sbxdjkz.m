function varargout = sbxdjkz(varargin)
% SBXDJKZ MATLAB code for sbxdjkz.fig
%      SBXDJKZ, by itself, creates a new SBXDJKZ or raises the existing
%      singleton*.
%
%      H = SBXDJKZ returns the handle to a new SBXDJKZ or the handle to
%      the existing singleton*.
%
%      SBXDJKZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SBXDJKZ.M with the given input arguments.
%
%      SBXDJKZ('Property','Value',...) creates a new SBXDJKZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sbxdjkz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sbxdjkz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sbxdjkz

% Last Modified by GUIDE v2.5 11-Aug-2020 13:29:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sbxdjkz_OpeningFcn, ...
                   'gui_OutputFcn',  @sbxdjkz_OutputFcn, ...
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


% --- Executes just before sbxdjkz is made visible.
function sbxdjkz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sbxdjkz (see VARARGIN)

% Choose default command line output for sbxdjkz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sbxdjkz wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global axeshandles;
global axes2handles;
global axes3handles;
global t t1 t2 t3;
global data;
global Fs;
global f;
global HDAQ;
global f1;
global f1z;
global A;
global sCom;
global gbw dbw;
global P P1;
global X X1 Y Y1;
global numSpeed;
global numTarget;
global SumError LastError PreError;
global numPGain numIGain numDGain;
global HisIndex HisWave;
global HisIndex1 HisWave1;
global d1;
global state;
state=0;
d1=6000;
axeshandles=handles.axes1;
axes2handles=handles.axes2;
axes3handles=handles.axes3;
global handles1;
handles1=handles.edit1;
global handles2;
handles2=handles.edit6;
global handles3;
handles3=handles.edit5;
global handles4;
handles4=handles.edit2;
global handles5;
handles5=handles.edit3;
global handles6;
handles6=handles.edit4;


% --- Outputs from this function are returned to the command line.
function varargout = sbxdjkz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t1;
global HDAQ;
global d1;
if isempty(d1)%�ж�d1����Ƶ��
    d1=6000;%d1Ϊ��ʱȡ6000Hz
end
HDAQ=USBDAQ8_INIT;%�ɼ�����ʼ��
if d1==6000;%���ݲ�ͬ����Ƶ��ѡ���Ӧ��ͨ��������Ƶ�ʺͲ�������
USBDAQ8_DAQ(HDAQ,5,6000,1000);
elseif d1==8000;
USBDAQ8_DAQ(HDAQ,5,8000,1000);
elseif d1==10000;
USBDAQ8_DAQ(HDAQ,5,10000,1000);
elseif d1==12000;
USBDAQ8_DAQ(HDAQ,5,12000,1000);
else
USBDAQ8_DAQ(HDAQ,5,14000,1000);
end
set(handles.edit7,'string',d1);%����GUI�����в���Ƶ��ֵ
t1=timer('TimerFcn','getdata','Period',0.2,'ExecutionMode','fixedSpacing','TasksToExecute',inf);%���ö�ʱ��������getdata�ļ�
start(t1);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t2;
global sCom;
global gbw dbw;
global P P1;
global handles3;
global handles4;
global handles5;
global handles6;
global numPGain numIGain numDGain;
global SumError LastError PreError;
global strTarget numTarget;
global HisIndex;
global axes2handles;
global axes3handles;
global HisWave;
HisWave=0;%����ٶ�
numPGain=str2double(get(handles4,'string'));%ȡKp
numIGain=str2double(get(handles5,'string'));%ȡKi
numDGain=str2double(get(handles6,'string'));%ȡKd
%���������
SumError=0;
LastError=0;
PreError=0;
HisIndex=1;
cla(handles.axes2);%�������ϵͼ��
sCom=serial('COM10','BaudRate',115200);
fopen(sCom);%�򿪴���ͨ��
strTarget=get(handles3,'string');%ȡ����ת��
numTarget=str2num(strTarget);%ת���ַ�
j=sign(numTarget);%�ж�ת�ٷ���
if j>=0%�ж�����ת����
    gdp=polyval(P,numTarget);%��ȡ�ߵ�ƽʱ��
else
    gdp=polyval(P1,numTarget);%��ȡ�ߵ�ƽʱ��
end
gbw=floor(gdp/256);%ȡ�߰�λ
dbw=mod(gdp,256);%ȡ�Ͱ�λ
tx=[85 5 251 gbw dbw 170];%ʮ�������ı�
fwrite(sCom,tx,'uchar');%����ߵ�ƽʱ��
t2=timer('TimerFcn','pidkz','Period',0.1,'ExecutionMode','fixedSpacing','TasksToExecute',inf);%���ö�ʱ��������pidkz�ļ�
start(t2);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sCom;
global t2;
global axes2handles;
%ֹͣ��ʱ����ֹͣ���
if ~isempty(t2)
    stop(t2);
    delete(t2);
end

tx=[85 5 252];
fwrite(sCom,tx,'uchar');
fclose(sCom);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%global handles1;
%handles1=get(edithandles);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t1;
global HDAQ;
%ֹͣ�ɼ�ֹͣ��ʱ��
if length(t1)>0%ֹͣ�ɼ�
    stop(t1);
    USBDAQ8_QUIT(HDAQ);
    delete(t1);
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sCom;
global handles2;
global P P1;
global X Y X1 Y1;
global axes3handles
global state
%�궨����
sCom=serial('COM10','BaudRate',115200);
fopen(sCom);%�򿪴���ͨ��
Y=1400:-20:1100;%ȡ��ת�ߵ�ƽʱ��
Y1=1600:20:1900;%ȡ��ת�ߵ�ƽʱ��
%��ת�ɼ����ߵ�ƽʱ������Ӧ��ת��
m=1400;
for i=1:16
    gbw=floor(m/256);%ȡ�߰�λ
    dbw=mod(m,256);%ȡ�Ͱ�λ
    tx=[85 5 251 gbw dbw 170];%ʮ�������ı�
    fwrite(sCom,tx,'uchar');%����ߵ�ƽʱ��
   for k=1:71
       if state==1%�ж��Ƿ�ֹͣ���
        tx=[85 5 252];%ֹͣ���
fwrite(sCom,tx,'uchar');
        break
    end
    pause(0.1);%��ʱ0.1s
   end
    zhuansu=get(handles2,'string');%ȡʵ��ת��
    X(i)=str2double(zhuansu);
    m=m-20;
    plot(axes3handles,X(i),Y(i),'+');%����ֱ���ϵĵ�
hold on;
end
if state==0%�ж��Ƿ������ת
tx=[85 5 252];%ֹͣ���
fwrite(sCom,tx,'uchar');
pause(5);%ֹͣ5s
%��ת�ɼ����ߵ�ƽ����Ӧ��ת��
m=1600;
for i=1:16
    gbw=floor(m/256);%ȡ�߰�λ
    dbw=mod(m,256);%ȡ�Ͱ�λ
    tx=[85 5 251 gbw dbw 170];%ʮ�������ı�
    fwrite(sCom,tx,'uchar');%����ߵ�ƽʱ��
    for k=1:71
        if state==1;%�ж��Ƿ�ֹͣ���
        tx=[85 5 252];%ֹͣ����ı�
fwrite(sCom,tx,'uchar');
        break
    end
    pause(0.1);
    end
    zhuansu=get(handles2,'string');%ȡʵ��ת��
    X1(i)=-(str2double(zhuansu));
    m=m+20;
    plot(axes3handles,X1(i),Y1(i),'+');
hold on;
end
end
if state==0%�жϵ��״̬
P=polyfit(X,Y,1)%�������ֱ��
P1=polyfit(X1,Y1,1)%��Ϸ�תֱ��
tx=[85 5 252];%ֹͣ����ı�
fwrite(sCom,tx,'uchar');%����
plot(axes3handles,X,Y);%������תֱ��
hold on;
plot(axes3handles,X1,Y1);%���Ʒ�תֱ��
else
    cla(handles.axes3);%�����ϵ3
end
tx=[85 5 252];
fwrite(sCom,tx,'uchar');
fclose(sCom);%�رմ���ͨ��
state=0;




% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global axes2handles;
% legend(axes2handles,'off');
global HisWave;
global HisWave1;
HisWave1=0;%����ٶ�
HisWave=0;%����ٶ�
cla(handles.axes2);%��������Შ��


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sCom;
global gbw dbw;
global strTarget numTarget;
global P P1;
global handles3;
global t3;
global HisIndex1;
global HisWave1;
HisWave1=0;%����ٶ�
cla(handles.axes2);%��������Შ��
HisIndex1=1;%��ֵ
sCom=serial('COM10','BaudRate',115200);
fopen(sCom);%�򿪴���ͨ��
strTarget=get(handles3,'string');%ȡ�����ٶ�
numTarget=str2num(strTarget);
j=sign(numTarget);%�ж�ת�ٷ���
if j>=0%�ж�����ת
    gdp=polyval(P,numTarget);
else
    gdp=polyval(P1,numTarget);
end
gbw=floor(gdp/256);%ȡ�߰�λ
dbw=mod(gdp,256);%ȡ�Ͱ�λ
tx=[85 5 251 gbw dbw 170];%ʮ�������ı�
fwrite(sCom,tx,'uchar');%����ߵ�ƽʱ��
fclose(sCom);
t3=timer('TimerFcn','openkz','Period',0.1,'ExecutionMode','fixedSpacing','TasksToExecute',inf);%���ö�ʱ��������openkz�ļ�
start(t3);


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global HDAQ
 USBDAQ8_QUIT(HDAQ);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sCom;
global t3;
%��������ɾ����ʱ��ֹͣ���
sCom=serial('COM10','BaudRate',115200);
fopen(sCom);%�򿪴���ͨ��
tx=[85 5 252];
fwrite(sCom,tx,'uchar');
fclose(sCom);
if length(t3)>0
    stop(t3);
    delete(t3);
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d1;
value=get(hObject,'value');%��ȡ����Ƶ��
if rem(value,2000)~=0%����Ƶ�ʲ�Ϊ����ʱȡ��
    set(hObject,'Value',round(value/2000)*2000)
end
value=get(hObject,'value');
d1=value;%��ò���Ƶ��
set(handles.edit7,'string',value);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global state
state=1;%ֹͣ���ʱ��һ
%created only by sunbinxuan
