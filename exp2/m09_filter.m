% 同态滤波增强

image_init = imread("./IMG-2/03.tif");
n = ndims(image_init);
if n > 2
    image = rgb2gray(image_init);
else   
    image = image_init;
end


image_filter_homo = HomoFilter(image, 2, 0.25, 1, 80);

subplot(1, 2, 1)
imshow(image),title("原图像");
subplot(1, 2, 2)
imshow(image_filter_homo),title("同态滤波增强后");

