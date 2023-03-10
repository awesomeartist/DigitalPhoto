% ͼ����ת
%% ֱ��ʵ��ͼ����ת
image_init = imread('./IMG-2/lena.jpg'); % ��ȡͼ��
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end
[R, C] = size(image_gray); % ��ȡͼ���С
image_out = zeros( R,  C); % ����������ÿ�����ص�Ĭ�ϳ�ʼ��Ϊ0����ɫ��

alfa = -15 * 3.1415926 / 180.0; % ��ת�Ƕ�
tras = [cos(alfa) -sin(alfa) 0; sin(alfa) cos(alfa) 0; 0 0 1]; % ��ת�ı任����

for i = 1 : R
    for j = 1 : C
        temp = [i; j; 1];
        temp = tras * temp;% ����˷�
        x = uint16(temp(1, 1));
        y = uint16(temp(2, 1));
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

%% imtransform ����ʵ��ͼ����ת
image_init = imread('./IMG-2/lena.jpg'); % ��ȡͼ��
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