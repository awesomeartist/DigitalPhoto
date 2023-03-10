
image_init=imread("./IMG-2/lena.jpg");

n = ndims(image_init);
if n > 2
    image = rgb2gray(image_init);
else
    image = image_init;
end
image_noise_salt = imnoise(image, 'salt & pepper');

image_filter_min = ordfilt2(image_noise_salt, 1, ones(3,3));
   
image_filter_mid = ordfilt2(image_noise_salt, 5, ones(3,3));

image_filter_max = ordfilt2(image_noise_salt, 9, ones(3,3));

subplot(2, 3, 1)
imshow(image),title("原图像灰度图");
subplot(2, 3, 2)
imshow(image_noise_salt),title("加入椒盐噪声");
subplot(2, 3, 4)
imshow(image_filter_min),title("最小值滤波");
subplot(2, 3, 5)
imshow(image_filter_mid),title("中值滤波");
subplot(2, 3, 6)
imshow(image_filter_max),title("最大值滤波");


 