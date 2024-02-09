function [M, c, G] = MCGmatrices(x, xdot)
    
    global I m
    psidot = xdot(4:6);
    psi    = x(4:6);

    S = Srot(psi);
    Sdot = Srot_dot(psi, psidot);
    Q = Rot(x(4:6));

    Ib = Q*I*Q';   
    
    
    M = [m*eye(3)           zeros(3,3);
         zeros(3,3)      Ib*S];
    
    c = [zeros(3,1);
         Ib*Sdot*psidot + cross(S*psidot, Ib*S*psidot)];
    
    fg = [0  0  m*9.8]';
    G =  [fg; zeros(3,1)];
end

