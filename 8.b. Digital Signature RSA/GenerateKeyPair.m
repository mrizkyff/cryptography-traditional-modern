function [Modulus, PublicExponent, PrivateExponent] = GenerateKeyPair

    % 1. Generate a pair of large, random primes p and q
    p = int32(randseed(randseed, 1, 1, 10, 100));
    q = int32(randseed(randseed, 1, 1, 10, 100));
    
    % 2. Compute the modulus n = pq
    n = p * q;
    
    % 3. Calculate Phi using Euler's totient function
    Phi         = (p - 1) * (q - 1);

    % 4. Find e that is relatively prime to Phi 
    e = NaN;
    
    for i = 3 : 2 : Phi - 1
        if gcd(i, Phi) == 1
            e = int32(i);
            break
        end
    end
    
    if isnan(e)
        error('No relative prime between p - 1 and q - 1 was found.')
    end
    
    % 5. Compute the private exponent d from e, p and q.
    [~, d, ~]   = ExtendedEuclideanAlgorithm(e, Phi);
    
    if d < 0
        d = Phi + d;
    end
    
    % 6. Output (n, e) as the public key and (n, d) as the private key
    Modulus         = n;
    PublicExponent  = e;
    PrivateExponent = d;
    
end