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

% Last Modified by GUIDE v2.5 05-Jun-2019 00:47:34

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
handles.gen = 1000;
handles.edit1 = 10;
handles.edit2 = 10;
handles.start = false;
handles.env = 1;
handles.xw = 150;
handles.yw = handles.xw;
handles.n_zar = 0;
handles.iterations = 100;
handles.k = 2;
handles.t = 0.001;
handles.ro_c = 4.21584E+12 / (handles.xw*handles.yw);
handles.r_i = 100;
handles.x_procent = 61;
guidata(hObject, handles);

% UIWAIT makes game_of_life wait for user response (see UIRESUME)
% uiwait;llllllll(handles.figure1);

xlim([0 handles.xw])
ylim([0 handles.yw])
pcolor(zeros(handles.yw,handles.xw));
set(gca,'XTick',[], 'YTick', [])
%colormap(gray(2))

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

Grains(handles.yw,handles.xw) = Grain(1,1,1);
for i=1:handles.yw
    for j=1:handles.xw
        Grains(i, j) = Grain(i+j,0,i+j, rand()+i, rand()+j, 0, false, false);
    end
end

GRID=zeros(handles.yw,handles.xw);
for i=1:handles.yw
    for j=1:handles.xw
        GRID(i,j) = Grains(i,j).color;
    end
end

switch(handles.beg)
    case 1
        n=handles.edit1+1;
        m=handles.edit2+1;
        k=1;
        handles.n_zar = 0;
        for i=1:n
            for j=1:m
                GRID(i*floor(handles.yw/n),j*floor(handles.xw/m))=k;
                k=k+1;
                handles.n_zar = handles.n_zar+1;
            end
        end
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
    case 2
        r=handles.edit1;
        n=handles.edit2;
        handles.n_zar = 0;
        for i=1:n
            a=0;
            while a<100
                x=floor((handles.xw-1).*rand(1,1)+1);
                y=floor((handles.xw-1).*rand(1,1)+1);
                B=GRID(max([y-r,1]):min([y+r,size(GRID,1)]), max([x-r,1]):min([x+r,size(GRID,2)]));
                if B==0
                    GRID(y,x)=i;
                    handles.n_zar = handles.n_zar+1;
                    break;
                end
                a=a+1;
            end
        end
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
    case 3
        n=handles.edit1;
        handles.n_zar = 0;
        for i=1:n
            while 1
                x=floor((handles.xw-1).*rand(1,1)+1);
                y=floor((handles.xw-1).*rand(1,1)+1);
                
                if GRID(y,x) == 0
                    GRID(y,x) = i;
                    handles.n_zar = handles.n_zar+1;
                    break;
                end
            end
            %GRID(floor(49.*rand(1,1)+1), floor(49.*rand(1,1)+1)) = i;
        end
        pcolor(GRID);
        set(gca,'XTick',[], 'YTick', [])
    case 4
        n=200;
        handles.n_zar = 0;
        %x = floor((x1-0.53)*(len)/(3.48-0.53));
        %y = floor((y1-0.53)*(len)/(2.48-0.53));
        %while handles.start == false
        for i=1:n
            [x1, y1]=ginput(1);
            if floor(x1) > handles.xw
                break;
            end
            GRID(floor(y1),floor(x1))=i;
            handles.n_zar = handles.n_zar+1;
            pcolor(GRID);
            set(gca,'XTick',[], 'YTick', [])
        end
end

set(handles.text4,'String',handles.n_zar);

for i=1:handles.yw
    for j=1:handles.xw
        Grains(i,j).color = GRID(i,j);
    end
end

handles.grains = Grains;
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

GRID = handles.grid;

