% ����߶�̬ͼƬ����ʾ����Сͼ��̬��Χ
org = load('./IMG-1/hdr_atrium.mat');
subplot(1, 2, 1);
hdr_img = cell2mat(struct2cell(org));
imshow(hdr_img);
title('�߶�̬ͼ��ԭͼ');

% rgb = tonemap(org);
gray = rgb2gray(hdr_img);
ma = max(max(gray));
mi = min(min(gray));
img = imadjust(gray, [mi ma], [0 1], 0.5);
subplot(1, 2, 2);
imshow(img);
title('�ݴα任��ͼ��(gamma=0.5)');