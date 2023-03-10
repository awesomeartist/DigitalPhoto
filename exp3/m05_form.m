
image_init = imread("./IMG-3/img7.tif");
image = image_init;

se = strel('disk',7');
se1 = strel('disk',10');
se2 = strel('disk',15');
result = imclose(image,se2);
result = imerode(result,se);
result = imerode(result,se);
result = imdilate(result,se);

subplot(1, 2, 1)
imshow(image),title('before recover');
subplot(1, 2, 2)
imshow(result),title('after recover');