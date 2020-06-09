function [r, s] = signing(hm, k, q, p, g, x)
    %% menghitung k-1 (invers modulo)
    [G, C, ~] = gcd(k,q);
    if G==1  % The inverse of a(mod b) exists only if gcd(a,b)=1
        InvK = mod(C,q);
    else disp('Modular multiplicative inverse does not exist for these values')
    end

    %% menghitung r 
    r = mod(mod((g^k),p),q);

    %% menghitung nilai s
    s = mod(InvK*(hm+(x*r)),q);

end
