function DESOUT=DES(str,KEY,Mode)
%% Data Encryption Standard (ECB)
% 0.1 Arguments:                                                     
%   1)Plaintext or Hexadecimal string.                                
%   2)8x8 binary number key. Use function 'keygen' to generate a key.
%   3)Mode is 'ENC' (Encode) by default: Input is plain text string.
%     Use Mode 'DEC' to Decode: Input is hexadecimal string.
%  The block size is 64-bits. Random bits are used to pad if required.
%  NIST SP800-17 @ 
%   http://csrc.nist.gov/publications/nistpubs/800-17/800-17.pdf
%   Samle block enryption in appendix A matches this algorithm,
%   Otherwise this algorithm has not been thoroughly validated.
%  Thanks to MatLab community user Yue Wu for the example!
%   http://www.mathworks.com/matlabcentral/fileexchange/37847-data-encryption-standard--des-/content/DES.m
% 1.0 Parity Check. 
%   KEY(:,8) = parity bits. Ea 8-bit block must have odd num of 1's.
% 2.0 Key Schedule.
%   KEY is split and purmuted using PC1.               
%   Parity check bits are ignored.
%   Each key half is circular-shifted each round per Left_Shift table.
%   The halves are concatenated and permuted each round.
%   The output is K{n}, or one key selection for each of 16 rounds.
% 3.0 Initial Permutation, IP, and Inverse IP.
%   Plain Text (PT) block is permuted before the main cipher rounds.
%   Pre-Output (PO) block is permuted with Inverse IP for CT output.
% 4.0 Feistel Network.
%   Split bit64 after IP into Left and Right halves.
%   Expansion permutation, S-Boxes, and P-Permuation.
%   Apply 16 rounds of the Feistel Network Function.
% 5.0 Apply Inverse IP and format the output.

%% 1.1 Parity Check and Mode Display.
% if mod(sum(KEY,2),2) == 1
%     display('Parity Check Passed!')
% else
%     error('Parity Check Failed!')
% end
switch nargin
    case 2
        display('Mode is ENCRYPT! Set 3rd argument to DEC to Decrypt!')
        Mode='ENC';
    case 3
        if strcmp(Mode,'DEC') == 1
           display('Mode is DECRYPT!')
           Mode='DEC';
        else
           display('Mode is ENCRYPT! Set 3rd argument to DEC to Decrypt!')
           Mode='ENC';        
        end
end
%% 2.1 Define permutation PC1(C & D) and PC2.
PC1C  =   [ 57 49 41 33 25 17  9 ...
             1 58 50 42 34 26 18 ...
            10  2 59 51 43 35 27 ...
            19 11  3 60 52 44 36  ];

PC1D  =   [ 63 55 47 39 31 23 15 ...
             7 62 54 46 38 30 22 ...
            14  6 61 53 45 37 29 ...
            21 13  5 28 20 12  4  ];
        
PC2   =   [ 14 17 11 24  1  5 ...
             3 28 15  6 21 10 ...
            23 19 12  4 26  8 ...
            16  7 27 20 13  2 ...
            41 52 31 37 47 55 ...
            30 40 51 45 33 48 ...
            44 49 39 56 34 53 ...
            46 42 50 36 29 32  ];
