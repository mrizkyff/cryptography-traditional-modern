function Message = Decrypt(Modulus, PrivateExponent, Ciphertext)
    Message = ModularExponentiation(Ciphertext, PrivateExponent, Modulus);
end

