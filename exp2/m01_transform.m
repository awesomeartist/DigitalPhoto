% 图像平移

%% 直接实现图像平移
image_init = imread('./IMG-2/lena.jpg');                % 读取图像
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

[R, C] = size(image_gray);                              %计算灰度图的大小，r表示行，c表示列，即通过size函数将灰度图I的行数存在矩阵的r中，列数存在矩阵的c中，这样就知道灰度图的大小是r×c
image_out = zeros(R,C);                                 %建立r×c的0矩阵（平移结果矩阵），初始化为零（黑色）
delX = 40;                                              %平移的x方向的距离，这里是竖直方向
delY = 40;                                              %平移的y方向的距离，这里是水平方向
tras = [1 0 delX; 0 1 delY; 0 0 1];                     %平移变换矩阵

for i = 1:R
    for j = 1:C
        temp = [i; j; 1];                               %灰度图I要平移变换的点，这里用矩阵表示
        temp = tras * temp;                             %矩阵相乘，得到三行一列的矩阵temp，即平移后的矩阵
        x = temp(1, 1);                                 %把矩阵temp的第一行第一列的元素给x   
        y = temp(2, 1);                                 %把矩阵temp的第二行第一列的元素给y 
        if(x >= 1 && x <= R) && (y >= 1 && y <= C)      %判断所变换后得到的点是否越界
            image_out(x, y) = image_gray(i, j);         %得到平移结果矩阵，点(x,y)是由点(i,j)平移而来的，有对应关系 
        end
    end
end
subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));

%% imtransform 函数实现图像平移

image_init = imread('./IMG-2/lena.jpg');                % 读取图像
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

xform = [1 0 55; 0 1 55; 0 0 1]';
Ic = maketform('affine', xform); 
image_out = imtransform(image_gray, Ic, 'XData', ...
    [1 (size(image_gray, 2) + xform(3, 1))], 'YData', ...
    [1 (size(image_gray, 1) + xform(3, 2))], 'FillValues', 255);

subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));