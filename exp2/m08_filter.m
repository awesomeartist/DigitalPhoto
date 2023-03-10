% 倒数加权平均处理
image_init = imread('./IMG-2/02.tif');
n = ndims(image_init);
if n > 2
    image = rgb2gray(image_init);
else
    image = image_init;
end


img_in = image;
filter = zeros(3,3);
%edges implement zeros
[m,n] = size(img_in);
[mf,nf] = size(filter);
kk = (mf - 1) / 2;
k = ceil(kk);
img_tmp = zeros(m+2*k, n+2*k);
%output the image img_out
img_out = zeros(m, n);
%fundamental contents
for i = 1+k : m+k
    for j = 1+k : n+k
        img_tmp(i, j) = img_in(i-k, j-k);
    end
end
%up&down edges
for i = 1:k
    for j = 1:n+2*k
        img_tmp(i,j) = 0;
        img_tmp(i+m,j) = 0;
    end
end
%left&right edges
for i = 1:m+2*k
    for j = 1:k
        img_tmp(i,j) = 0;
        img_tmp(i,j+n) = 0;
    end
end

f = img_tmp;
for x = 1+k:m+k
    for y = 1+k:n+k
        window = img_tmp(x-k:x+k, y-k:y+k);
        for i=-1:1
            for j=-1:1
                if i~=0||j~=0
                    if f(x+i,y+j)~=f(x,y)
                        g(i+2,j+2) = 1/abs((f(x+i,y+j)-f(x,y)));
                    else
                        g(i+2,j+2) = 2;
                    end
                end
            end
        end
        g(2,2) = 2;
        for i=-1:1
            for j=-1:1
                if i~=0||j~=0
                    W(i+2,j+2) = g(i+2,j+2)/2/sum(sum(g));
                end
            end
        end
        W(2,2) = 1/2;
        coeff = sum(W(:));
        temp1 = double(W).*double(window);
        temp2 = sum(temp1(:))/coeff;
        img_out(x-k,y-k) = temp2;
    end
end

image_filter_out = uint8(img_out);
subplot(1, 2, 1)
imshow(image),title("原图像");
subplot(1, 2, 2)
imshow(image_filter_out),title("倒数加权平均处理");