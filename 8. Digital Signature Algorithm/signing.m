%% menghitung nilai hash
hm = input('Hash: ')

%% pilih nilai k (k < q)
k = input('K : ');

%% menghitung k-1 (invers modulo)
[G, C, ~] = gcd(k,q);
if G==1  % The inverse of a(mod b) exists only if gcd(a,b)=1
    InvK = mod(C,q);
else disp('Modular multiplicative inverse does not exist for these values')
end

%% menghitung r 
r = mod(mod((g^k),p),q)

%% menghitung nilai s
s = mod(InvK*(hm+(x*r)),q)

%% tampilkan r dan s
fprintf('\nR dan S : %s %s\n',r,s)
