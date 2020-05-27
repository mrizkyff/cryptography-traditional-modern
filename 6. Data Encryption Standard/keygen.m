function KEY=keygen(n,m)
%Generates an array of 8x8 DES keys with parity check bits (row 1)
% and 64-bit random binary blocks for Initialization Vectors (row 2)
%Prealocate the space.
%Generate the 8x7 random binary block
switch nargin
    case 0
        KEY=round(rand(8,7));
        %Add the parity check bits
        KEY(:,8)= mod(sum(KEY,2)+1,2);
    case 1
        KEY=cell(1,n);
        for i=1:n
            key=round(rand(8,7));
            key(:,8)= mod(sum(key,2)+1,2);
            KEY{i}=key;
        end
    case 2
        if n>1
            KEY=cell(2,m);
        else
            KEY=cell(1,m);
        end
        for j=1:m
            key= round(rand(8,7));
            key(:,8)= mod(sum(key,2)+1,2);
            KEY{1,j}=key;
            if n > 1
                KEY{2,j}=round(rand(8,8)); %Initialization Vectors
            end
        end
end
assignin('base','KEY',KEY)