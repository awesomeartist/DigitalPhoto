function varargout = final_homework(varargin)
% FINAL_HOMEWORK MATLAB code for final_homework.fig
%      FINAL_HOMEWORK, by itself, creates a new FINAL_HOMEWORK or raises the existing
%      singleton*.
%
%      H = FINAL_HOMEWORK returns the handle to a new FINAL_HOMEWORK or the handle to
%      the existing singleton*.
%
%      FINAL_HOMEWORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL_HOMEWORK.M with the given input arguments.
%
%      FINAL_HOMEWORK('Property','Value',...) creates a new FINAL_HOMEWORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_homework_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_homework_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final_homework

% Last Modified by GUIDE v2.5 25-Dec-2019 15:45:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_homework_OpeningFcn, ...
                   'gui_OutputFcn',  @final_homework_OutputFcn, ...
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


% --- Executes just before final_homework is made visible.
function final_homework_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final_homework (see VARARGIN)

% Choose default command line output for final_homework
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final_homework wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_homework_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global origin I0
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图片');
if isequal(filename,0)||isequal(pathname,0)
        errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框?
         return;
else
           str=[pathname,filename];
           origin=imread(str);
           axes(handles.axes1);
          imshow(origin),title('原图像'); 
          I0=origin;
end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global I0
val=get(handles.popupmenu1,'value');
x=ndims(I0);
if x>2
    img=double(rgb2gray(I0));
else
    img=double(I0);
end
     ma=max(max(img));
     mi=min(min(img));
switch val
    case 1
         I1=(img-mi)*(255/(ma-mi));  
         axes(handles.axes2);
         I1=uint8(I1);
         imshow(I1),title('灰度变换后');
    case 2
         I1=uint8(255*(img/255).^0.5);         %幂次变换
         axes(handles.axes2);
         imshow(I1),title('Gamma变换后');
    case 3
            [m, n] = size(I0);
            % 统计每个像素值出现次数
            count = zeros(1, 256);
            for i = 1 : m
                for j = 1 : n
                    count(1, I0(i, j) + 1) = count(1, I0(i, j) + 1) + 1;
                end
            end
            %一下编写T函数[2]
            T = zeros(1, 256);
            T = double(T); count = double(count);

            % 统计每个像素值出现的概率， 得到概率直方图
            for i = 1 : 256
                T(1, i) = count(1, i) / (m * n);
            end 
            % 求累计概率，得到累计直方图
            for i = 2 : 256
                T(1, i) = T(1, i - 1) + T(1, i);
            end
            % 完善T函数的定义
            for i = 1 : 256
                T(1, i) = T(1, i) * 255;
            end
            % 完成每个像素点的映射
            out = double(img);
            for i = 1 : m
                for j = 1 : n
                    out(i, j) = T(1, out(i, j) + 1);
                end
            end
            % 输出改数据类型
            I1 = uint8(out);
            axes(handles.axes2);
            imshow(I1),title('均衡化后');
    case 4

end
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.

% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
global I0
val=get(handles.popupmenu3,'value');
x=ndims(I0);
if x>2
    img=double(rgb2gray(I0));
else
    img=double(I0);
end
switch val
 case 1
        T=50;%阈值
        [m,n]=size(img);
        I3=zeros(m,n);
        for i=2:m-1
            for j=2:n-1
                I3(i,j)=abs(I0(i+1,j)-I0(i,j))+abs(I0(i,j+1)-I0(i,j));
                if I3(i,j)<T
                    I3(i,j)=0;
                else
                    I3(i,j)=255;
                end
            end
        end
        axes(handles.axes2);
        imshow(I3),title('梯度算子锐化');
    case 2
        T=50;%阈值
        [m,n]=size(img);
        I3=zeros(m,n);
        for i=2:m-1
            for j=2:n-1
                I3(i,j)=abs(img(i+1,j+1)-img(i,j))+abs(img(i+1,j)-img(i,j+1));
                if I3(i,j)<T
                    I3(i,j)=0;
                else
                    I3(i,j)=255;
                end
            end
        end
        axes(handles.axes2);
        imshow(I3),title('Roberts算子锐化');
    case 3
        I3=edge(img,'prewitt');
        axes(handles.axes2);
        imshow(I3),title('Prewitt算子锐化');
    case 4
        I3=edge(img,'sobel');
        axes(handles.axes2);
        imshow(I3),title('Sobel算子锐化');
    case 5
        T=50;%阈值
        [m,n]=size(img);
        I3=zeros(m,n);
        for i=2:m-1
            for j=2:n-1
                I3(i,j)=abs(img(i+1,j)+img(i-1,j)+img(i,j+1)+img(i,j-1)-4*img(i,j));
                if I3(i,j)<T
                    I3(i,j)=0;
                else
                    I3(i,j)=255;
                end
            end
        end
        axes(handles.axes2);
        imshow(I3),title('Laplacian算子锐化');
