% 图像锐化

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
w = fspecial('average',[3,3]); % 3*3 均值滤波
image_filter_mean = imfilter(image_noise_gaussian, w);

% 对图像进行锐化处理
image_for_sharpen = image_gray;

% 梯度锐化
T = 50;    % 阈值
[R, C] = size(image_gray);
image_sharpen_grad = uint8(zeros(R, C));
for i = 2 : R-1
    for j = 2 : C-1
        grad = abs(image_for_sharpen(i+1,j)-image_for_sharpen(i,j)) ...
                                  + abs(image_for_sharpen(i,j+1)-image_for_sharpen(i,j));
        if grad < T
            image_sharpen_grad(i,j) = image_for_sharpen(i, j);
        else
            image_sharpen_grad(i,j) =  grad + image_for_sharpen(i, j);
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

% prewitt 算子锐化


subplot(2, 4, 1)
imshow(image_init), title("原图")
subplot(2, 4, 2)
imshow(image_noise_gaussian), title("加入高斯噪声")
subplot(2, 4, 3)
imshow(image_filter_mean), title("均值滤波")
subplot(2, 4, 5)
imshow(image_sharpen_grad), title("梯度锐化")
subplot(2, 4, 6)
imshow(uint8(image_sharpen_laplacian)), title("laplacian 算子锐化")




