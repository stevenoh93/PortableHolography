function [filled] = fillImg(edgeImg) 

%     se1 = strel('line', 5, 0);
%     se2 = strel('line', 5, 45);
%     se3 = strel('line', 5, 90);
%     se4 = strel('line', 5, 135);
%     dil = imdilate(edgeImg, [se1, se2, se3, se4]);
    se = strel('disk', 4);
    dil = imdilate(edgeImg, [se]);
    filled = imfill(dil, 'holes');
%     filled = filled & ~dil;
    figure, imshow(filled);
    
end