function Signature = Sign(Modulus, PrivateExponent, Message)
    Signature = ModularExponentiation(Message, PrivateExponent, Modulus);
end