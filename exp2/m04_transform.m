% Í¼ÏñË®Æ½·­×ª

image_init = imread('./IMG-2/lena.jpg');
n = ndims(image_init);
if n > 2
    image_gray = rgb2gray(image_init);
else
    image_gray = image_init;
end
[R, C] = size(image_gray);
image_out = zeros(R, C);

for i = 1 : R
    for j = 1 : C
        x = i;
        y = C - j + 1;
        image_out(x, y) = image_gray(i, j);
    end
end


subplot(1, 2, 1)
imshow(image_init);
title("origin")
subplot(1, 2, 2)
imshow(uint8(image_out));