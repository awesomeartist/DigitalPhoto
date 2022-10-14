function [out,mse] = colorquanz(im, n1, n2, n3)
d=[n1,n2,n3];
[m,n,~]=size(im);
%out=zeros(m,n,3);
for i=1:3
    for j=1:m
        for k=1:n
            x=floor(im(j,k,i)/d(i));
            out(j,k,i)=(2*x+1)*d(i)/2;
        end
    end
end
sum=0;
for i=1:3
    for j=1:m
        for k=1:n
           sum=sum+out(j,k,i)-im(j,k,i);
        end
    end
end
mse=sum/(m*n);
    
