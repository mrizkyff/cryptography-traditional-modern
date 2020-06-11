% http://www.mathaware.org/mam/06/Kaliski.pdf
% regarding the negative 'd' parameter: https://www2.informatik.uni-hamburg.de/wsv/teaching/sonstiges/EwA-Folien/Sohst-Paper.pdf

clc
clear
close all

%% option contoh kasus dengan dokumen txt
Text = fopen('ContDokumen.txt','r');
[Text] = fscanf(Text,'%c');


%% membangkitkan hash md5 
% Text            = 'Universitas Dian Nuswantoro, Udinus, Semarang, Jawa Tengah, ID';
hm = DataHash(Text,'hex','MD5','ascii');
HashMessage         = int32(hm);

fprintf('-Input-\n')
fprintf('Original message:       ''%s''\n', Text)
fprintf('Digest Message (MD5) : %s\n',hm)
fprintf('Integer representation: %s\n', num2str(HashMessage))

%% Generate Key Pair

[Modulus, PublicExponent, PrivateExponent] = GenerateKeyPair;

fprintf('\n-Key Pair- (Prima Random)\n')
fprintf('Modulus:                '), fprintf('%5d\n', Modulus)
fprintf('Public Exponent:        '), fprintf('%5d\n', PublicExponent)
fprintf('Private Exponent:       '), fprintf('%5d\n', PrivateExponent)

%% Encrypt / Signing

Signature      = Encrypt(Modulus, PublicExponent, HashMessage);
% RestoredMessage	= Decrypt(Modulus, PrivateExponent, Signature);

fprintf('\n-Encryption Signing-\n')
fprintf('Signature:             %s \n[ %s ]\n', num2str(Signature), char(Signature))
% fprintf('Restored Message:       ''%s''\n', char(RestoredMessage))

% signing pada contoh dokumen



%% Validasi 
% clear;
% clc;

Sign = Signature;

Sign = int32(Sign)

RestoredSignature = Decrypt(Modulus, PrivateExponent, Sign);
fprintf('Message Hash :       ''%s''\n', char(HashMessage));
fprintf('Restored Hash:       ''%s''\n', char(RestoredSignature));
%

IsVerified      = Verify(Modulus, PrivateExponent, HashMessage, Sign);
fprintf('Is Verified:            %d\n', IsVerified)
