function IsVerified = Verify(Modulus, PublicExponent, Message, Signature)
    IsVerified = all(Message == ModularExponentiation(Signature, PublicExponent, Modulus));
end