end
        
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
%function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
global org
val=get(handles.popupmenu2,'value');
switch val
    case 1
        T=50;%阈值
        [m,n]=size(org);
        I3=zeros(m,n);
        for i=2:m-1
            for j=2:n-1
                I3(i,j)=abs(org(i+1,j)-org(i,j))+abs(org(i,j+1)-org(i,j));
                if I3(i,j)<T
                    I3(i,j)=0;
                else
                    I3(i,j)=255;
                end
            end
        end
        axes(handles.axes4);
        imshow(I3),title('梯度算子锐化');
    case 2

    case 3
        I3=edge(org,'prewitt');
        axes(handles.axes4);
        imshow(I3),title('Prewitt算子锐化');
    case 4
        I3=edge(org,'sobel');
        axes(handles.axes4);
        imshow(I3),title('Sobel算子锐化');
    case 5
                T=20;%阈值
        [m,n]=size(org);
        I3=zeros(m,n);
        for i=2:m-1
            for j=2:n-1
                I3(i,j)=abs(org(i+1,j)+org(i-1,j)+org(i,j+1)+org(i,j-1)-4*org(i,j));
                if I3(i,j)<T
                    I3(i,j)=0;
                else
                    I3(i,j)=255;
                end
            end
        end
        axes(handles.axes4);
        imshow(I3),title('Laplacian算子锐化');
end
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
global I0
val=get(handles.popupmenu4,'value');
x=ndims(I0);
if x>2
    img=rgb2gray(I0);
else
    img=I0;
end
switch val
    case 1
        I4=ordfilt2(img,5,ones(3,3));
        axes(handles.axes2);
        imshow(I4),title('中值滤波结果'); 
    case 2
        img=double(img);
       Fs=fftshift(fft2(img/255));
       Fs1=uint8(abs(Fs));
       axes(handles.axes3);
       imshow(Fs1),title('傅里叶变换频谱');
%        Fs2=uint8(log(1 + abs(Fs)));
%        axes(handles.axes4);
%        imshow(Fs2),title('傅里叶变换取对数频谱');
       [m,n]=size(Fs);
       m0=round(m/2);
       n0=round(m/2);
       D0=20;
       for i=1:m
           for j=1:n
               distance=sqrt((i-m0)^2+(j-n0)^2);
               if distance<=D0
                   h=1;
               else
                   h=0;
               end
               Fs(i,j)=h*Fs(i,j);
           end
       end
       I4=uint8(real(ifft2(ifftshift(255*Fs))));
       axes(handles.axes2);
       imshow(I4),title('理想低通滤波所得图像');
       
    case 3
       img = double(img)/255;
       Fs=fftshift(fft2(img));
       axes(handles.axes3);
       imshow(uint8(abs(Fs))),title('傅里叶变换频谱');
       %axes(handles.axes4);
       %imshow(log(1 + abs(s))),title('傅里叶变换取对数频谱');
       [m,n]=size(Fs);
       m0=round(m/2);
       n0=round(m/2);
       D0=20;
       p=0.2;
       q=0.5;
       for i=1:m
           for j=1:n
               distance=sqrt((i-m0)^2+(j-n0)^2);
               if distance<=D0
                   h=0;
               else
                   h=1;
               end
               Fs(i,j)=(p+q*h)*Fs(i,j);
           end
       end
       I4=uint8(real(ifft2(ifftshift(255*Fs))));
       axes(handles.axes2);
       imshow(I4),title('理想高通滤波所得图像');
    case 4
        img = I0;
        img = im2double(img);
        N = 2*size(img,1);
        M = 2*size(img,2);
        u = -M/2:(M/2-1);
        v = -N/2:(N/2-1);
        [U,V] = meshgrid(u,v);
        D = sqrt(U.^2 + V.^2);
        D0 =40;
        n = 2;
        H2 = 1./(1+(D./D0).^(2*n));
        J2 = fftshift(fft2(img,size(H2,1),size(H2,2))); %转换到频域图像
        K2 = J2.*H2;
        L2 = ifft2(ifftshift(K2));
        L2 = L2(1:size(img,1),1:size(img,2));
        I4 = uint8(L2*255);
        axes(handles.axes2);
        imshow(I4),title('Buttorworth低通滤波结果');
    case 5
        img = I0;
        img = im2double(img);
        n=1;
        d=50;
        h=size(img,1);
        w=size(img,2);
        fftim = fftshift(fft2(double(img)));
        [x,y]=meshgrid(-floor(w/2):floor(w/2)-1,-floor(h/2):floor(h/2)-1);
        B = sqrt(2) - 1; 
        D = sqrt(x.^2 + y.^2); 
        hhp = 1 ./ (1 + B * ((d ./ D).^(2 * n)));
        out_spec_centre = fftim .* hhp;
        out_spec = ifftshift(out_spec_centre);
        out = real(ifft2(out_spec));
        out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
        out = uint8(255*out);
        axes(handles.axes2);
        imshow(out),title('Buttorworth高通滤波结果');
