org = imread('./IMG-1/6.tif');
sgtitle('图像均衡化');
subplot(2, 2, 1);
imshow(org);
title('原图');

subplot(2, 2, 2);
imhist(org);
title('原图像直方图');

img = histeq(org);
subplot(2, 2, 3);
imshow(img);
title('均衡化后图像');

subplot(2, 2, 4);
imhist(img);
title('均衡化后图像直方图');

