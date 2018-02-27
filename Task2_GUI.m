function varargout = Task2_GUI(varargin)
% TASK2_GUI MATLAB code for Task2_GUI.fig
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Task2_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Task2_GUI_OutputFcn, ...
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

% --- Executes just before Task2_GUI is made visible.
function Task2_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for Task2_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Task2_GUI_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile({'*.JPG';'*.tif';'*.gif';'*.png'});
filename = fullfile(PathName,FileName);
global Image1;
Image1 = imread(filename);
Image1 =  rgb2gray(Image1);
axes(handles.axes1);
imshow(Image1);
title(handles.axes1,'Image1');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile({'*.JPG';'*.tif';'*.gif';'*.png'});
filename = fullfile(PathName,FileName);
global Image2;
Image2 = imread(filename);
Image2 =  rgb2gray(Image2);
axes(handles.axes2);
imshow(Image2);
title(handles.axes2,'Image2');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

a = get(handles.edit5,'string');
b = get(handles.edit1,'string');
x = str2num(a);
y = str2num(b);

global Image1;
global Image2;

     Image1_Resized = imresize(Image1,[x y]);
     F_Image1_Resized = fft2(Image1_Resized);                         % Perform fast fourier transform on original image
     mag1_Image1_Resized = abs(F_Image1_Resized);                     % Get magnitude
     phase1_Image1_Resized = angle(F_Image1_Resized);                 % Apply phase shift

     Image2_Resized = imresize(Image2,[x y]);
     F_Image2_Resized = fft2(Image2_Resized);                         % Perform fast fourier transform on original image
     mag2_Image2_Resized = abs(F_Image2_Resized);                           % Get magnitude
     phase2_Image2_Resized = angle(F_Image2_Resized);                       % Apply phase shift
     
     ShiftedImage = mag1_Image1_Resized.*exp(i*phase2_Image2_Resized);       % Recombine magnitude and phase
     New_Image1 = ifft2(ShiftedImage);  % Perform inverse fourier transform
     min_D_New_Image1 = min(min(abs(New_Image1)));
     max_D_New_Image1 = max(max(abs(New_Image1)));
     
     ShiftedImage1 = mag2_Image2_Resized.*exp(i*phase1_Image1_Resized);       % Recombine magnitude and phase
     New_Image2 = ifft2(ShiftedImage1);  % Perform inverse fourier transform
     min_D_New_Image2 = min(min(abs(New_Image2)));
     max_D_New_Image2 = max(max(abs(New_Image2)));
     
     Image1_Reconstructed = ifft2(F_Image1_Resized);  % Perform inverse fourier transform
     min_D_New_Image1_Reconstructed = min(min(abs(Image1_Reconstructed)));
     max_D_New_Image1_Reconstructed = max(max(abs(Image1_Reconstructed))); 
     
     Image2_Reconstructed = ifft2(F_Image2_Resized);  % Perform inverse fourier transform
     min_D_New_Image2_Reconstructed = min(min(abs(Image2_Reconstructed)));
     max_D_New_Image2_Reconstructed = max(max(abs(Image2_Reconstructed)));
     
axes(handles.axes1);
imshow(Image1_Resized);
title(handles.axes1,'Image1 Resized');

axes(handles.axes2);
imshow( New_Image1, [min_D_New_Image1 max_D_New_Image1]), colormap gray;
title(handles.axes2,'New Image1');

axes(handles.axes3);
imshow(Image1_Reconstructed, [min_D_New_Image1_Reconstructed max_D_New_Image1_Reconstructed]), colormap gray;
title(handles.axes3,'Image1 Reconstructed');

axes(handles.axes4);
imshow(Image2_Resized);
title(handles.axes4,'Image2 Resized');

axes(handles.axes5);
imshow( New_Image2, [min_D_New_Image2 max_D_New_Image2]), colormap gray;
title(handles.axes5,'New Image2');

axes(handles.axes6);
imshow(Image2_Reconstructed, [min_D_New_Image2_Reconstructed max_D_New_Image2_Reconstructed]), colormap gray;
title(handles.axes6,'Image2 Reconstructed');

function edit5_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