%% 2.2 Define shift schedule, permute two halves, and pre-alocate space.
Left_Shift=[1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 1];
KEY=reshape(KEY',1,64);
C_0=KEY(PC1C);
D_0=KEY(PC1D);
K=cell(1,16);
%% 2.3 Compute the 16 iteration keys, K{n}.
for n=1:16
    C=circshift(C_0,-sum(Left_Shift(1:n)),2);
    D=circshift(D_0,-sum(Left_Shift(1:n)),2);
    CD=[C D];
    K{n}=CD(PC2);
end
%% 3.1 Define the Initial Permutation, IP, and Inverse IP.
IP    = [ 58    50    42    34    26    18    10     2 ...
          60    52    44    36    28    20    12     4 ...
          62    54    46    38    30    22    14     6 ...
          64    56    48    40    32    24    16     8 ...
          57    49    41    33    25    17     9     1 ...
          59    51    43    35    27    19    11     3 ...
          61    53    45    37    29    21    13     5 ...
          63    55    47    39    31    23    15     7  ];
      
InvIP = [ 40     8    48    16    56    24    64    32 ...
          39     7    47    15    55    23    63    31 ...
          38     6    46    14    54    22    62    30 ...
          37     5    45    13    53    21    61    29 ...
          36     4    44    12    52    20    60    28 ...
          35     3    43    11    51    19    59    27 ...
          34     2    42    10    50    18    58    26 ...
          33     1    41     9    49    17    57    25  ];
%% 4.1 Definitions for Feistel Network.
%   Expansion Permutation
Expn = [ 32  1  2  3  4  5 ...
          4  5  6  7  8  9 ...
          8  9 10 11 12 13 ...
         12 13 14 15 16 17 ...
         16 17 18 19 20 21 ...
         20 21 22 23 24 25 ...
         24 25 26 27 28 29 ...
         28 29 30 31 32  1 ];
      
%   Pimitive Permuation
P32 = [ 16  7 20 21 ...
        29 12 28 17 ...
         1 15 23 26 ...
         5 18 31 10 ...
         2  8 24 14 ...
        32 27  3  9 ...
        19 13 30  6 ...
        22 11  4 25 ];
     
% The S-Boxes
S{1}= [ 14  4 13  1  2 15 11  8  3 10  6 12  5  9  0  7 ...
         0 15  7  4 14  2 13  1 10  6 12 11  9  5  3  8 ...
         4  1 14  8 13  6  2 11 15 12  9  7  3 10  5  0 ...
        15 12  8  2  4  9  1  7  5 11  3 14 10  0  6 13 ];
    
S{2}= [ 15  1  8 14  6 11  3  4  9  7  2 13 12  0  5 10 ...
         3 13  4  7 15  2  8 14 12  0  1 10  6  9 11  5 ...
         0 14  7 11 10  4 13  1  5  8 12  6  9  3  2 15 ...
        13  8 10  1  3 15  4  2 11  6  7 12  0  5 14  9 ];
    
S{3}= [ 10  0  9 14  6  3 15  5  1 13 12  7 11  4  2  8 ...
        13  7  0  9  3  4  6 10  2  8  5 14 12 11 15  1 ...
        13  6  4  9  8 15  3  0 11  1  2 12  5 10 14  7 ...
         1 10 13  0  6  9  8  7  4 15 14  3 11  5  2 12 ];

S{4}= [  7 13 14  3  0  6  9 10  1  2  8  5 11 12  4 15 ...
        13  8 11  5  6 15  0  3  4  7  2 12  1 10 14  9 ...
        10  6  9  0 12 11  7 13 15  1  3 14  5  2  8  4 ...
         3 15  0  6 10  1 13  8  9  4  5 11 12  7  2 14 ];

S{5}= [  2 12  4  1  7 10 11  6  8  5  3 15 13  0 14  9 ...
        14 11  2 12  4  7 13  1  5  0 15 10  3  9  8  6 ...
         4  2  1 11 10 13  7  8 15  9 12  5  6  3  0 14 ...
        11  8 12  7  1 14  2 13  6 15  0  9 10  4  5  3 ];

S{6}= [ 12  1 10 15  9  2  6  8  0 13  3  4 14  7  5 11 ...
        10 15  4  2  7 12  9  5  6  1 13 14  0 11  3  8 ...
         9 14 15  5  2  8 12  3  7  0  4 10  1 13 11  6 ...
         4  3  2 12  9  5 15 10 11 14  1  7  6  0  8 13 ];

S{7}= [  4 11  2 14 15  0  8 13  3 12  9  7  5 10  6  1 ...
        13  0 11  7  4  9  1 10 14  3  5 12  2 15  8  6 ...
         1  4 11 13 12  3  7 14 10 15  6  8  0  5  9  2 ...
         6 11 13  8  1  4 10  7  9  5  0 15 14  2  3 12 ];

S{8}= [ 13  2  8  4  6 15 11  1 10  9  3 14  5  0 12  7 ...
         1 15 13  8 10  3  7  4 12  5  6 11  0 14  9  2 ...
         7 11  4  1  9 12 14  2  0  6 10 13 15  3  5  8 ...
         2  1 14  7  4 10  8 13 15 12  9  0  3  5  6 11 ];
     
% S-Box row and column calculators
row=@(str,x) bin2dec(num2str([str(6*x-5) str(6*x)]));
col=@(str,x) bin2dec(num2str([str(6*x-4) str(6*x-3) ...
                               str(6*x-2) str(6*x-1)]));

%% 4.2 Initial values for Feistel Network.
switch Mode
    case 'ENC'
        PT_0=dec2bin(str,8)';
        PT_1=logical(PT_0=='1');
        PT_2=reshape(PT_1,1,numel(PT_1));
        PT_3=round(rand(1,numel(PT_2)+mod(64-mod(numel(PT_2),64),64)));
        PT_3(1:numel(PT_2))=PT_2;
        ST=reshape(PT_3,64,numel(PT_3)/64)';
    case 'DEC'
        CT_0=hex2dec(str');
        CT_1=dec2bin(CT_0,4)';
        CT_2=logical(CT_1=='1');
        CT_3=reshape(CT_2,1,numel(CT_2));
        ST=reshape(CT_3,64,numel(CT_3)/64)';
end
%% 5.1 Main Loop. Outer for loop runs DES on all 64-bit blocks. Pre-alocate space
DESOUT=cell(1,size(ST,1)); 
for i=1:size(ST,1);
    IPST_0=ST(i,:);
    IPST=IPST_0(IP);
    L_0=IPST( 1:32);
    R_0=IPST(33:64);
    R=cell(1,16);
    L=cell(1,16);
    L{1}=R_0;
% Inner for loop computes Feistel values for each block, 16 rounds    
    for n=1:16
        if n == 1
            ER=R_0(Expn);
        else
            ER=R{n-1}(Expn);
        end
        switch Mode
            case 'ENC'
                KER=xor(K{n},ER);
            case 'DEC'
                KER=xor(K{17-n},ER);
        end
        SKER_0=ones(1,8);
        for j=1:8
            SKER_0(j)=S{j}(row(KER,j)*16+col(KER,j)+1);
        end
        SKER_1=dec2bin(SKER_0,4)';
        SKER=logical(reshape(SKER_1,1,32)=='1');
        PSKER=SKER(P32);
        if n == 1
            R{1}=xor(L_0,PSKER);
        else
            R{n}=xor(L{n-1},PSKER);
            L{n}=R{n-1};
        end
    end
    Pre=[R{16} L{16}];
    DESbinary=Pre(InvIP);
    switch Mode
        case 'ENC'
            %DESOUT{i}=binaryVectorToHex(DESbinary);Call doesn't work online,so...
            CTbinary=reshape(DESbinary,4,16)';
            DESOUT{i}=dec2hex(bin2dec(num2str(CTbinary)))';
        case 'DEC'
            PTbinary=reshape(DESbinary,8,8)';
            DESOUT{i}=char(bin2dec(num2str(PTbinary)))';
    end
end
DESOUT=horzcat(DESOUT{:});
switch Mode
    case 'ENC'
        assignin('base','DESCT',DESOUT)
    case 'DEC'
        assignin('base','DESPT',DESOUT)
end
end 
