function [  ] = customLasso( I )
%%%% Mouse-drag magnetic lasso %%%%
key = 0;
global sizey;
global sizex;
sizey = size(I,1);
sizex = size(I,2);
minsize = min(sizey, sizex);
C = 0;

global fig;
fig = figure;
imshow(I);
disp('Press a KEY to start selection by mouse');
while key==0
    key=waitforbuttonpress;
    pause(0.2)
end

disp('First, approximately pick the center of the object');
key=0;
global centerx;
global centery;
centerx = 0;
centery = 0;
[centerx centery key] = ginput(1);
hold on;
scatter(centerx,centery,minsize/20,'x','b');

disp('Now, drag around the object as close as possible');
set(fig,'WindowButtonDownFcn',@buttonDown);


%%
function buttonDown(object, event)
    % get the values and store them in the figure's appdata
    props.WindowButtonMotionFcn = get(object,'WindowButtonMotionFcn');
    props.WindowButtonUpFcn = get(object,'WindowButtonUpFcn');
    setappdata(object,'TestGuiCallbacks',props);

    % set the new values for the WindowButtonMotionFcn and
    % WindowButtonUpFcn
    set(object,'WindowButtonMotionFcn',{@buttonMotion})
    set(object,'WindowButtonUpFcn',{@buttonUp})
    
function buttonMotion(object, event)
    global centerx;
    global centery;
    global fig;
    global sizey;
    global sizex;
    C = get(fig, 'CurrentPoint');
    dx = C(1)-centerx;
    dy = C(2)-centery;
%     disp(['dx = ' num2str(dx)]);
%     disp(['dy = ' num2str(dy)]);
    disp(['c1 = ' num2str(C(1))]);
    disp(['c2 = ' num2str(C(2))]);


function buttonUp(object, event)
    % get the properties and restore them
    props = getappdata(object,'TestGuiCallbacks');
    set(object,props);