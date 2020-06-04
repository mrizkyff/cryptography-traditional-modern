function Ciphertext = Encrypt(Modulus, PublicExponent, Message)
    Ciphertext = ModularExponentiation(Message, PublicExponent, Modulus);   
end