end

% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
global origin I0 PSF
val =get(handles.popupmenu5,'value');
switch val
    case 1
        pixel=10;       %模糊像素范围
        theta=45;       %模糊方向
        PSF = fspecial('motion',pixel,theta);
        I0 = imfilter(origin,PSF,'conv','circular');
        axes(handles.axes1);
        imshow(I0),title('添加运动模糊后的图像');
    case 2
        I0= imnoise(origin,'salt & pepper');
        axes(handles.axes1);
        imshow(I0) ,title('添加椒盐噪声后的图像')
    case 3
        %添加高斯噪声
        mean_value=0;
        variance=0.025;
        I0=imnoise(origin,'gaussian',mean_value,variance);
        axes(handles.axes1);
        imshow(I0),title('添加高斯噪声后的图像');
end
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
global I0
val=get(handles.popupmenu6,'value');
img=I0;
switch val
    case 1
        h = size(img, 1);
        w = size(img, 2);
        I6=zeros(h,w);
        for i = 2 : h-1
            for j = 2 : w-1
                up = i-1;
                down = i+1;
                left = j-1;
                right = j+1;
                I6(i, j) = mean(mean(img(up : down, left : right)));
            end
        end
        I6=uint8(I6);
        axes(handles.axes2);
        imshow(I6),title('局部平滑后的图像');
    case 2
        T=16;
        h = size(img, 1);
        w = size(img, 2);
        I6=zeros(h,w);
        for i = 3 : h-3
            for j = 3 : w-3
                up = i - 2;
                down = i + 2;
                left =j - 2;
                right = j + 2;
                mea=mean(mean(img(up : down, left : right)));
                if abs(mea-img(i,j))>=T
                    I6(i, j) =mea ;
                else
                    I6(i,j)=img(i,j);
                end               
            end
        end
        I6=uint8(I6);
        axes(handles.axes2);
        imshow(I6),title('超限像素平滑后的图像');
    case 3
end
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
       global I0
       img = double(I0)/255;
       Fs=fftshift(fft2(img));
       axes(handles.axes3);
       imshow(uint8(abs(Fs))),title('傅里叶变换频谱');
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
        global I0 PSF
        I3 = deconvwnr(I0, PSF, 0);
        axes(handles.axes2);
        imshow(I3);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
global I0
val=get(handles.popupmenu7,'value');
x=ndims(I0);
if x>2
    img=double(rgb2gray(I0));
else
    img=double(I0);
end
switch val
    case 1
        T = graythresh(img);
        I7=imbinarize(img,T);
        axes(handles.axes2);
        imshow(I7),title('固定阈值分割后的图像');
    case 2
        I7=imbinarize(img,'adaptive');
        axes(handles.axes2);
        imshow(I7),title('固定阈值分割后的图像');
    case 3
        sigma = 1;
        gausFilter = fspecial('gaussian', [3,3], sigma);
        out=imfilter(img, gausFilter, 'replicate');
        I7=edge(out, 'canny', 0.5);
        axes(handles.axes2);
        imshow(I7),title('边缘检测结果');
        
    case 4
end
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
global I0
val=get(handles.popupmenu8,'value');
        x=ndims(I0);
        if x>2
            img=rgb2gray(I0);
        else
            img=I0;
        end
switch val
    case 1
        I = img;
        [M,N] = size(I);
        I1 = I(:);
        P = zeros(1,256);
        %获取各符号的概率；
        for i = 0:255
            P(i+1) = length(find(I1 == i))/(M*N);
        end
        k = 0:255;
        dict = huffmandict(k,P); %生成字典
        enco = huffmanenco(I1,dict); %编码
        writematrix(enco,'Huffcode.txt');
    case 2
                I = img;
        [M,N] = size(I);
        I1 = I(:);
        P = zeros(1,256);
        %获取各符号的概率；
        for i = 0:255
            P(i+1) = length(find(I1 == i))/(M*N);
        end
end
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
