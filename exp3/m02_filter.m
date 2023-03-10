image_init = imread("./IMG-3/img4.tif");
image = image_init;

%均值滤波
%n=input('请输入均值滤波器模板大小\n');
A = fspecial('average',3); %生成系统预定义的3X3滤波器
image_filter_mean = filter2(A, image)/255;

%几何均值滤波
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

%谐波均值滤波
I_D = im2double(image);
[MM, NN] = size(I_D);
%定义子窗口的尺寸
m = 5;
n = 5;
%确定要扩展的行列数
len_m = floor(m/2);
len_n = floor(n/2);
%将原始图像进行扩展，这里采用了镜像扩展，以进行图像边缘计算
I_D_pad = padarray(I_D, [len_m,len_n], 'symmetric');
%获得扩展后的图像尺寸
[M, N] = size(I_D_pad);
J_Harmonic = zeros(MM, NN);
%逐点计算子窗口的谐波平均
for i = 1+len_m:M-len_m
    for j = 1+len_n:N-len_n
        %从扩展图像中取出子图像
        Block = I_D_pad(i-len_m:i+len_m, j-len_n:j+len_n);
        %求子窗口的谐波平均
        s = sum(sum(1./Block));
        J_Harmonic(i-len_m,j-len_n) = m*n/s;
    end
end
image_filter_JH = J_Harmonic;

%逆谐波均值滤波
q = 3;
g = im2double(image);
ft = imfilter(g.^(q+1), ones(5,5), 'replicate');
ft = ft./(imfilter(g.^q, ones(5,5), 'replicate') + eps);
image_filter_replicate = im2uint8(ft);

subplot(2, 3, 1)
imshow(image_init),title("原图像");
subplot(2, 3, 3)
imshow(image_filter_mean),title("均值滤波");
subplot(2, 3, 4)
imshow(image_filter_mean2),title("几何均值滤波");
subplot(2, 3, 5)
imshow(image_filter_JH),title("谐波均值滤波");
subplot(2, 3, 6)
imshow(image_filter_replicate),title("逆谐波均值滤波");