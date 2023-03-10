% 图像缩放
%% 直接实现图像缩放
image_init = imread('./IMG-2/lena.jpg'); % 读取图像
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

[R, C] = size(image_gray); % 获取图像大小
timesX = 0.5; % X轴缩放量
timesY = 0.5; % Y轴缩放量
image_out = zeros(timesX * R, timesY * C); % 构造结果矩阵。每个像素点默认初始化为0（黑色）
tras = [1/timesX 0 0; 0 1/timesY 0; 0 0 1]; % 缩放的变换矩阵 

for i = 1 : timesX * R
    for j = 1 : timesY * C
        temp = [i; j; 1];
        temp = tras * temp; % 矩阵乘法
        x = uint8(temp(1, 1));
        y = uint8(temp(2, 1));
        % 变换后的位置判断是否越界
        if (x <= R) && (y <= C) && (x >= 1) && (y >= 1)
            image_out(i, j) = image_gray(x, y);
        end
    end
end

subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));

%% imtransform 函数实现图像缩放
image_init = imread('./IMG-2/lena.jpg'); % 读取图像
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

Ib = maketform('affine', [5 0 0; 0 10 0; 0 0 1]); 
image_out = imtransform(image_gray, Ib);

subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));