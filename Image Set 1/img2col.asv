function [ xs,ys ] = img2col( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    sizex = size(I,1);
    sizey = size(I,2);
    xs = zeros(sizex,1);
    ys = zeros(sizey,1);
    xi = 1;
    yi = 1;
    for x = 1:sizex
        for y = 1:sizey
            if(I(x,y)==1)
                xs(xi) = x;
                ys(yi) = y;
                xi = xi+1; 
                yi = yi+1;
            end
        end
    end
    xs = xs(1:find(xs,1,'last'));
    ys = ys(1:find(ys,1,'last'));
end

