    encrypt('MUHAMADRIZKYFAJARFEBRIAN^_^Ditambahin_bEn_tAMBAh_PanjanG_daN_Angel','A11.2017.1049225');
%     decrypt('RXKAQCG I/M1QENHWIHBVKDW_GKZLQFHMLQBIPWJMECN ERQFQJDEPDWGHN','A11.2017.1049225');
    function v = vigenere
    % Square 78 on a side
    count = 78;
    % Map letters to numbers, A=1, B=2, ... SPACE=78
    alpha = 1:count;
    % Create a matrix with 78 shifted substitution alphabets
    %   1 2 3 4 5 ... 77 78
    %   2 3 4 5 6 ... 78  1
    %   3 4 5 6 7 ...  1  2
    % etc.
    v = arrayfun(@(n) circshift(alpha, [0, -n]), 0:count-1, ...
                 'UniformOutput', false);
    v = reshape([v{:}], count, count);
    end
    function plaintext = decrypt(ciphertext, key)
     v = vigenere;

    % Convert the key and the ciphertext to one-based numeric values;
    % A=1, B=2, etc. SPACE=78
    key = lower(key) - double('.') + 1;
    key(key < 0) = 78;
    ciphertext = lower(ciphertext) - double('.') + 1;
    ciphertext(ciphertext < 0) = 78;

    % Replicate the key so that it is as long as the ciphertext.
    keyIndex = mod(0:(numel(ciphertext)-1), numel(key))+1;
    k = key(keyIndex);

    % Decrypt. Each letter of the key determines a row in the Vigenere
    % square. In that row, find the column index of the corresponding
    % ciphertext letter. Convert the index back to a letter to determine
    % the decrypted character (1=A, 2=B, etc.).
    plaintext = arrayfun(@(m,n) find(v(m,:) == n), k, ciphertext) - 1;
    plaintext(plaintext == 77) = double(' ') - double('.');
    plaintext = upper(char(plaintext + double('.')));
    disp(plaintext)
    end
function ciphertext = encrypt(plaintext, key)
        v = vigenere;

    % Squeeze out everything except letters and the space character
    exclude = regexp(plaintext, '[^a-zA-Z ].');
    plaintext(exclude) = [];

    % Make the key and the plaintext lower case, and convert to
    % numeric values.
    key = lower(key) - double('.') + 1;
    key(key < 0) = 78;
    plaintext = lower(plaintext) - double('.') + 1;
    plaintext(plaintext < 0) = 78;

    % Replicate the key so that it is as long as the plaintext.
    keyIndex = mod(0:(numel(plaintext)-1), numel(key))+1;
    k = key(keyIndex);

    % Encrypt: C(n) = V(k(n), plaintext(n))
    ciphertext = arrayfun(@(m,n) v(m,n), k, plaintext) - 1;
    ciphertext(ciphertext == 77) = double(' ') - double('.');
    ciphertext = upper(char(ciphertext + double('.')));
    disp(ciphertext)
end