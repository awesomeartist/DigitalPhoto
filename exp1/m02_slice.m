% ͼ����Ƭ����ʾ 8 ��λƽ��ͼ��

org = imread("./IMG-1/lena.jpg");
gray = double(rgb2gray(org));
[m,n] = size(gray);
sgtitle('ͼ����Ƭ');
subplot(3, 3, 1);
imshow(gray,[]);
title('ԭʼͼ��');
temp = zeros(size(gray) ,'like', gray);

% bitget�������Ƚ�X(i,j)���Ҷ�ֵ�ֽ�Ϊ�����ƴ���Ȼ��ȡ��kλ
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
