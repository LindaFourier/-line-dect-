function varargout = untitled2(varargin)
% UNTITLED2 MATLAB code for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 12-Jun-2018 15:27:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @untitled2_OpeningFcn, ...
    'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles)
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
global line
global A
[filename,pathname] = uigetfile({'*.bmp';'*.jpg';'*.png'},'选择图片');   %弹出对话框
str = [pathname,filename];   %合并图像路径和名称
line = imread(str);
axes(handles.axes1);
imshow(line)
A = rgb2gray(line);
A = im2bw(A);
A = edge(A,'canny');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global line;
global A;
set(handles.radiobutton2,'Value',1);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',0);
set(handles.radiobutton8,'Value',0);
set(handles.radiobutton10,'Value',0);
sinvalue=zeros(1,180);
cosvalue=zeros(1,180);
for a=1:180
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:130
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        end
    end
end
h_maxr = 0;
for i = 120:130
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:250
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 310:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end



% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
global line;
global A;
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',1);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',0);
set(handles.radiobutton8,'Value',0);
set(handles.radiobutton10,'Value',0);
sinvalue=zeros(1,180);
cosvalue=zeros(1,180);
for a=1:180
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 130:150
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:200
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 150:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
global A;
global line;
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',1);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',0);
set(handles.radiobutton8,'Value',0);
set(handles.radiobutton10,'Value',0);
sinvalue=zeros(1,180);
cosvalue=zeros(1,180);
for a=1:180
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 130:150
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:200
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 140:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
global line;
A = rgb2gray(line);
A = histeq(A);
A = edge(A,'sobel');
sinvalue=zeros(1,180); 
cosvalue=zeros(1,180); 
for a=1:180  
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 130:150
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:230
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 180:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
global A;
global line;
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',1);
set(handles.radiobutton7,'Value',0);
set(handles.radiobutton8,'Value',0);
set(handles.radiobutton10,'Value',0);
sinvalue=zeros(1,180); 
cosvalue=zeros(1,180); 
for a=1:180  
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 100:150
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:520
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 380:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
global A;
global line;
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',1);
set(handles.radiobutton8,'Value',0);
set(handles.radiobutton10,'Value',0);
sinvalue=zeros(1,180); 
cosvalue=zeros(1,180); 
for a=1:180  
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 100:150
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:200
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 100:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8
global A;
global line;
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',0);
set(handles.radiobutton8,'Value',1);
set(handles.radiobutton10,'Value',0);
sinvalue=zeros(1,180); 
cosvalue=zeros(1,180); 
for a=1:180  
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 100:150
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:400
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 380:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10
global line;
A = rgb2gray(line);
A = histeq(A);
A = edge(A,'sobel');
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',0);
set(handles.radiobutton8,'Value',0);
set(handles.radiobutton10,'Value',1);
sinvalue=zeros(1,180); 
cosvalue=zeros(1,180); 
for a=1:180  
    sinvalue(a)=sin((a/180)*pi);
    cosvalue(a)=cos((a/180)*pi);
end
[w,h] = size(A);
temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
temp=round(temp);
H=zeros(180,temp*2+1);
for y = 1:size(A,1)
    for x = 1:size(A,2) 
        if A(y,x) == 1
            for a = 50:150
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
h_maxl = 0;
for i = 50:60;
    for j = 1:size(H,2);
        if H(i,j) > h_maxl
            h_maxl = H(i,j);
            al = i;  pl = j;
        else
            h_maxl = h_maxl;
        end
    end
end
h_maxr = 0;
for i = 130:140
    for j = 1:size(H,2);
        if H(i,j) > h_maxr
            h_maxr = H(i,j);
            ar = i;  pr = j;
        else
            h_maxr = h_maxr;
        end
    end
end
if (pl>temp)
    pl = pl-(temp+1);
else pl = pl-temp;
end
if (pr>temp)
    pr = pr-(temp+1);
else pr = pr-temp;
end
axes(handles.axes1);
imshow(line);
hold on
k1 = -sin((al/180)*pi)/cos((al/180)*pi);
b1 = pl/cos((al/180)*pi);
for y1 = 1:500
    x1 = round( ( y1 - b1 ) / k1 );
    plot(y1,x1,'*','Color','red');
end
hold on
k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
b2 = pr/cos((ar/180)*pi);
for x2 = 450:w;
    y2 = round( k2 * x2 + b2);
    plot(y2,x2,'*','Color','red');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
clc;
clear all;
