%% Read images with prefixes of certain format.
%  Returns cells each containing b/w images with edge detection

imgPre = 'img360';
imgType = '.jpg';
N = 18;
fudge = 1;
xoff = 150;
yoff = 500;

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
