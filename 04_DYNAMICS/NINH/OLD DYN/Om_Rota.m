function y = Om_Rota(the)
    Omega = [0,     -the(3),the(2);
             the(3),0,      -the(1);
            -the(2),the(1), 0     ];
    y = Omega;