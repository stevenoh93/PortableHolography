function [  ] = customLasso( I )
%%%% Mouse-drag magnetic lasso %%%%
key = 0;
global minsize;
global img
img = I;
sizey = size(I,1);
sizex = size(I,2);
disp(sizey);
disp(sizex);
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
    global img
    global minsize
    thresh = 3;
    s = size(img);
    disp(s);

    C = get(gca,'CurrentPoint');
    cp = [C(3) C(1)];
    if(abs(cp(1)) < 1)
        dy = 0;
    else
        dy = cp(1)-centery;
    end
    if(abs(cp(2)) < 1)
        dx = 0;
    else
        dx = cp(2)-centerx;
    end
    
    mind = min(dx,dy);
    dir = [round(dy/mind) round(dx/mind)];
    
    disp(['dx = ' num2str(dir(2))]);
    disp(['dy = ' num2str(dir(1))]);
    np = cp;
    while 1
        cp = np;
        if(abs(cp(1)) < 1)
            dy = 0;
        else
            dy = cp(1)-centery;
        end
        if(abs(cp(2)) < 1)
            dx = 0;
        else
            dx = cp(2)-centerx;
        end
        mind = min(dx,dy);
        dir = [round(dy/mind) round(dx/mind)];
        np = cp + dir*10;
        % Compare pixel values between cp and np
%         ind1 = sub2ind(s,np(1),np(2));
%         ind2 = sub2ind(s,cp(1),cp(2));
%         disp(class(ind1));
        contr = abs(img(round(sub2ind(s,np(1),np(2)))) - img(round(sub2ind(s,cp(1),cp(2)))));
        dist = sum((np-[centery centerx])*(np-[centery centerx])');
        disp(['contr = ' num2str(contr)]);
        disp(['dst = ' num2str(dist)]);
        if(contr > thresh)
            hold on;
            scatter(cp(2)+dir(2),cp(1)+dir(1),minsize/25,'o');
            break;
        end
        if(dist < 3000)
            disp('too close to the center');
            break;
        end
%         break;
    end


function buttonUp(object, event)
    % get the properties and restore them
    props = getappdata(object,'TestGuiCallbacks');
    set(object,props);