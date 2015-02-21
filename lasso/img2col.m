function [ xs,ys ] = img2col( I )
% Convert binary image I (NxM) to column vectors 
    sizex = size(I,2);
    sizey = size(I,1);
    xs = zeros(sizex,1);
    ys = zeros(sizey,1);
    xi = 1;
    yi = 1;
    for x = 1:sizex
        for y = 1:sizey
            if(I(y,x)==1)
                xs(xi) = x;
                ys(yi) = -y;
                xi = xi+1; 
                yi = yi+1;
            end
        end
    end
    xs = xs(1:find(xs,1,'last'));
    ys = ys(1:find(ys,1,'last'));
end
