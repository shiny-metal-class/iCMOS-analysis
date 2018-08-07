function varargout = iCMOS_controller(varargin)
% ICMOS_CONTROLLER MATLAB code for iCMOS_controller.fig
%      ICMOS_CONTROLLER, by itself, creates a new ICMOS_CONTROLLER or raises the existing
%      singleton*.
%
%      H = ICMOS_CONTROLLER returns the handle to a new ICMOS_CONTROLLER or the handle to
%      the existing singleton*.
%
%      ICMOS_CONTROLLER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICMOS_CONTROLLER.M with the given input arguments.
%
%      ICMOS_CONTROLLER('Property','Value',...) creates a new ICMOS_CONTROLLER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iCMOS_controller_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iCMOS_controller_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iCMOS_controller

% Last Modified by GUIDE v2.5 06-Aug-2018 21:48:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iCMOS_controller_OpeningFcn, ...
                   'gui_OutputFcn',  @iCMOS_controller_OutputFcn, ...
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


% --- Executes just before iCMOS_controller is made visible.
function iCMOS_controller_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iCMOS_controller (see VARARGIN)

% Choose default command line output for iCMOS_controller
handles.output = hObject;
axes(handles.img_ax); imshow('sp_img.jpg');
set(handles.view_sum,'String',0E00);
%initialise the Data object and add it to handles
handles.data = Data();
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iCMOS_controller wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = iCMOS_controller_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_tag_Callback(hObject, eventdata, handles)
% hObject    handle to file_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in fname_list.
function fname_list_Callback(hObject, eventdata, handles)
% hObject    handle to fname_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fname_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fname_list
handles.data.selected_data = get(hObject,'Value');
set(handles.view_sum,'String',handles.data.integral{handles.data.selected_data});
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fname_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function load_fctn_Callback(hObject, eventdata, handles)
% hObject    handle to load_fctn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.img_ax);
[file_names,file_path] = uigetfile('*.sif','multiselect','on','select sif file');
handles.data.file_path = file_path; handles.data.file_names = file_names;
set(handles.fname_list,'Value',1);
set(handles.fname_list,'String',handles.data.file_names);
handles.data;



function view_sum_Callback(hObject, eventdata, handles)
% hObject    handle to view_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of view_sum as text
%        str2double(get(hObject,'String')) returns contents of view_sum as a double


% --- Executes during object creation, after setting all properties.
function view_sum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to view_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
