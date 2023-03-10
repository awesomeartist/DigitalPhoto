image_init=imread("./IMG-2/lena.jpg");

n = ndims(image_init);
if n > 2
    image = rgb2gray(image_init);
else
    image = image_init;
end


F = fft2(image);
F1 = log(abs(F)+1);   %取模并进行缩放
Fs = fftshift(F);      %将频谱图中零频率成分移动至频谱图中心

subplot(2, 3, 1)
imshow(image),title("原图像灰度图");
subplot(2, 3, 2),title("傅里叶频谱");
imshow(Fs);