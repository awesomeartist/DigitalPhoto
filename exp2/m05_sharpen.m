% ͼ����
%%
image_init = imread('./IMG-2/lena.jpg');
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

% ��Ӹ�˹����
image_noise_gaussian = imnoise(image_gray, 'gaussian' , 0, 0.025);

% ��ֵ�˲�
w = fspecial('average',[3,3]);%3*3��ֵ�˲�
image_filter_mean = imfilter(image_noise_gaussian, w);

subplot(2, 4, 1)
imshow(image_init)
title("ԭͼ")
subplot(2, 4, 2)
imshow(image_noise_gaussian)
title("�����˹����")
subplot(2, 4, 3)
imshow(image_filter_mean)
title("��ֵ�˲�")
%% 

% ��ͼ������񻯴���
image_for_sharpen = image_noise_gaussian;

% �ݶ���
T = 150;% ��ֵ
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

% laplacian ������
% ʹ��laplacian����ͼ���񻯣��ù��̻������ֵ�������Ҫʹ��double����
Ig2 = double(image_for_sharpen); %��fת����һ����double��ͼ��Ȼ������˲�  
w = fspecial('laplacian', 0);  
g1 = imfilter(Ig2, w, 'replicate');  
image_sharpen_laplacian = Ig2 - g1;  

% sobel ������
image_sharpen_sobel = edge(image_for_sharpen, 'sobel');
% prewitt ������
image_sharpen_prewitt = edge(image_for_sharpen, 'prewitt');


