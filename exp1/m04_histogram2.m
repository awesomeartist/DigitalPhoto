org1 = imread('./IMG-1/7.tif');
org2 = imread('./IMG-1/71.tif');
sgtitle('ͼ��涨��');
subplot(3, 2, 1);
imshow(org1);
title('ԭͼ');

subplot(3, 2, 2);
imhist(org1);
title('ԭͼ��ֱ��ͼ');

subplot(3, 2, 3);
imshow(org2);
title('�ο�ͼ��');

subplot(3, 2, 4);
imhist(org2);
title('�ο�ͼ��ֱ��ͼ');

img = histeq(org1, imhist(org2));
subplot(3, 2, 5);
imshow(img);
title('�涨����ͼ��');

subplot(3, 2, 6);
imhist(img);
title('�涨����ͼ��ֱ��ͼ');
