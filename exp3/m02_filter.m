image_init = imread("./IMG-3/img4.tif");
image = image_init;

%��ֵ�˲�
%n=input('�������ֵ�˲���ģ���С\n');
A = fspecial('average',3); %����ϵͳԤ�����3X3�˲���
image_filter_mean = filter2(A, image)/255;

%���ξ�ֵ�˲�
[R, C] = size(image_init);
fsize1=3;
fssize1=(fsize1-1)/2;
image_filter_mean2 = image;
for x = 1+fssize1:1:R-fssize1
    for y = 1+fssize1:1:R-fssize1
        is = image(x-fssize1:1:x+fssize1,y-fssize1:1:y+fssize1);
        image_filter_mean2(x,y) = prod(prod(is(:)))^(1/numel(is)); 
    end
end

%г����ֵ�˲�
I_D = im2double(image);
[MM, NN] = size(I_D);
%�����Ӵ��ڵĳߴ�
m = 5;
n = 5;
%ȷ��Ҫ��չ��������
len_m = floor(m/2);
len_n = floor(n/2);
%��ԭʼͼ�������չ����������˾�����չ���Խ���ͼ���Ե����
I_D_pad = padarray(I_D, [len_m,len_n], 'symmetric');
%�����չ���ͼ��ߴ�
[M, N] = size(I_D_pad);
J_Harmonic = zeros(MM, NN);
%�������Ӵ��ڵ�г��ƽ��
for i = 1+len_m:M-len_m
    for j = 1+len_n:N-len_n
        %����չͼ����ȡ����ͼ��
        Block = I_D_pad(i-len_m:i+len_m, j-len_n:j+len_n);
        %���Ӵ��ڵ�г��ƽ��
        s = sum(sum(1./Block));
        J_Harmonic(i-len_m,j-len_n) = m*n/s;
    end
end
image_filter_JH = J_Harmonic;

%��г����ֵ�˲�
q = 3;
g = im2double(image);
ft = imfilter(g.^(q+1), ones(5,5), 'replicate');
ft = ft./(imfilter(g.^q, ones(5,5), 'replicate') + eps);
image_filter_replicate = im2uint8(ft);

subplot(2, 3, 1)
imshow(image_init),title("ԭͼ��");
subplot(2, 3, 3)
imshow(image_filter_mean),title("��ֵ�˲�");
subplot(2, 3, 4)
imshow(image_filter_mean2),title("���ξ�ֵ�˲�");
subplot(2, 3, 5)
imshow(image_filter_JH),title("г����ֵ�˲�");
subplot(2, 3, 6)
imshow(image_filter_replicate),title("��г����ֵ�˲�");