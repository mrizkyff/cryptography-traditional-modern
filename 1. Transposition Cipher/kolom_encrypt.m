function [ciphertext] = kolom_encrypt(kunci, plaintext)
% input kunci dan plaintext
% kunci = 'A11.2017.10492'
kunci = double(kunci)
% plaintext = 'MUHAMADRIZKYFAJARFEBRIAN^-^Ditambahin_bEn_tAMBAh_PanjanG_daN_AngelFP-87-94-93-94-MB114.125.9.97'
plaintext = double(plaintext)
column = [];
flag = 1

% menambahkan huruf ke plaintext
for z = length(plaintext)+1:(length(kunci)*ceil(length(plaintext)/length(kunci)))
    plaintext(z)='x'
end

% menambahkan setiap karakter di dalam plaintext ke dalam column
disp(length(plaintext))
disp(length(kunci))
for x = 1:ceil(length(plaintext)/length(kunci))
     for y = 1:length(kunci)
         column(x,y) = (plaintext(flag))
         flag = flag+1
     end
end
disp(char(column))

% menyimpan hasilnya variabel ciphertext
ciphertext = []

% cek kunci ada yang sama atau tidak
kunci_dec = double(kunci)
inc = 0.01
flg = 0
for i = 1:length(kunci)
    for j = i:length(kunci)
        disp('----------')
        if(kunci_dec(j) == kunci_dec(i))
            kunci_dec(i) = kunci_dec(i) + inc
            inc = inc + 0.1
        end
    end
end

kunci_dec

    

%% 

% mencari kunci dari yang abjad paling awal
panjang_kunci = length(kunci)
for i = 1:panjang_kunci
    
%     mencari nilai minimum dari kunci untuk urutan pengambilan kolom
    minimum = min(kunci_dec)
%     seti nilai minimum yang dilewati agar menjadi maks supaya tidak
%     dihitung lagi
    maximum = max(kunci_dec)
%     mencari index nilai minimum
    index = find(kunci_dec==min(kunci_dec))
    
%     menampung kolom yang diambil didalam variable ciphertext
    for a = 1:ceil(length(plaintext)/panjang_kunci)
%         (a,i) sama dengan (a,index) karena mengambil data nya urut
%         berdasarkan index terkecil
            ciphertext(a,i) = column(a,index)
    end
    
%     menambah nilai minimum jadi maximum+1
    kunci_dec(index) = [maximum+maximum]
    
end
disp(char(ciphertext))
ciphertext = reshape(ciphertext,1,(z))
disp('ciphertext')
disp(char(ciphertext))
