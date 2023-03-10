% ͼ������
%% ֱ��ʵ��ͼ������
image_init = imread('./IMG-2/lena.jpg'); % ��ȡͼ��
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

[R, C] = size(image_gray); % ��ȡͼ���С
timesX = 0.5; % X��������
timesY = 0.5; % Y��������
image_out = zeros(timesX * R, timesY * C); % ����������ÿ�����ص�Ĭ�ϳ�ʼ��Ϊ0����ɫ��
tras = [1/timesX 0 0; 0 1/timesY 0; 0 0 1]; % ���ŵı任���� 

for i = 1 : timesX * R
    for j = 1 : timesY * C
        temp = [i; j; 1];
        temp = tras * temp; % ����˷�
        x = uint8(temp(1, 1));
        y = uint8(temp(2, 1));
        % �任���λ���ж��Ƿ�Խ��
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

%% imtransform ����ʵ��ͼ������
image_init = imread('./IMG-2/lena.jpg'); % ��ȡͼ��
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