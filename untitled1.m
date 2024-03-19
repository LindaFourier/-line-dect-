function varargout = untitled1(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 12-Jun-2018 12:03:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @untitled1_OpeningFcn, ...
    'gui_OutputFcn',  @untitled1_OutputFcn, ...
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


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles)
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
warning off
feature jit off
global image;
[filename,pathname] = uigetfile({'*.bmp';'*.jpg';'*.png'},'选择图片');   %弹出对话框
str = [pathname,filename];   %合并图像路径和名称
image = imread(str);
axes(handles.axes1);
imshow(image)
image = im2bw(image);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global temp;
sinvalue=zeros(1,180);
cosvalue=zeros(1,180);
for a=1:180
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
temp=sqrt(size(image,1)^2+size(image,2)^2);
temp=round(temp);
global H;
H=zeros(180,temp*2+1);
for y = 1:size(image,1)
    for x = 1:size(image,2)
        if image(y,x) == 1
            for a = 1:180
                p = round( y * sinvalue(a) + x * cosvalue(a) );
                if (p>0)
                    p = p + temp +1;
                    H(a,p) = H(a,p)+1;
                elseif (p<0)
                    p = p -(-temp);
                    H(a,p) = H(a,p)+1;
                end
            end
        end
    end
end
axes(handles.axes1)
imshow(H);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global H;
global temp;
if size(image,1)==20
    h_maxl = 0;
    for i = 1:size(H,1);
        for j = 1:size(H,2);
            if H(i,j) > h_maxl
                h_maxl = H(i,j);
                al = i;  pl = j;
            else
                h_maxl = h_maxl;
            end
        end
    end
    if (pl>temp)
        pl = pl-(temp+1);
    else pl = pl-temp;
    end
    axes(handles.axes1)
    imshow(image);
    hold on;
    k1 = -sin((al/180)*pi)/cos((al/180)*pi);
    b1 = pl/cos((al/180)*pi);
    for x = 1:size(image,1);
        x1 = round((x-b1)/k1);
        plot(x,x1,'*','Color','red');
    end
else
    A = edge(image,'sobel');
    [houg,T,R]=hough(A,'RhoResolution',0.5,'ThetaResolution',0.5);
    P=houghpeaks(houg,10);
    x=T(P(:,2));
    y=R(P(:,1));
    lines=houghlines(A,T,R,P);
    axes(handles.axes1);
    imshow(image)
    hold on
    max_len=0;
    xy_long = 0;
    for k=1:length(lines)
        xy = [lines(k).point1;lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
        len=norm(lines(k).point1 - lines(k).point2);
        if(len>max_len)
            max_len=len;
            xy_long = xy;
        end
    end
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','green');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
