function xddot = DynModel(y)
    global m I 

    W = WrenchMatrix(y(1:6));
    xdot = y(7:12);
    tau_c = y(13:20);
    
    %convert  phidot to omega
    % v2 = S*x(10:12); %omega
    % v2 = reshape(v2 , 3, 1);
    psidot = xdot(4:6);
    psi    = y(4:6);

    S = Srot(psi);
    Sdot = Srot_dot(psi, psidot);

    Q = Rot(y(4:6));

    Ib = Q*I*Q';   
    
    
    M = [m*eye(3)           zeros(3,3);
         zeros(3,3)         Ib*S];
    
    c = [zeros(3,1);
         Ib*Sdot*psidot + cross(S*psidot, Ib*S*psidot)];
    
    fg = [0  0  m*9.8]';
    G =  [fg; zeros(3,1)];

    
    xddot = real(M\(W*tau_c - c + G));

    for i = 1:6
        if (abs(xddot(i)) < 1e-6)
            xddot(i) = 0;
        end
    end
end

