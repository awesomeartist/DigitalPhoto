[filename,pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'ѡ��ͼƬ');
if isequal(filename,0) || isequal(pathname,0)
    errordlg('����û��ѡȡͼƬ����', '��ܰ��ʾ'); %���û�����룬�򴴽�����Ի���
    return ;
else
    file_path = [pathname,filename];
    image_init = imread(file_path);
    subplot(2, 1, 1)
    imshow(image_init),title("ԭͼ��");
    subplot(2, 1, 2)
    imhist(image_init),title("�Ҷ�ֱ��ͼ"); 
end

% ��������
c = [100 100 160 160];
r = [100 160 100 160];
% B = roipoly(im, c, r);
B = image_init(98:158, 98:158);
B = double(B);
% ��ͼ���������ľ�ֵ�ͷ���
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