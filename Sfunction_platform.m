function [sys, x0, str, ts] = Sfunction_platform(t, x, tau_c, flag, X0)

switch flag
    case 0
        % Initialization
        sizes = simsizes;
        sizes.NumContStates  = 12; 
        sizes.NumDiscStates  = 0;
        sizes.NumOutputs     = 12; % 12 outputs (6 for pose and 6 for velocity)
        sizes.NumInputs      = 8;  % Wt : Wrench (forces and moments)
        sizes.DirFeedthrough = 0;
        sizes.NumSampleTimes = 1;

        sys = simsizes(sizes);

        x0  = X0; % Initial state

        str = [];

        ts  = [-1 0]; 

    case 2
        % Update for discrete state
        sys = [];

    case 3
        % Output
        sys = x;

    case 4
        % Derivative for continuous state
        sys = [];

    case 1
        % Derivative
        sys = MobilePlatform(t, x, tau_c);




    otherwise
     
end

end

function dx  = MobilePlatform(t, x, tau_c)


    global m I 

    W = WrenchMatrix(x(1:6));
    xdot = x(7:12);
    
    %convert  phidot to omega
    % v2 = S*x(10:12); %omega
    % v2 = reshape(v2 , 3, 1);
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

    
    xddot = M\(W*tau_c - c + G); %[pddot;wdot]  
    % 
    for i = 1:6
        if (abs(xdot(i)) < 1e-6)
            xdot(i) = 0;
        end
    end

    for i = 1:6
        if (abs(xddot(i)) < 1e-6)
            xddot(i) = 0;
        end
    end
    dx = real([xdot; xddot]);
end