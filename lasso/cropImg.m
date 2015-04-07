%% Read images with prefixes of certain format.
%  Returns cells each containing b/w images with edge detection

imgPre = 'dog';
imgType = '.jpg';
N = 36;
fudge = [1 1];
xoff = 150;
yoff = 500;

%% Add images to path

images = cell(1,N);

for ii=1:N
    img = imread([imgPre num2str(ii) imgType]); % Read image
%     [xs ys zs] = size(img);
%     img = img(xoff:xs-xoff,yoff:ys-yoff,2);              % Crop/To b/w
%     img = img(:,:,2);
%     [~,thresh] = edge(img,'sobel');             % Edge detect and save
%     bws = edge(img,'sobel',thresh*fudge);
%     images{ii} = bws;
    images{ii} = img;
end

%% Edge detect
img = images{5};
finalImg = zeros(size(img));
finalImg = finalImg(:,:,1);

for ii=1:3
    imgbw = img(:,:,ii);
    [~,thresh] = edge(imgbw,'canny');             % Edge detect and save
    bws = edge(imgbw,'canny',thresh.*fudge);
    finalImg = bws + finalImg;
    figure, imshow(bws);
end

finalImg = finalImg >= 2;
figure, imshow(finalImg);