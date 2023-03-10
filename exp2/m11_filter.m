% ÂË²¨´¦Àí

image_init = imread('./IMG-2/05.tif');
n = ndims(image_init);
if n > 2
    image = rgb2grad(image_init);
else
    image = image_init;
end

q = 3;
g = im2double(image);
ft = imfilter(g.^(q+1), ones(5,5), 'replicate');
ft = ft./(imfilter(g.^q, ones(5,5), 'replicate') + eps);
image_filter_replicate = im2uint8(ft);

subplot(1, 2, 1)
imshow(image),title("Ô­Í¼Ïñ");
subplot(1, 2, 2)
imshow(image_filter_replicate),title("ÂË²¨ºóÍ¼Ïñ");
