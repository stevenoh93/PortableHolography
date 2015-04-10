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

%% Loop through each image and bgs
% Assume colored images are in the workspace as images{}
%

prefix = '../ImageSet5/sil';
format = '.jpg';

% for ii=1:size(images,2)
for ii=33:34
    image = images{ii};
    colorEdge = coloredges(image);
    [~, thresh] = edge(colorEdge, 'canny');
    bwEdge = edge(colorEdge, 'canny', thresh);
    [xs, ys] = img2col(bwEdge);
    [sx, sy, sidx] = lasso(xs, ys);
    bwSil = col2img(sx, sy, size(image,2), size(image,1));
    filledImg = fillImg(bwSil);
    filename = [prefix num2str(ii) format];
    imwrite(filledImg, filename);
end