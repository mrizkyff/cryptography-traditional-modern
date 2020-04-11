% enkripsi
rail = []
flag = 1
pos = 1
plaintext = 'MUHAMADRIZKYFAJARFEBRIAN^-^Ditambahin_bEn_tAMBAh_PanjanG_daN_AngelFP-87-94-93-94-MB114.125.9.97'
p = length(plaintext)
k = 5
while(pos<=p)
    if(flag == 1)
        for y = 1:k
            if(pos<=p)
                rail(y,pos) = plaintext(pos)
                pos = pos + 1
            end
        end
        flag = flag + 1
    else
        if(mod(flag,2)==1)
            for y = 2:k
                if(pos<=p)
                    rail(y,pos) = plaintext(pos)
                    pos = pos + 1
                end
            end
            flag = flag + 1
        else
            for y = (k-1):-1:1
                if(pos<=p)
                    rail(y,pos) = plaintext(pos)
                    pos = pos + 1
                end
            end
            flag = flag + 1
        end
    end
end

disp(char(rail))

% membuat menjadi kalimat
pos = 1
cipher = []
huruf = 1
for x = 1:k
    for y = 1:length(plaintext)
        if ~(rail(x,y) == 0)
            cipher(pos) = rail(x,y)
%         cipher(y,x) = pos
        end
%         cipher(x,y) = pos
        pos = pos + 1
    end
end
cipher = nonzeros(cipher')
cipher = reshape(cipher,1,p)
disp(char(cipher))
%% dekripsi
k = 5
flag = 1
pos = 1
ciphertext = 'MIR^bn__e7-2URZAFN-maE_hPGdgl-44D15HDKJEA^ahbtAananF7-3B..7AAYABIDti_ABnaNAC7B-1499MFRinMj_-31.'
plaintext = []
pos2 = 1
p = length(ciphertext)
while(pos<=p)
    if(flag == 1)
        for y = 1:k
            if(pos<=p)
                plaintext(y,pos) = ciphertext(pos)
                pos = pos + 1
            end
        end
        flag = flag + 1
    else
        if(mod(flag,2)==1)
            for y = 2:k
                if(pos<=p)
                    plaintext(y,pos) = ciphertext(pos)
                    pos = pos + 1
                end
            end
            flag = flag + 1
        else
            for y = (k-1):-1:1
                if(pos<=p)
                    plaintext(y,pos) = ciphertext(pos)
                    pos = pos + 1
                end
            end
            flag = flag + 1
        end
    end
end

pos = 1
for x = 1:k
    for post = 1:p
        if(plaintext(x,post)~=0)
            plaintext(x,post) = ciphertext(pos)
            pos = pos + 1
        end
    end
end

pl = []
pos = 1
flag = 1
while(pos<=p)
    if(flag == 1)
        for y = 1:k
            if(pos<=p)
                pl(pos) = plaintext(y,pos)
                pos = pos + 1
            end
        end
        flag = flag + 1
    else
        if(mod(flag,2)==1)
            for y = 2:k
                if(pos<=p)
                    pl(pos) = plaintext(y,pos)
                    pos = pos + 1
                end
            end
            flag = flag + 1
        else
            for y = (k-1):-1:1
                if(pos<=p)
                    pl(pos) = plaintext(y,pos)
                    pos = pos + 1
                end
            end
            flag = flag + 1
        end
    end
end
pl = nonzeros(pl')
pl = reshape(pl,1,p)
disp(char(pl))