for it=1:handles.gen
    set(handles.text2,'String',it);
    %neighbours=GRID(up,:)+GRID(down,:)+GRID(:,up)+GRID(:,down)+...
       %GRID(up,up)+GRID(up,down)+GRID(down,up)+GRID(down,down);
    %GRID = neighbours==3 | GRID & neighbours==2;
    Grains = handles.grains;
    GRID_2=GRID;
    
    for i=1:handles.xw
        for j=1:handles.yw
            env = handles.env;
            if handles.env == 9
                env = floor(2.*rand())+3;
            end
            if handles.env == 10
                env = floor(4.*rand())+5;
                %disp(env);
            end
            %GRID(max([j-1,1]):min([j+1,size(GRID,1)]), max([i-1,1]):min([i+1,size(GRID,2)])) = GRID(j,i);
            %GRID_2(GRID_2(max([j-1,1]):min([j+1,size(GRID,1)]),i) == 0) = GRID(j,i);
            %GRID_2(GRID_2(j,max([i-1,1]):min([i+1,size(GRID,2)])) == 0) = GRID(j,i);

            if GRID(j,i)==0
                %GRID_2(GRID(max([j-1,1]):min([j+1,size(GRID,1)]), max([i-1,1]):min([i+1,size(GRID,2)])) ~= 0) = GRID(j,i);

                %if handles.env == 1 || handles.env == 2 || handles.env == 3 || handles.env == 4 || handles.env == 6 || handles.env == 7 || handles.env == 8
                if env ~= 5
                    if GRID(max([j-1,1]),i)~=0 %0,-1
                        GRID_2(j,i) = GRID(max([j-1,1]),i);
                    end
                end
                %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 7 || handles.env == 8
                if env ~= 6
                    if GRID(min([j+1,size(GRID,1)]),i)~=0 %0,+1
                        GRID_2(j,i) = GRID(min([j+1,size(GRID,1)]),i);
                    end
                end
                %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 7
                if env ~= 8
                    if GRID(j,max([i-1,1]))~=0 %-1,0
                        GRID_2(j,i) = GRID(j,max([i-1,1]));
                    end
                end
                %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 8
                if env ~= 7
                    if GRID(j,min([i+1,size(GRID,2)]))~=0 %1,0
                        GRID_2(j,i) = GRID(j,min([i+1,size(GRID,2)]));
                    end
                end

                if env == 2 || env == 3 || env == 6 || env == 7
                    if GRID(max([j-1,1]),max([i-1,1]))~=0 %-1,-1
                        GRID_2(j,i) = GRID(max([j-1,1]),max([i-1,1]));
                    end
                end
                if env == 2 || env == 3  || env == 5 || env == 8
                    if GRID(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)]))~=0 %1,1
                        GRID_2(j,i) = GRID(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)]));
                    end
                end
                if env == 2 || env == 4 || env == 5 || env == 7
                    if GRID(min([j+1,size(GRID,1)]),max([i-1,1]))~=0 %-1,1
                        GRID_2(j,i) = GRID(min([j+1,size(GRID,1)]),max([i-1,1]));
                    end
                end
                if env == 2 || env == 4 || env == 6 || env == 8
                    if GRID(max([j-1,1]),min([i+1,size(GRID,2)]))~=0 %1,-1
                        GRID_2(j,i) = GRID(max([j-1,1]),min([i+1,size(GRID,2)]));
                    end
                end
            end
            
            if GRID(j,i)~=0 && handles.env == 11
                for k=1:handles.xw
                    for l=1:handles.yw
                        if (Grains(k,l).x - j)^2 + (Grains(k,l).y - i)^2 < handles.edit1 && GRID(k,l)==0 
                            GRID_2(k,l) = GRID(j,i);
                        end
                    end
                end
            end
        end
    end
    GRID=GRID_2;
    pcolor(GRID);
    set(gca,'XTick',[], 'YTick', [])
    pause(0.01);
    
    if GRID ~= 0
        break;
    end
    
    handles.grid = GRID;  
    guidata(hObject, handles); 
end

function pushbutton3_Callback(hObject, eventdata, handles)
GRID = handles.grid;
env = handles.env;

