function [ I ] = col2img( xs,ys,orgxs, orgys )
% Convert points to image
    ys = -1*ys;
    endx = max(xs);
    endy = max(ys);
    startx = min(xs);
    starty = min(ys);
    I = zeros(orgys, orgxs);
    for ii=1:size(xs,1);
%         I(ys(ii)-starty+1,xs(ii)-startx+1) = 1;
        I(ys(ii),xs(ii)) = 1;
    end
end

