
image_init = imread("./IMG-3/img6.tif");
image = image_init;

se = strel('disk', 2');
se1 = strel('square', 2');
fc = imclose(image, se);
fo = imopen(image, se);
result = imerode(fo, se1);
result1 = imclose(fc, se);

subplot(1, 2, 1)
imshow(image),title('original piture'); 
subplot(1, 2, 2)
imshow(result1),title('after recover');

 