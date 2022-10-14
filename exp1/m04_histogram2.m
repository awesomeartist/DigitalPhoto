org1 = imread('./IMG-1/7.tif');
org2 = imread('./IMG-1/71.tif');
sgtitle('图像规定化');
subplot(3, 2, 1);
imshow(org1);
title('原图');

subplot(3, 2, 2);
imhist(org1);
title('原图像直方图');

subplot(3, 2, 3);
imshow(org2);
title('参考图像');

subplot(3, 2, 4);
imhist(org2);
title('参考图像直方图');

img = histeq(org1, imhist(org2));
subplot(3, 2, 5);
imshow(img);
title('规定化后图像');

subplot(3, 2, 6);
imhist(img);
title('规定化后图像直方图');
