function [sys, x0, str, ts] = Sfunction_winch(t, x, tau, flag, q0)

switch flag
    case 0
        % Initialization
        sizes = simsizes;
        sizes.NumContStates  = 16; % 12 continuous states (6 for pose and 6 for velocity)
        sizes.NumDiscStates  = 0;
        sizes.NumOutputs     = 16; % q, qdot
        sizes.NumInputs      = 16; % [tau_m; tau_c] 
        sizes.DirFeedthrough = 0;
        sizes.NumSampleTimes = 1;

        sys = simsizes(sizes);

        x0  = q0; % Initial state

        str = [];

        ts  = [-1 0]; % Continuous sample time

    case 2
        % Update
        sys = [];

    case 3
        % Output
        sys = x;

    case 4
        % Derivative
        sys = [];

    case 1
        % Derivative
        sys = Winch_dyn(t, x, tau);


    otherwise

     
end
end

function dq  = Winch_dyn(t, q, tau)

global Im R


tau_c = tau(1:8);
tau_m = tau(9:16);

qdot = q(9:16);

%Im = 12245154.08*1e-9*eye(8);%0.0011*eye(8);


qddot = Im\(tau_m  - R*tau_c);%Fv*qdot - Fs*sign(qdot) - R*tau_c);

    for i = 1:6
        if (abs(qddot(i)) < 1e-2)
            qddot(i) = 0;
        end
    end

     for i = 1:6
        if (abs(qddot(i)) < 1e-2)
            qddot(i) = 0;
        end
    end

dq = real([qdot;qddot]);
end