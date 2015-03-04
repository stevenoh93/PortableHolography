function test
% test gui function

% create figure
fig = figure;

% set the figure's WindowButtonDownFcn
set(fig,'WindowButtonDownFcn',{@wbd});



% ---------------------------
function wbd(h,evd)

disp('down')

% get the values and store them in the figure's appdata
props.WindowButtonMotionFcn = get(h,'WindowButtonMotionFcn');
props.WindowButtonUpFcn = get(h,'WindowButtonUpFcn');
setappdata(h,'TestGuiCallbacks',props);

% set the new values for the WindowButtonMotionFcn and
% WindowButtonUpFcn
set(h,'WindowButtonMotionFcn',{@wbm})
set(h,'WindowButtonUpFcn',{@wbu})


% ---------------------------
function wbm(h,evd)
% executes while the mouse moves

C = get(0,'PointerLocation');
disp(C)

% ---------------------------
function wbu(h,evd)
% executes when the mouse button is released

disp('up')

% get the properties and restore them
props = getappdata(h,'TestGuiCallbacks');
set(h,props);
