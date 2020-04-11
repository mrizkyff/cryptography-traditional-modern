% % encrypt 2x
ciphertext = kolom_encrypt('A11.2017.10492','universitasdiannuswantoro')
% ciphertext = kolom_encrypt('jateng',ciphertext)
disp(char(ciphertext))

%% decrypt 2x
plaintext = kolom_decrypt('A11.2017.10492',ciphertext)
% plaintext = kolom_decrypt('jateng',plaintext)
disp(char(plaintext))
