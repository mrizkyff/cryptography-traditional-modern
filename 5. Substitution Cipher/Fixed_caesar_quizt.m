clc;
clear;

%% inputan plaintext & key
txt='MUHAMADRIZKYFAJARFEBRIAN^-^Ditambahin_bEn_tAMBAh_PanjanG_daN_AngelFP-87-94-93-94-MB114.125.9.97'
key=215;




%% Proses Enkripsi

%%transform abjad --> angka
if ( (txt < '0') | (txt > 'z') ),
error('Text character out of range a-z');
end;
y=txt - '-';   

%% Enkripsi
hasil_modulus=mod((y+key),79);   

%% transform angka --> abjad  
if ( (hasil_modulus < 0) | (hasil_modulus > 25) ),
   error('Integer out of range 0 - 26');
end;
cipher=char(hasil_modulus + '-')











%% Proses Dekripsi
      
%%transform abjad --> angka
if ( (cipher < 'a') | (cipher > 'z') ),
error('Text character out of range a-z');
end;
yx=cipher - '-';   

%% Dekripsi
hasil_modulusx=mod((yx-key),79);   

%% transform angka --> abjad  
if ( (hasil_modulusx < 0) | (hasil_modulusx > 25) ),
error('Integer out of range 0 - 26');
end;
Plaintext=char(hasil_modulusx + '-')