for iteration=1:handles.iterations
    linear_iterator = randperm(handles.xw*handles.yw);
    s = [handles.xw,handles.yw];
    [i,j] = ind2sub(s,linear_iterator);
    %disp(linear_iterator);

    set(handles.text9,'String',iteration);
    
    energy = zeros(handles.xw, handles.yw);
    
    for ind=1:handles.xw*handles.yw
        %i(ind)=1;
        %j(ind)=1;
        c = GRID(j(ind),i(ind));
        E = 0;
        neighbour_C=1;
        delta_E = 0;
        Grains = handles.grains;
        
        for xd=1:2
            E = 0;
            if env ~= 5
                if GRID(max([j(ind)-1,1]),i(ind))~=c %0,-1
                    E=E+1;             
                    neighbour_C=[neighbour_C, GRID(max([j(ind)-1,1]),i(ind))];
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 7 || handles.env == 8
            if env ~= 6
                if GRID(min([j(ind)+1,size(GRID,1)]),i(ind))~=c %0,+1
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(min([j(ind)+1,size(GRID,1)]),i(ind))];
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 7
            if env ~= 8
                if GRID(j(ind),max([i(ind)-1,1]))~=c %-1,0
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(j(ind),max([i(ind)-1,1]))];
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 8
            if env ~= 7
                if GRID(j(ind),min([i(ind)+1,size(GRID,2)]))~=c %1,0
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(j(ind),min([i(ind)+1,size(GRID,2)]))];
                end
            end

            if env == 2 || env == 3 || env == 6 || env == 7
                if GRID(max([j(ind)-1,1]),max([i(ind)-1,1]))~=c %-1,-1
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(max([j(ind)-1,1]),max([i(ind)-1,1]))];
                end
            end
            if env == 2 || env == 3  || env == 5 || env == 8
                if GRID(min([j(ind)+1,size(GRID,1)]),min([i(ind)+1,size(GRID,2)]))~=c %1,1
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(min([j(ind)+1,size(GRID,1)]),min([i(ind)+1,size(GRID,2)]))];
                end
            end
            if env == 2 || env == 4 || env == 5 || env == 7
                if GRID(min([j(ind)+1,size(GRID,1)]),max([i(ind)-1,1]))~=c %-1,1
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(min([j(ind)+1,size(GRID,1)]),max([i(ind)-1,1]))];
                end
            end
            if env == 2 || env == 4 || env == 6 || env == 8
                if GRID(max([j(ind)-1,1]),min([i(ind)+1,size(GRID,2)]))~=c %1,-1
                    E=E+1;
                    neighbour_C=[neighbour_C, GRID(max([j(ind)-1,1]),min([i(ind)+1,size(GRID,2)]))];
                end
            end
            
            energy(j(ind),i(ind)) = E;
            
            %disp(GRID(1,1));
            %disp(c);
            %disp(E);
            %disp(neighbour_C);
            
            if E > 0
                pos = randi(length(neighbour_C)-1)+1;
                %pos = randi(4);
                c = neighbour_C(pos);
            end

            if xd==1
                delta_E = E;
            end
            if xd==2
                delta_E = E - delta_E;
            end
        end
        
        p=0;
        if delta_E <= 0
            p=1;
        else
            p = exp(-delta_E / handles.k);
        end
        
        if p >= rand()
            GRID(j(ind),i(ind)) = c;
        end
    end

    pcolor(GRID);
    set(gca,'XTick',[], 'YTick', [])
    pause(0.01);
end

handles.grid = GRID;
handles.energy = energy;
guidata(hObject, handles);

figure(1);
pcolor(energy);
set(gca,'XTick',[], 'YTick', [])

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
A = 86710969050178.5;
B = 9.41268203527779;
n=handles.r_i;
ro = zeros(n);
delta_t = handles.t * 1000;
x = handles.x_procent;
Grains = handles.grains;
GRID = handles.grid;
energy = handles.energy;

for i=1:n
    %disp(floor(t*1000));
    ro(i) = A/B + (1-A/B)*exp(-B*i*handles.t);
end

% figure(1);
% plot(ro);

