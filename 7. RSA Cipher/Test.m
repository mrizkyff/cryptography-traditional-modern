% http://www.mathaware.org/mam/06/Kaliski.pdf
% regarding the negative 'd' parameter: https://www2.informatik.uni-hamburg.de/wsv/teaching/sonstiges/EwA-Folien/Sohst-Paper.pdf

clc
clear
close all

% harus 15 karakter
Text            = 'HARI INI';

% merubah ke 0 - 26
Message         = int32(Text);



fprintf('-Input-\n')
fprintf('Original message:       ''%s''\n', Text)
fprintf('Integer representation: %s\n', num2str(Message))

%% Generate Key Pair

[Modulus, PublicExponent, PrivateExponent] = GenerateKeyPair;

fprintf('\n-Key Pair-\n')
fprintf('Modulus:                '), fprintf('%5d\n', Modulus)
fprintf('Public Exponent:        '), fprintf('%5d\n', PublicExponent)
fprintf('Private Exponent:       '), fprintf('%5d\n', PrivateExponent)

%% Encrypt / Decrypt

Ciphertext      = Encrypt(Modulus, PublicExponent, Message);
RestoredMessage	= Decrypt(Modulus, PrivateExponent, Ciphertext);

fprintf('\n-Encryption-\n')
fprintf('Ciphertext:             %s [ %s ]\n', num2str(Ciphertext), char(Ciphertext))
fprintf('Restored Message:       ''%s''\n', char(RestoredMessage))
