% ͼ����

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
w = fspecial('average',[3,3]); % 3*3 ��ֵ�˲�
image_filter_mean = imfilter(image_noise_gaussian, w);

% ��ͼ������񻯴���
image_for_sharpen = image_gray;

% �ݶ���
T = 50;    % ��ֵ
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

% laplacian ������
% ʹ��laplacian����ͼ���񻯣��ù��̻������ֵ�������Ҫʹ��double����
Ig2 = double(image_for_sharpen); %��fת����һ����double��ͼ��Ȼ������˲�  
w = fspecial('laplacian', 0);  
g1 = imfilter(Ig2, w, 'replicate');  
image_sharpen_laplacian = Ig2 - g1;  

% sobel ������

% prewitt ������


subplot(2, 4, 1)
imshow(image_init), title("ԭͼ")
subplot(2, 4, 2)
imshow(image_noise_gaussian), title("�����˹����")
subplot(2, 4, 3)
imshow(image_filter_mean), title("��ֵ�˲�")
subplot(2, 4, 5)
imshow(image_sharpen_grad), title("�ݶ���")
subplot(2, 4, 6)
imshow(uint8(image_sharpen_laplacian)), title("laplacian ������")




