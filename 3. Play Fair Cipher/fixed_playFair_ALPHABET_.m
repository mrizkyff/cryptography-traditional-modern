%% membuat matriks kunci 5x5
clc
clear
kunci = 'STANDERCHBK'


%menghilangkan duplikasi pada kunci
kunci = unique(kunci,'stable')
len_kunci = length(kunci)

for x=1:26
    alphabet(x) = x+64
end

% menghilangkan j
for x=1:26
    if(alphabet(alphabet == 'J'))
        alphabet(alphabet == 'J') = []
    end
end
char(alphabet)

% ordo
ordo = 5

% membuat matriks 
matrix_kunci = zeros(ordo,ordo)

flag = 1
flag_alpha = 1


% hilangkan kunci dari alphabet
for x=1:len_kunci
    if(alphabet(alphabet == kunci(x))) 
        alphabet(alphabet == kunci(x)) = []
    end
end

char(alphabet)

% mengisi matriks kunci dengan kunci + alphabet
for x=1:ordo
    for y=1:ordo
        if~(flag == len_kunci+1)
            matrix_kunci(x,y) = kunci(flag)
            flag = flag+1
        else
            matrix_kunci(x,y) = alphabet(flag_alpha)
            flag_alpha = flag_alpha + 1
        end
        
    end
end
char(matrix_kunci)
%% menghilangkan j dari plaintext
plaintext = 'TR'
p = plaintext
for x=1:length(plaintext)
    if(plaintext(x) == 'J')
        plaintext(x) = 'I'
    end
end

% menambahkan dummy jika ganjil
if mod((length(plaintext)),2) == 1
    plaintext(length(plaintext)+1) = 'Z'
end

% menambahkan z pada huruf yang sama
flag = 1
for x=1:2:length(plaintext)
    if(plaintext(x) == plaintext(x+1))
        plaintext = [plaintext(1:x) 'Z' plaintext(x+1:end)]
    end
end

% menambahkan dummy jika ganjil
if mod((length(plaintext)),2) == 1
    plaintext(length(plaintext)+1) = 'Z'
end

%% membuat bigram
part = []
flag = 1

for x=1:(length(plaintext)/2)
    for y=1:2
        part(x,y) = plaintext(flag)
        flag = flag + 1
    end
end
char(part)

%% proses enkripsi
playfair = []

% pencarian kolom
flag = 1
flag_part = 1
for x=1:(length(plaintext)/2)
    for y=1:1
        disp(char(part(x,y)))
        disp(char(part(x,y+1)))
        [index_baris1 index_kolom1] = find(matrix_kunci == part(x,y))
        [index_baris2 index_kolom2] = find(matrix_kunci == part(x,y+1))
        bar1 = index_baris1
        bar2 = index_baris2
        col1 = index_kolom1
        col2 = index_kolom2
%         pencarian kolom (jika kolom sama)
        if(index_kolom1 == index_kolom2)
            disp('KOLOM')
            index_baris1 = bar1 + 1
            index_baris2 = bar2 + 1
            
            if(index_baris1 == 6)
                index_baris1 = 1
            elseif(index_baris2 == 6)
                index_baris2 = 1
            end
        
%       pencarian baris (jika baris sama)
        elseif(index_baris1 == index_baris2)
            disp('BARIS')
            bar1 = index_baris1
            bar2 = index_baris2
            col1 = index_kolom1
            col2 = index_kolom2
            
            index_kolom1 = col1 + 1
            index_kolom2 = col2 + 1
            
            if(index_kolom1 == 6)
                index_kolom1 = 1
            elseif(index_kolom2 == 6)
                index_kolom2 = 1
            end
        else
            
%       pencarian jika tidak sama baris dan kolom
            disp('CROSS')
            bar1 = index_baris1
            bar2 = index_baris2
            col1 = index_kolom1
            col2 = index_kolom2
            index_baris1 = index_baris1
            index_kolom1 = col2
            index_baris2 = bar2
            index_kolom2 = col1
        end
        
