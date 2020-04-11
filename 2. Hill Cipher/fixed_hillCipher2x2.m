% You should always have the following commands at the top to "start fresh"
clc         % clears the command window
clear       % clears ALL variables
format      % resets the format to the default format
%% memasukkan key dan plaintext
% kunci
K = [2 3;1 4]
% K = [17 17 5; 21 18 21; 2 2 19]

% lower character
low = '!'

% modulus
modx = 94

% plaintext
msg='MUHAMADRIZKYFAJARFEBRIAN^-^Ditambahin_bEn_tAMBAh_PanjanG_daN_AngelFP-87-94-93-94-MB114.125.9.97'

% tambahi krarakter dummy
if (mod(length(msg),2)==1)
    msg(length(msg)+1)='X'
end

% konvert msg ke angka dikurangi ascii paling kecil
msgnum = double(msg)-low
 

M=reshape(msgnum,length(K),(length(msg)/length(K)))

E=K*M
E=mod(E,modx)
numcode=reshape(E,1,length(msg))
numcode=numcode+low
examplecode=char(numcode)
%%  Dekripsi
% Finding the inverse of the key

D=inv(K)
rats(D)


a=modx/5;     % I just didn't want to type 26/5 over and over
% D(1,1)+a+a+a+a    % D(1,1) is the 1,1 entry of D. I ran this once, saw it was an integer between 0 and 26 so done
% D(1,1)=ans  % here I'm reassigning the 1,1 entry of D to be the above answer
% 
% D(1,2) + a + a % I re-ran this several times, adding another "a" each time until I got an integer between 0 and 26
% D(1,2)= ans  % reassigning the 1,2 entry of D to be the previous answer
% 
% D(2,1)+a + a + a + a
% D(2,1)=ans
% 
% D(2,2)+a + a
% D(2,2)=ans


for x=1:length(K)
    for y=1:length(K)
        if(mod(D(x,y),2) >= 1)
            while ~(mod(D(x,y),1) == 0)
                D(x,y) = D(x,y) + a
            end
        else
            while ~(mod(D(x,y),2) == 0)
                D(x,y) = D(x,y) + a
            end
        end
    end
end


examplecode
numcode2=double(examplecode);
numcode2=numcode2-low;    % convert to numbers from 0 to 25
E2=reshape(numcode2,length(K),length(msg)/length(K)) % reshape to 2x7 matrix

chkmsg=D*E2;
chkmsg=mod(chkmsg,modx);
chkmsg=reshape(chkmsg,1,length(msg));
chkmsg=chkmsg+low;
char(chkmsg)
