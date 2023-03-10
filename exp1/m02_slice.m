% 图像切片，显示 8 个位平面图像

org = imread("./IMG-1/lena.jpg");
gray = double(rgb2gray(org));
[m,n] = size(gray);
sgtitle('图像切片');
subplot(3, 3, 1);
imshow(gray,[]);
title('原始图像');
temp = zeros(size(gray) ,'like', gray);

% bitget函数首先将X(i,j)处灰度值分解为二进制串，然后取第k位
for k = 1:8
    for i = 1:m
        for j = 1:n
            temp(i,j) = bitget(gray(i,j), k);
        end
    end
 subplot(3, 3, k+1);
 imshow(temp,[]);
 title("bit" + num2str(k));
end 