for t=1:delta_t:n
    set(handles.text13,'String',t);
    
    delta_ro = ro(t+1) - ro(t);
    ro_sr = delta_ro / (handles.xw*handles.yw);
    Grains(t).dod = Grains(t).dod + x/100 * ro_sr;
    
    %disp(delta_ro);
    delta_ro = (100 - x)/100 * delta_ro;
    while delta_ro > 0
        d = floor(rand*1000000000);
        
        if d > delta_ro
            d = delta_ro;
        end
        
        delta_ro = delta_ro - d;
        
        if rand > 0.8
            while 1
                ind = floor(randi(handles.xw*handles.yw));
                if energy(ind) > 0
                    break;
                end
            end
        else
            while 1
                ind = floor(randi(handles.xw*handles.yw));
                if energy(ind) == 0
                    break;
                end
            end
        end
        %disp(delta_ro);
        Grains(ind).dod = Grains(ind).dod + d;
    end
%disp(Grains(1).dod);

%------------------------
    for i=1:handles.xw*handles.yw
        if Grains(i).dod > handles.ro_c && energy(i) > 0
            Grains(i).isRecrystallized = true;
            Grains(i).isRecrystallizedBefore = true;
            Grains(i).dod = 0;
            GRID(i) = 15;
        end
    end
