image_init = imread("./IMG-3/img5.tif");
image = image_init;

% 添加45度方向移动10像素的运动模糊
PSF = fspecial('motion', 10, 45);
image_motion_blur = imfilter(image, PSF,'conv', 'circular');

% 添加均值 0 ，方差 0.5 的高斯噪声
image_motion_gaussian = imnoise(image_motion_blur, 'gaussian',0,0.5);

image_out2 = deconvwnr(image_motion_blur, PSF, 0);

image_out4 = deconvwnr(image_motion_gaussian, PSF, 0.5);

subplot(2, 4, 1)
imshow(image),title("原图像");
subplot(2, 4, 2)
imshow(image_motion_blur),title("添加运动模糊");
subplot(2, 4, 3)
imshow(image_motion_gaussian),title("添加运动模糊和高斯噪声");
subplot(2, 4, 6)
imshow(image_out2),title("原图像");
subplot(2, 4, 8)
imshow(image_out4),title("原图像");