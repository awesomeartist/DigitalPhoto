org = imread('./IMG-1/6.tif');
sgtitle('ͼ����⻯');
subplot(2, 2, 1);
imshow(org);
title('ԭͼ');

subplot(2, 2, 2);
imhist(org);
title('ԭͼ��ֱ��ͼ');

img = histeq(org);
subplot(2, 2, 3);
imshow(img);
title('���⻯��ͼ��');

subplot(2, 2, 4);
imhist(img);
title('���⻯��ͼ��ֱ��ͼ');

