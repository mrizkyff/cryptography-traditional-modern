clear;
clc;
c = imread('earth.bmp');  %The path for the grayscale bmp cover image
id = fopen('secret_message.txt', 'r');
spec = '%c';
message = fscanf(id,spec);  
m = length(message) * 8;   
% Message in Ascii int form
ascii = uint8(message);
binary = transpose(dec2bin(ascii,8));
binary = binary(:);
LSB=0;
num = length(binary);
b = binary - 48;
% b = zeros(num,1); %b is a vector of bits       
% for k = 1:num
%     if(binary(k) == '1')
%             b(k) = 1;
%     else
%             b(k) = 0;
%     end
% end

s = c;
height = size(c,1);
width = size(c,2);
k = 1;

for i = 1 : height
    for j = 1 : width
        LSB = mod(double(c(i,j)), 2);
        if (k>m || LSB == b(k))
            s(i,j) = c(i,j);
        else
            s(i,j)=c(i,j)+b(k) -LSB;
        end
         k = k + 1;     
    end
end
      
% Write image
disp('Done encoding message');
imwrite(s,'encodedImg.bmp','bmp'); %write the new image with the hidden image in it to 's' or disk.


    
   