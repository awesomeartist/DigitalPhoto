% 图像锐化
%%
image_init = imread('./IMG-2/lena.jpg');
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

% 添加高斯噪声
image_noise_gaussian = imnoise(image_gray, 'gaussian' , 0, 0.025);

% 均值滤波
w = fspecial('average',[3,3]);%3*3均值滤波
image_filter_mean = imfilter(image_noise_gaussian, w);

subplot(2, 4, 1)
imshow(image_init)
title("原图")
subplot(2, 4, 2)
imshow(image_noise_gaussian)
title("加入高斯噪声")
subplot(2, 4, 3)
imshow(image_filter_mean)
title("均值滤波")
%% 

% 对图像进行锐化处理
image_for_sharpen = image_noise_gaussian;

% 梯度锐化
T = 150;% 阈值
image_sharpen_grad = zeros(R, C);
for i = 2 : R-1
    for j = 2 : C-1
        image_sharpen_grad(i,j) = abs(image_for_sharpen(i+1,j)-image_for_sharpen(i,j)) ...
                                  + abs(image_for_sharpen(i,j+1)-image_for_sharpen(i,j));
        if image_sharpen_grad(i,j) < T
            image_sharpen_grad(i,j) = 0;
        else
            image_sharpen_grad(i,j) = 255;
        end
    end
end

% laplacian 算子锐化
% 使用laplacian进行图像锐化，该过程会产生负值，因此需要使用double类型
Ig2 = double(image_for_sharpen); %将f转换归一化的double类图像，然后进行滤波  
w = fspecial('laplacian', 0);  
g1 = imfilter(Ig2, w, 'replicate');  
image_sharpen_laplacian = Ig2 - g1;  

% sobel 算子锐化
image_sharpen_sobel = edge(image_for_sharpen, 'sobel');
% prewitt 算子锐化
image_sharpen_prewitt = edge(image_for_sharpen, 'prewitt');