%         penyusunan playfair
        playfair(flag) = matrix_kunci(index_baris1,index_kolom1)
        playfair(flag+1) = matrix_kunci(index_baris2,index_kolom2)
        
    end
    flag = flag + 2
end

disp(char(playfair))


%% membuat bigram dekripsi
part_decrypt = []
flag = 1

for x=1:(length(playfair)/2)
    for y=1:2
        part_decrypt(x,y) = playfair(flag)
        flag = flag + 1
    end
end
char(part_decrypt)

%% proses dekripsi
decrypt_plaintext = []

% pencarian kolom
flag = 1
flag_part = 1
for x=1:(length(playfair)/2)
    for y=1:1
%         disp(char(part_decrypt((x,y)))
%         disp(char(part_decrypt(x,y+1)))
        [index_baris1 index_kolom1] = find(matrix_kunci == part_decrypt(x,y))
        [index_baris2 index_kolom2] = find(matrix_kunci == part_decrypt(x,y+1))
%         pencarian kolom (jika kolom sama)
        if(index_kolom1 == index_kolom2)
            disp('KOLOM')
            bar1 = index_baris1
            bar2 = index_baris2
            col1 = index_kolom1
            col2 = index_kolom2
            
            index_baris1 = bar1 - 1
            index_baris2 = bar2 - 1
            
            if(index_baris1 < (1))
                index_baris1 = 5
            elseif(index_baris2 < (1))
                index_baris2 = 5
            end
            
%             SUSUN
            decrypt_plaintext(flag) = matrix_kunci(index_baris1,index_kolom1)
            decrypt_plaintext(flag+1) = matrix_kunci(index_baris2,index_kolom2)
        
%       pencarian baris (jika baris sama)
        elseif(index_baris1 == index_baris2)
            disp('BARIS')
            bar1 = index_baris1
            bar2 = index_baris2
            col1 = index_kolom1
            col2 = index_kolom2
            
            index_kolom1 = col1 - 1
            index_kolom2 = col2 - 1
            
            if(index_kolom1 < (1))
                index_kolom1 = 5
            elseif(index_kolom2 < (1))
                index_kolom2 = 5
            end
            
%             SUSUN
            decrypt_plaintext(flag) = matrix_kunci(index_baris1,index_kolom1)
            decrypt_plaintext(flag+1) = matrix_kunci(index_baris2,index_kolom2)
        else
            
%       pencarian jika tidak sama baris dan kolom
            disp('CROSS')
            bar1 = index_baris1
            bar2 = index_baris2
            col1 = index_kolom1
            col2 = index_kolom2
            index_baris1 = bar2
            index_kolom1 = col1
            index_baris2 = bar1
            index_kolom2 = col2
            
%             SUSUN
        decrypt_plaintext(flag) = matrix_kunci(index_baris2,index_kolom2)
        decrypt_plaintext(flag+1) = matrix_kunci(index_baris1,index_kolom1)
        end
        
%         penyusunan playfair
%         decrypt_plaintext(flag) = matrix_kunci(index_baris2,index_kolom2)
%         decrypt_plaintext(flag+1) = matrix_kunci(index_baris1,index_kolom1)
        
    end
    flag = flag + 2
end

% menggabungkan part menjadi string
plain = []
flag = 1
flag_part = 1
for x=1:(length(playfair)/2)
    for y=1:1
        plain(flag) = part(x,y)
        plain(flag+1) = part(x,y+1)
    end
    flag = flag + 2
end
% cetak
fprintf('Kunci \t\t\t\t\t\t\t\t\t: %s',kunci)
fprintf('\nPlaintext \t\t\t\t\t\t\t\t: %s', p)
fprintf('\nPlaintext Setelah Dibuat Bigram \t\t: %s', plain)
fprintf('\nPlayfair Ciphertext Setelah Encrypt \t: %s',char(playfair))
fprintf('\nPlaintext Setelah Decrypt \t\t\t\t: %s',char(decrypt_plaintext))
fprintf('\n')