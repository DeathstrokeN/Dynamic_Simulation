function xddot = DynModel_q(y)
    global m I AE 
    
    W = WrenchMatrix(y(1:6));
    xdot = y(7:12);
    q = y(13:20);
    
    %convert  phidot to omega
    % v2 = S*x(10:12); %omega
    % v2 = reshape(v2 , 3, 1);
    psidot = xdot(4:6);
    psi    = y(4:6);

    S = Srot(psi);
    Sdot = Srot_dot(psi, psidot);

    Q = Rot(y(4:6));

    Ib = Q*I*Q';   
    
    l = MGI_Fconstrained(y(1:6));
    R  = (sqrt(0.08^2 + 0.005^2/(2*pi))/25);
    tau_c = nan(8,1);
    for i=1:8
        tau_c(i) = (AE/R*q(i)) * (l(i) - R*q(i));
        %tau_c(i) = max(tau_c(i), 0);
    end
    
    
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
