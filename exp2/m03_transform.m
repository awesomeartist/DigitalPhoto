% 图像旋转
%% 直接实现图像旋转
image_init = imread('./IMG-2/lena.jpg'); % 读取图像
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end
[R, C] = size(image_gray); % 获取图像大小
image_out = zeros( R,  C); % 构造结果矩阵。每个像素点默认初始化为0（黑色）

alfa = -15 * 3.1415926 / 180.0; % 旋转角度
tras = [cos(alfa) -sin(alfa) 0; sin(alfa) cos(alfa) 0; 0 0 1]; % 旋转的变换矩阵

for i = 1 : R
    for j = 1 : C
        temp = [i; j; 1];
        temp = tras * temp;% 矩阵乘法
        x = uint16(temp(1, 1));
        y = uint16(temp(2, 1));
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

%% imtransform 函数实现图像旋转
image_init = imread('./IMG-2/lena.jpg'); % 读取图像
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end
Ia = maketform('affine', [cosd(30) -sind(30) 0; sind(30) cosd(30) 0; 0 0 1]); 
image_out = imtransform(image_gray, Ia);

subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));