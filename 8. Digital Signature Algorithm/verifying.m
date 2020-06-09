%% hitung invers s
[G, C, ~] = gcd(s,q);
if G==1  % The inverse of a(mod b) exists only if gcd(a,b)=1
    InvS = mod(C,q);
else disp('Modular multiplicative inverse does not exist for these values')
end

%% menghitung w
w = mod(InvS,q);

%% menghitung u1 u2
u1 = mod((hm * w),q)
u2 = mod((r*w),q)
v = mod(mod(((g^u1) * (y^u2)),p),q)

%% cek r dan v
if v == r 
    fprintf('\nSah!!!!\n')
else
    fprintf('\nTidak Sah!!!!\n')
end
