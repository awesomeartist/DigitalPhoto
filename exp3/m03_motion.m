image_init = imread("./IMG-3/img5.tif");
image = image_init;

% ���45�ȷ����ƶ�10���ص��˶�ģ��
PSF = fspecial('motion', 10, 45);
image_motion_blur = imfilter(image, PSF,'conv', 'circular');

% ��Ӿ�ֵ 0 ������ 0.5 �ĸ�˹����
image_motion_gaussian = imnoise(image_motion_blur, 'gaussian',0,0.5);

image_out2 = deconvwnr(image_motion_blur, PSF, 0);

image_out4 = deconvwnr(image_motion_gaussian, PSF, 0.5);

subplot(2, 4, 1)
imshow(image),title("ԭͼ��");
subplot(2, 4, 2)
imshow(image_motion_blur),title("����˶�ģ��");
subplot(2, 4, 3)
imshow(image_motion_gaussian),title("����˶�ģ���͸�˹����");
subplot(2, 4, 6)
imshow(image_out2),title("ԭͼ��");
subplot(2, 4, 8)
imshow(image_out4),title("ԭͼ��");