%------------------------
    Grains_2 = Grains;
    
    for i=1:numel(Grains)
        Grains_2(i).isRecrystallizedBefore = false;
    end
    
    for i=1:handles.xw
        for j=1:handles.yw
            isOneNeighbourRecrystallizedBefore = false;
            
            env = handles.env;
            if handles.env == 9
                env = floor(2.*rand())+3;
            end
            if handles.env == 10
                env = floor(4.*rand())+5;
                %disp(env);
            end
            
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.
            if env ~= 5
                if Grains(max([j-1,1]),i).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(max([j-1,1]),i).dod > Grains(j,i).dod
                       %break;
                       continue
                    end
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 7 || handles.env == 8
            if env ~= 6
                if Grains(min([j+1,size(GRID,1)]),i).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(min([j+1,size(GRID,1)]),i).dod > Grains(j,i).dod
                       %break;
                       continue 
                    end
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 7
            if env ~= 8
                if Grains(j,max([i-1,1])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(j,max([i-1,1])).dod > Grains(j,i).dod
                       %break;
                       continue 
                    end
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 8
            if env ~= 7
                if Grains(j,min([i+1,size(GRID,2)])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(j,min([i+1,size(GRID,2)])).dod > Grains(j,i).dod
                       %break;
                       continue
                    end
                end
            end

            if env == 2 || env == 3 || env == 6 || env == 7
                if Grains(max([j-1,1]),max([i-1,1])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(max([j-1,1]),max([i-1,1])).dod > Grains(j,i).dod
                       %break;
                       continue 
                    end
                end
            end
            if env == 2 || env == 3  || env == 5 || env == 8
                if Grains(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)])).dod > Grains(j,i).dod
                       %break;
                       continue
                    end
                end
            end
            if env == 2 || env == 4 || env == 5 || env == 7
                if Grains(min([j+1,size(GRID,1)]),max([i-1,1])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(min([j+1,size(GRID,1)]),max([i-1,1])).dod > Grains(j,i).dod
                       %break;
                       continue
                    end
                end
            end
            if env == 2 || env == 4 || env == 6 || env == 8
                if Grains(max([j-1,1]),min([i+1,size(GRID,2)])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(max([j-1,1]),min([i+1,size(GRID,2)])).dod > Grains(j,i).dod
                       %break;
                       continue
                    end
                end
            end
            
            if isOneNeighbourRecrystallizedBefore
               Grains_2(j,i).isRecrystallized = true; 
               Grains_2(j,i).isRecrystallizedBefore = true; 
               Grains_2(j,i).dod = 0;
               GRID(j,i) = 15;
            end
        end
    end
    Grains=Grains_2;
    pcolor(GRID);
    set(gca,'XTick',[], 'YTick', [])
    pause(0.01);
end
disp("done")

dys = 0;
dod = zeros(handles.xw, handles.yw);
for i=1:handles.xw*handles.yw
    dys = dys + Grains(i).dod;
    dod(i) = Grains(i).dod;
    %if dod(i) == 0
     %   dod(i) = 20;
    %else
     %   dod(i) = 2;
    %end
end

disp(dys);
save('plik.txt', 'dys');

%figure(2);
%pcolor(dod);
%set(gca,'XTick',[], 'YTick', [])
%pcolor(GRID);
%set(gca,'XTick',[], 'YTick', [])

handles.energy = energy;
handles.grid = GRID;
handles.grains = Grains;
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
Grains = handles.grains;
GRID = handles.grid;
energy = handles.energy;

Grains_2 = Grains;

for t=1:handles.r_i 
    set(handles.text13,'String',t);
    
    for i=1:numel(Grains)
        Grains_2(i).isRecrystallizedBefore = false;
    end
    
    for i=1:handles.xw
        for j=1:handles.yw
            isOneNeighbourRecrystallizedBefore = false;
            
            env = handles.env;
            if handles.env == 9
                env = floor(2.*rand())+3;
            end
            if handles.env == 10
                env = floor(4.*rand())+5;
                %disp(env);
            end
            
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.
            if env ~= 5
                if Grains(max([j-1,1]),i).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(max([j-1,1]),i).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 7 || handles.env == 8
            if env ~= 6
                if Grains(min([j+1,size(GRID,1)]),i).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(min([j+1,size(GRID,1)]),i).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 7
            if env ~= 8
                if Grains(j,max([i-1,1])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(j,max([i-1,1])).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            %if handles.env == 1 || handles.env == 2  || handles.env == 3 || handles.env == 4 || handles.env == 5 || handles.env == 6 || handles.env == 8
            if env ~= 7
                if Grains(j,min([i+1,size(GRID,2)])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(j,min([i+1,size(GRID,2)])).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end

            if env == 2 || env == 3 || env == 6 || env == 7
                if Grains(max([j-1,1]),max([i-1,1])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(max([j-1,1]),max([i-1,1])).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            if env == 2 || env == 3  || env == 5 || env == 8
                if Grains(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)])).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            if env == 2 || env == 4 || env == 5 || env == 7
                if Grains(min([j+1,size(GRID,1)]),max([i-1,1])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(min([j+1,size(GRID,1)]),max([i-1,1])).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            if env == 2 || env == 4 || env == 6 || env == 8
                if Grains(max([j-1,1]),min([i+1,size(GRID,2)])).isRecrystallizedBefore %0,-1
                    isOneNeighbourRecrystallizedBefore = true;
                else
                    if Grains(max([j-1,1]),min([i+1,size(GRID,2)])).dod > Grains(j,i).dod
                       break; 
                    end
                end
            end
            
            if isOneNeighbourRecrystallizedBefore
               Grains_2(j,i).isRecrystallized = true; 
               Grains_2(j,i).isRecrystallizedBefore = true; 
               Grains_2(j,i).dod = 0;
               GRID(j,i) = 15;
            end
        end
    end
    Grains=Grains_2;
    pcolor(GRID);
    set(gca,'XTick',[], 'YTick', [])
    pause(0.01);
end

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

function edit2_Callback(hObject, eventdata, handles)
handles.edit1=str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit3_Callback(hObject, eventdata, handles)
handles.edit2=str2num(get(hObject,'String'));
guidata(hObject, handles);


function edit4_Callback(hObject, eventdata, handles)
handles.iterations=str2num(get(hObject,'String'));
guidata(hObject, handles);

function edit6_Callback(hObject, eventdata, handles)
handles.k=str2num(get(hObject,'String'));
guidata(hObject, handles);

function edit7_Callback(hObject, eventdata, handles)
handles.t=str2num(get(hObject,'String'));
guidata(hObject, handles);

function edit8_Callback(hObject, eventdata, handles)
handles.r_i=str2num(get(hObject,'String'));
guidata(hObject, handles);

function edit9_Callback(hObject, eventdata, handles)
handles.ro_c=str2num(get(hObject,'String'));
guidata(hObject, handles);

function edit10_Callback(hObject, eventdata, handles)
handles.x_procent=str2num(get(hObject,'String'));
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


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


% --- Executes on key press with focus on edit2 and none of its controls.
function edit2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
handles.env=get(hObject,'Value');
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
