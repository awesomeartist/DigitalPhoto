[filename,pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图片');
if isequal(filename,0) || isequal(pathname,0)
    errordlg('您还没有选取图片！！', '温馨提示'); %如果没有输入，则创建错误对话框
    return ;
else
    file_path = [pathname,filename];
    image_init = imread(file_path);
    subplot(2, 1, 1)
    imshow(image_init),title("原图像");
    subplot(2, 1, 2)
    imhist(image_init),title("灰度直方图"); 
end

% 均匀区域法
c = [100 100 160 160];
r = [100 160 100 160];
% B = roipoly(im, c, r);
B = image_init(98:158, 98:158);
B = double(B);
% 求图像均匀区域的均值和方差
avg = mean2(B);
[R, C] = size(B);
sum = 0;
for i = 1:R
    for j = 1:C
    sum = sum + (B(i,j)-avg)^2;
    end
end
var = sum/(R*C-1); 
fprintf("avg = %.3f, var = %.3f\n", avg, var);