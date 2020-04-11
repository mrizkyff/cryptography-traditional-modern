% enkripsi
clc         % clears the command window
clear       % clears ALL variables
format      % resets the format to the default format

x = 'ABCD'
y = double(x)

x = 0:77;           % creates a vector of the numbers from 0 to 25, respectively.  Output is suppressed.
y=x+45              % adds 45 to every element in the vector so the numbers in y now to from 45 to 90.
alphabet = char(y)  % alphabet is now a string that should be the alphabet in uppercase.

ex1 = reshape(alphabet,2,39)
A=[1 2 3 4]
reshape(A,2,2)

K = [2 3;1 4]
% K = [17 17 5;21 18 21;2 2 9]

msg='universitasdiannuswantorosemarangx'
msgnum = double(msg)-65
M=reshape(msgnum,2,17)

E=K*M
E=mod(E,26)
numcode=reshape(E,1,34)
numcode=numcode+65
examplecode=char(numcode)

%% dekripsi
D=inv(K)
rats(D)

a=78/5;     % I just didn't want to type 26/5 over and over
D(1,1)+a+a    % D(1,1) is the 1,1 entry of D. I ran this once, saw it was an integer between 0 and 26 so done
D(1,1)=ans  % here I'm reassigning the 1,1 entry of D to be the above answer

D(1,2) + a % I re-ran this several times, adding another "a" each time until I got an integer between 0 and 26
D(1,2)= ans  % reassigning the 1,2 entry of D to be the previous answer

% D(1,3) + a
% D(1,3) = ans

D(2,1)+a+a
D(2,1)=ans

D(2,2)+a
D(2,2)=ans
% 
% D(2,3) + a
% D(2,3) = ans
% 
% D(3,1)+a+a
% D(3,1)=ans
% 
% D(3,2)+a
% D(3,2)=ans
% 
% D(3,3) + a
% D(3,3) = ans

examplecode
numcode2=double(examplecode);
numcode2=numcode2-65;    % convert to numbers from 0 to 25
E2=reshape(numcode2,2,17) % reshape to 2x7 matrix

chkmsg=D*E2;
chkmsg=mod(chkmsg,26);
chkmsg=reshape(chkmsg,1,34);
chkmsg=chkmsg+65;
char(chkmsg)