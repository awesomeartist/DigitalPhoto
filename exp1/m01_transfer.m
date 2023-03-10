% 图像线性和非线性变换

org = imread("./IMG-1/2.jpg");
figure("Name","Tansfer");
sgtitle('图像线性/非线性变换');
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

% 不使用 imadjust 实现线性变换
out1 = (img-mi)*(255/double(ma-mi));  
subplot(3, 2, 3);
imshow(out1);
title('线性变换');

% 使用 imadjust 实现线性变换
out2 = imadjust(img, [double(mi)/255 double(ma)/255], [0 1]);
subplot(3, 2, 4);
imshow(out2);
title('imadjust 线性变换');

% 不使用 imadjust 实现非线性变换
out3 = im2double(img);
out3 = sqrt(out3);
subplot(3, 2, 5);
imshow(out3);
title('非线性变换');

% 使用 imadjust 实现非线性变换
out4 = imadjust(img, [double(mi)/255 double(ma)/255], [0 1], 0.5);
subplot(3, 2, 6);
imshow(out4);
title('imadjust 非线性变换');     
        