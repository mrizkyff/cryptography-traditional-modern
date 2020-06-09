function [g, y] = make_kunci_pair(p, q, h, x)
    %% menghitung nilai g
    g = mod(sym(h^((p-1)/q)),sym(p));

    %% mencari nilai y
    y = mod(sym(g^x),sym(p));

end