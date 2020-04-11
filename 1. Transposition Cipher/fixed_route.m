% 
% enkripsi
% input kunci dan plaintext
kunci = 5
plaintext = 'MUHAMADRIZKYFAJARFEBRIAN^-^Ditambahin_bEn_tAMBAh_PanjanG_daN_AngelFP-87-94-93-94-MB114.125.9.97'
route = [];
flag = 1

% menambahkan huruf ke plaintext jika masih kurang
for z = length(plaintext)+1:(kunci*ceil(length(plaintext)/kunci))
    plaintext(z)='x'
end

% menambahkan setiap karakter di dalam plaintext ke dalam column
disp(length(plaintext))
disp(length(kunci))
for x = 1:kunci
     for y = 1:ceil(length(plaintext)/kunci)
         route(y,x) = (plaintext(flag))
         flag = flag+1
     end
end
disp(char(route))

% A = zeros(5,6);%You can change this mxn to whatever dims you like, be it square(m=n) or rectangular matrix.
ciphertext = []
[m,n] = size(route);
%m = no of rows
%n = no of columns
%A = matrix to be filled with spiral values
 %This code works fine. I commented an eg also below
top = 1;
bottom = m;
left = 1;
right = n; %To keep track of the four directions
value = 1;%Let us strat from 1
while true
    %Then Bottom Row
    if left>right
        break;
    end
    for i = right:-1:left
        ciphertext(value) = route(bottom,i);
        value = value + 1;
    end
    bottom = bottom - 1;
    
    %Then The Left Column
    if top>bottom
        break;
    end
    for i = bottom:-1:top
        ciphertext(value) = route(i,left);
        value = value + 1;
    end
    left = left + 1;
    
    %Top Row First
    if left>right
        break;
    end
    for i = left:right
        ciphertext(value) = route(top,i);
        value = value + 1;
    end
    top = top + 1;
    
    %Then The RightMost Column
    if top>bottom
        break;
    end
    for i = top:bottom
        ciphertext(value) = route(i,right);
        value = value + 1;
    end
    right = right - 1;
end
char(ciphertext)
%% dekripsi
kunci_decrypt = 5
ciphertext_decrypt = '7B__EFRAJAFYKZIRDAMAHUMBbd3-34-DB114.125.9.9-GnihabmatiD^-^NAIREaN_AngelFC-77-74najnaP_hABMAt_n'
plaintext = []
flag = 1

plaintext_decrypt = []
% [m,n] = size(route);
n = kunci_decrypt
m = length(ciphertext_decrypt)/kunci_decrypt
%m = no of rows
%n = no of columns
%A = matrix to be filled with spiral values
 %This code works fine. I commented an eg also below
top = 1;
bottom = m;
left = 1;
right = n; %To keep track of the four directions
value = 1;%Let us strat from 1
while true
    %Then Bottom Row
    if left>right
        break;
    end
    for i = right:-1:left
        plaintext_decrypt(bottom,i) = ciphertext_decrypt(value);
        value = value + 1;
    end
    bottom = bottom - 1;
    
    %Then The Left Column
    if top>bottom
        break;
    end
    for i = bottom:-1:top
        plaintext_decrypt(i,left) = ciphertext_decrypt(value);
        value = value + 1;
    end
    left = left + 1;
    
    %Top Row First
    if left>right
        break;
    end
    for i = left:right
        plaintext_decrypt(top,i) = ciphertext_decrypt(value);
        value = value + 1;
    end
    top = top + 1;
    
    %Then The RightMost Column
    if top>bottom
        break;
    end
    for i = top:bottom
        plaintext_decrypt(i,right) = ciphertext_decrypt(value);
        value = value + 1;
    end
    right = right - 1;
end
char(plaintext_decrypt)

% mencari text awal plaintext
hasil_plaintext = []
pos = 1
for x = 1:kunci_decrypt
     for y = 1:ceil(length(ciphertext_decrypt)/kunci_decrypt)
         hasil_plaintext(pos) = plaintext_decrypt(y,x) 
         pos = pos+1
     end
end
disp(char(hasil_plaintext))
