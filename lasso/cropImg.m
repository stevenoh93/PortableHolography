%% Read images with prefixes of certain format.
%  Returns cells each containing b/w images with edge detection

imgPre = 'obj';
imgType = '.jpg';
N = 14;
fudge = 1;

images = cell(1,N);

for ii=1:N
    img = imread([imgPre num2str(ii) imgType]); % Read image
    img = img(300:900,550:1300,2);              % Crop/To b/w
    [~,thresh] = edge(img,'sobel');             % Edge detect and save
    bws = edge(img,'sobel',thresh*fudge);
    images{ii} = bws;
end
