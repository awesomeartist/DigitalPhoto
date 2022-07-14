%{
程序说明：
1、读入图像，使用imfinfo获取图像信息后显示图像信息
2、分别通过RGB和HSV两种色彩模型显示图像
3、保存图像为'lena.jpg'
%}

% image path
path = "./IMG-1/lena.png";

% load photo
RGB  = imread(path);

% show information of photo
info = imfinfo(path);
disp(info);

% Split all channels of photo
R = RGB(:, :, 1);
G = RGB(:, :, 2);
B = RGB(:, :, 3);
allBlack = zeros(size(RGB(:,:,1)),class(RGB));
justR = cat(3,R,allBlack,allBlack);
justG = cat(3,allBlack,G,allBlack);
justB = cat(3,allBlack,allBlack,B);

% Show all channels of photo
figure("Name","Show 1.ipg");
subplot(2, 2, 1);
imshow(RGB);
title('RGB');

subplot(2, 2, 2);
% imshow(R);
imshow(justR);
title('R');

subplot(2, 2, 3);
% imshow(G);
imshow(justG);
title('G');

subplot(2, 2, 4);
% imshow(B);
imshow(justB);
title('B');

% Show by HSV model
HSV = rgb2hsv(RGB);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);

figure('Name','Show by HSV');
subplot(2, 2, 1);
imshow(HSV);
title(HSV);

subplot(2,2,2);
imshow(H);
title('H');

subplot(2,2,3);
imshow(S);
title('S');

subplot(2,2,4);
imshow(V);
title('V');

% save '12.jpg' as 'save.png'
imwrite(RGB,'./IMG-1/lena.jpg');