% 伪彩色处理
image_init = imread('./IMG-2/06.tif');
n = ndims(image_init);
if n > 2
    image = rgb2grad(image_init);
else
    image = image_init;
end

[m,n] = size(image);
J = double(image);
L = 256;
for i = 1:m
    for j = 1:n
        if J(i,j) < L/4
            R(i,j) = 0;
            G(i,j) = 4*J(i,j);
            B(i,j) = L;
        elseif J(i,j) < L/2
            R(i,j) = 0;
            G(i,j) = L;
            B(i,j) = -4*(J(i,j)-L/2);
        elseif J(i,j) < 3*L/4
            R(i,j) = 4*(J(i,j)-L/2);
            G(i,j) = L;
            B(i,j) = 0;
        else
            R(i,j) = L;
            G(i,j) = -4*(J(i,j)-L);
            B(i,j) = 0;
        end
    end
end
image_color = repmat(image,[1 1 3]);
for i = 1:m
    for j = 1:n
        image_color(i,j,1) = R(i,j);
        image_color(i,j,2) = G(i,j);
        image_color(i,j,3) = B(i,j);
    end
end

subplot(1, 2, 1)
imshow(image),title("原图像");
subplot(1, 2, 2)
imshow(image_color),title("伪彩色处理后");
