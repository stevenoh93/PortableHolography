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
disp(['centerx = ' num2str(centerx)]); %(917, 393)
disp(['centery = ' num2str(centery)]);

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
    global img;
    global minsize;
    thresh = 20;
    s = size(img);
    disp(s);

    C = get(gca,'CurrentPoint');
    np = [C(3) C(1)];
    while 1
        cp = np;
        % get new direction towards the center
        if(abs(cp(1)-centery) < 1)
            dy = 0;
        else
            dy = cp(1)-centery;
        end
        if(abs(cp(2)-centerx) < 1)
            dx = 0;
        else
            dx = cp(2)-centerx;
        end
        mind = -1*abs(min(dx,dy));
        if(mind == 0)
            mind = -1*abs(max(dx,dy));
        end
        dir = [round(dy/mind) round(dx/mind)];
        np = cp + dir*5;
%         disp(['mind = ' num2str(mind)]);
%         disp(['dx = ' num2str(dir(2))]);
%         disp(['dy = ' num2str(dir(1))]);
        % Compare pixel values between cp and np
        contr = getDiffMetric(cp,np);
        % Get physical distance between cp and np
        dist = euclideanDist(np,[centery centerx]);
        
%         disp(['dst = ' num2str(dist)]);
        if(contr > thresh)
            hold on;
            selectPoint([cp(2)+dir(2), cp(1)+dir(1)],minsize/50);
            disp(['contr = ' num2str(contr)]);
            disp(cp);
            disp(np);
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
    
function ret = getDiffMetric(currentPoint, nextPoint)
    global img;
    pix1 = img(round(sub2ind(size(img),nextPoint(1),nextPoint(2))));
    pix2 = img(round(sub2ind(size(img),currentPoint(1),currentPoint(2))));
    % for grayscale
%     ret = abs(pix1 - pix2);
    % for rgb
    ret = euclideanDist(pix1, pix2);
function dist = euclideanDist(p1, p2)
    dist = sum((p1-p2)*(p1-p2)');
    
function selectPoint(point,pointSize)
    scatter(point(1),point(2),pointSize,'o','b');