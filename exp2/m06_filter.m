image_init=imread("./IMG-2/lena.jpg");

n = ndims(image_init);
if n > 2
    image = rgb2gray(image_init);
else
    image = image_init;
end


F = fft2(image);
F1 = log(abs(F)+1);   %ȡģ����������
Fs = fftshift(F);      %��Ƶ��ͼ����Ƶ�ʳɷ��ƶ���Ƶ��ͼ����

subplot(2, 3, 1)
imshow(image),title("ԭͼ��Ҷ�ͼ");
subplot(2, 3, 2),title("����ҶƵ��");
imshow(Fs);