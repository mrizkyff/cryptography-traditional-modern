clear;
clc;
% membaca gambar grayscale
c = imread('earth.bmp');  %The path for the grayscale bmp cover image

% membaca pesan dari file 
id = fopen('secret_message.txt', 'r');
spec = '%c'; %c = character
%membaca message dengan id diatas dan specnya itu character
message = fscanf(id,spec);  

% dikali 8 bit karena 1 char itu adalah 8 bit, butuh 8 kali penyisipan
% setiap character nya
m = length(message) * 8;

% Message in Ascii int form
%merubah message ke bentuk angka ascii 8 (maks 2^8 atau 255)
ascii = uint8(message);

%untuk merubah ascii ke binary 8 bit kemudian transpose
binary = transpose(dec2bin(ascii,8));

%untuk merubah menjadi 1 dimensi matriks
binary = binary(:);


LSB=0;
%hitung panjang binary
num = length(binary);

%dikurangi 48 agar menjadi 0 dan 1 double
b = binary - 48;

%assign s = nilai c
s = c;

%mencari ukuran gambar tinggi dan lebar
height = size(c,1);
width = size(c,2);

%counter untuk menghitung bit pesan
k = 1;

%looping untuk menyisipkan
for i = 1 : width
    for j = 1 : height
        %untuk cek nilai bit paling belakang apakah 1(ganjil) kalo 0(genap)
        LSB = mod(double(c(j,i)), 2);
        %cek apakah message sudah habis?
        %k>m berarti messagenya sudah habis maka bit piksel tidak ada perubahan
        %nilai bit terakhir (var LSB) nilainya sama dengan bit pada pesan
        %maka tidak ada perubahan 
        if (k>m || LSB == b(k))
            %tidak ada perubahan bit
            s(j,i) = c(j,i);
        else
            %kalau bit image dengan bit pesan beda, ada pergantian
            s(j,i)=c(j,i)+b(k) -LSB;
        end
        %increment k counter
         k = k + 1;     
    end
end
      
% Write image
%pesan
disp('Done encoding message');
%menyimpan hasil lsb 
imwrite(s,'encodedImg.bmp','bmp'); %write the new image with the hidden image in it to 's' or disk.


    
   