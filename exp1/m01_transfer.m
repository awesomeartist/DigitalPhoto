% ͼ�����Ժͷ����Ա任

org = imread("./IMG-1/2.jpg");
figure("Name","Tansfer");
sgtitle('ͼ������/�����Ա任');
subplot(3, 2, [1, 2]);
imshow(org);
title('orgin');

x = ndims(org);
if x>2
    img = rgb2gray(org);
else
    img = org;
end

ma = max(max(img));
mi = min(min(org));

% ��ʹ�� imadjust ʵ�����Ա任
out1 = (img-mi)*(255/double(ma-mi));  
subplot(3, 2, 3);
imshow(out1);
title('���Ա任');

% ʹ�� imadjust ʵ�����Ա任
out2 = imadjust(img, [double(mi)/255 double(ma)/255], [0 1]);
subplot(3, 2, 4);
imshow(out2);
title('imadjust ���Ա任');

% ��ʹ�� imadjust ʵ�ַ����Ա任
out3 = im2double(img);
out3 = sqrt(out3);
subplot(3, 2, 5);
imshow(out3);
title('�����Ա任');

% ʹ�� imadjust ʵ�ַ����Ա任
out4 = imadjust(img, [double(mi)/255 double(ma)/255], [0 1], 0.5);
subplot(3, 2, 6);
imshow(out4);
title('imadjust �����Ա任');     
        