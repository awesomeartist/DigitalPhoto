% ͼ��ƽ��

%% ֱ��ʵ��ͼ��ƽ��
image_init = imread('./IMG-2/lena.jpg');                % ��ȡͼ��
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

[R, C] = size(image_gray);                              %����Ҷ�ͼ�Ĵ�С��r��ʾ�У�c��ʾ�У���ͨ��size�������Ҷ�ͼI���������ھ����r�У��������ھ����c�У�������֪���Ҷ�ͼ�Ĵ�С��r��c
image_out = zeros(R,C);                                 %����r��c��0����ƽ�ƽ�����󣩣���ʼ��Ϊ�㣨��ɫ��
delX = 40;                                              %ƽ�Ƶ�x����ľ��룬��������ֱ����
delY = 40;                                              %ƽ�Ƶ�y����ľ��룬������ˮƽ����
tras = [1 0 delX; 0 1 delY; 0 0 1];                     %ƽ�Ʊ任����

for i = 1:R
    for j = 1:C
        temp = [i; j; 1];                               %�Ҷ�ͼIҪƽ�Ʊ任�ĵ㣬�����þ����ʾ
        temp = tras * temp;                             %������ˣ��õ�����һ�еľ���temp����ƽ�ƺ�ľ���
        x = temp(1, 1);                                 %�Ѿ���temp�ĵ�һ�е�һ�е�Ԫ�ظ�x   
        y = temp(2, 1);                                 %�Ѿ���temp�ĵڶ��е�һ�е�Ԫ�ظ�y 
        if(x >= 1 && x <= R) && (y >= 1 && y <= C)      %�ж����任��õ��ĵ��Ƿ�Խ��
            image_out(x, y) = image_gray(i, j);         %�õ�ƽ�ƽ�����󣬵�(x,y)���ɵ�(i,j)ƽ�ƶ����ģ��ж�Ӧ��ϵ 
        end
    end
end
subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));

%% imtransform ����ʵ��ͼ��ƽ��

image_init = imread('./IMG-2/lena.jpg');                % ��ȡͼ��
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end

xform = [1 0 55; 0 1 55; 0 0 1]';
Ic = maketform('affine', xform); 
image_out = imtransform(image_gray, Ic, 'XData', ...
    [1 (size(image_gray, 2) + xform(3, 1))], 'YData', ...
    [1 (size(image_gray, 1) + xform(3, 2))], 'FillValues', 255);

subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));