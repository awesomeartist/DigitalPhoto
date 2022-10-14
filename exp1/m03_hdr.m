% 读入高动态图片并显示，减小图像动态范围
org = load('./IMG-1/hdr_atrium.mat');
subplot(1, 2, 1);
hdr_img = cell2mat(struct2cell(org));
imshow(hdr_img);
title('高动态图像原图');

% rgb = tonemap(org);
gray = rgb2gray(hdr_img);
ma = max(max(gray));
mi = min(min(gray));
img = imadjust(gray, [mi ma], [0 1], 0.5);
subplot(1, 2, 2);
imshow(img);
title('幂次变换后图像(gamma=0.5)');