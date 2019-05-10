function varargout = game_of_life(varargin)
% GAME_OF_LIFE M-file for game_of_life.fig
%      GAME_OF_LIFE, by itself, creates a new GAME_OF_LIFE or raises the existing
%      singleton*.
%
%      H = GAME_OF_LIFE returns the handle to a new GAME_OF_LIFE or the handle to
%      the existing singleton*.
%
%      GAME_OF_LIFE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAME_OF_LIFE.M with the given input arguments.
%
%      GAME_OF_LIFE('Property','Value',...) creates a new GAME_OF_LIFE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before game_of_life_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to game_of_life_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help game_of_life

% Last Modified by GUIDE v2.5 08-May-2019 18:57:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @game_of_life_OpeningFcn, ...
                   'gui_OutputFcn',  @game_of_life_OutputFcn, ...
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


% --- Executes just before game_of_life is made visible.
function game_of_life_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to game_of_life (see VARARGIN)

% Choose default command line output for game_of_life
handles.output = hObject;
% Update handles structure
handles.gen = 100;
handles.start = false;
guidata(hObject, handles);

% UIWAIT makes game_of_life wait for user response (see UIRESUME)
% uiwait(handles.figure1);


xlim([0 50])
ylim([0 50])
pcolor(zeros(50,50));
set(gca,'XTick',[], 'YTick', [])
%imagesc(gray(2));

% --- Outputs from this function are returned to the command line.
function varargout = game_of_life_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
handles.beg=get(hObject,'Value');
guidata(hObject, handles); 

len=50;
GRID=zeros(len,len);
s = floor(len/2);

switch(handles.beg)
    case 1
        GRID(s,s-1)=1; GRID(s,s+2)=1; GRID(s-1,s:s+1)=1; GRID(s+1,s:s+1)=1;
        disp(GRID*100);
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
    case 2
        GRID(s, s-1:s)=1;GRID(s-1, s:s+1)=1;GRID(s+1, s+1)=1;
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
    case 3
        n=20;
        %x = floor((x1-0.53)*(len)/(3.48-0.53));
        %y = floor((y1-0.53)*(len)/(2.48-0.53));
        %while handles.start == false
        for i=1:n
            [x1, y1]=ginput(1);
            GRID(floor(y1),floor(x1))=1;
            pcolor(GRID);
            set(gca,'XTick',[], 'YTick', [])
        end
    case 4
        GRID(s-1:s+1, s)=1;
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
    case 5
        GRID=int8(rand(len,len));
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
end

handles.grid = GRID;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
handles.start = true;
guidata(hObject, handles); 

len=50;
GRID = handles.grid;
up=[2:len 1]; down=[len 1:len-1];

for i=1:handles.gen
    %set(handles.text1,'String',strcat('Epoka: ', int2str(i)));
    set(handles.text2,'String',i);
    neighbours=GRID(up,:)+GRID(down,:)+GRID(:,up)+GRID(:,down)+...
       GRID(up,up)+GRID(up,down)+GRID(down,up)+GRID(down,down);
    GRID = neighbours==3 | GRID & neighbours==2;
    pcolor(GRID);
    set(gca,'XTick',[], 'YTick', [])
    pause(0.02);
end

% --- Executes on key press with focus on pushbutton2 and none of its controls.
function pushbutton2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
handles.gen=str2num(get(hObject,'String'));
guidata(hObject, handles); 

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


% --- Executes on key press with focus on edit1 and none of its controls.
function edit1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
