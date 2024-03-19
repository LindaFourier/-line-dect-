function varargout = untitled3(varargin)
% UNTITLED3 MATLAB code for untitled3.fig
%      UNTITLED3, by itself, creates a new UNTITLED3 or raises the existing
%      singleton*.
%
%      H = UNTITLED3 returns the handle to a new UNTITLED3 or the handle to
%      the existing singleton*.
%
%      UNTITLED3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED3.M with the given input arguments.
%
%      UNTITLED3('Property','Value',...) creates a new UNTITLED3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled3

% Last Modified by GUIDE v2.5 12-Jun-2018 18:01:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled3_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled3_OutputFcn, ...
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


% --- Executes just before untitled3 is made visible.
function untitled3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled3 (see VARARGIN)

% Choose default command line output for untitled3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vector
video = VideoReader('G:\DATA\dxk1407080209报告报告报告\毕设资料\行车记录仪03.avi');
vector = zeros(1,100);
standard = 55;
for k = 151:5:500
    frame = read(video,k);
    if  ( rem(k,10)==1 )
        A = rgb2gray(frame);
        A = histeq(A);
        A = edge(A,'canny');
        [w,h] = size(A);
        sinvalue=zeros(1,180);
        cosvalue=zeros(1,180);
        for a=1:180
            sinvalue(a)=sin((a/180)*pi);
            cosvalue(a)=cos((a/180)*pi);
        end
        temp=sqrt(size(A,1)*size(A,1)+size(A,2)*size(A,2));
        temp=round(temp); 
        H=zeros(360,temp*2+1); 
        for y = 1:size(A,1) 
            for x = 1:size(A,2) 
                if A(y,x) == 1 
                    for a = 45:179
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
        %     al = 0; pl = 0;
        h_maxl = 0; 
        for i = 45:65;   
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
        imshow(frame);
        hold on
        k1 = -sin((al/180)*pi)/cos((al/180)*pi);
        b1 = pl/cos((al/180)*pi);
        for y1 = 1:180;
            x1 = round( ( y1 - b1 ) / k1 );
            plot(y1,x1,'Color','cyan');
        end
        hold on
        k2 = -sin((ar/180)*pi)/cos((ar/180)*pi);
        b2 = pr/cos((ar/180)*pi);
        for x2 = 150:h;
            y2 = round( k2 * x2 + b2);
            plot(y2,x2,'Color','cyan');
        end        
        v = floor(k/10)+1;
        vector(1,v) = al - standard;
        switch(1)
            case ( vector(1,v)>9 )   %大偏角，对比前两次检测的结果
                q = 0;   %用于筛选时间的累加值
                for m = (v-2):(v)
                    if ( vector(1,v)>9 )
                        q = q+1;
                        if (q>2)
                            errordlg('危险！！！已偏离行驶路线！','!!!','modal');
                        end
                    end
                end
            case ( vector(1,v)>6 )   %小偏角，对比前5次检测的结果
                q = 0;
                for m = (v-5):(v)
                    if ( vector(1,v)>6 )
                        q = q+1;
                        if (q>5)
                            warndlg('注意！行驶方向左偏！可能压线！','!','modal');
                        end
                    end
                end
            case ( vector(1,v)<(-9) )
                q = 0;
                for m = (v-2):(v)
                    if ( vector(1,v)<(-9) )
                        q = q+1;
                        if (q>2)
                            errordlg('危险！！！已偏离行驶路线！','!!!','modal');
                        end
                    end
                end
            case ( vector(1,v)<(-6) )
                q = 0;
                for m = (v-5):(v)
                    if ( vector(1,v)<(-6) )
                        q = q+1;
                        if (q>5)
                            warndlg('注意！行驶方向右偏！可能压线！','!','modal');
                        end
                    end
                end
        end       
    else
        axes(handles.axes1);
        imshow(frame);
        hold on
        for y1 = 1:180;
            x1 = round( ( y1 - b1 ) / k1 );
            plot(y1,x1,'Color','cyan');
        end
        hold on
        for x2 = 150:h;
            y2 = round( k2 * x2 + b2);
            plot(y2,x2,'Color','cyan');
        end
        H = 0;
    end
    drawnow;
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global vector
i = vector(1,v);
set(handles.edit1,'string',i);
pause(1);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
