function qddot  = dynM_Winch(tau)

global Im R


tau_c = tau(1:8);
tau_m = tau(9:16);


%Im = 12245154.08*1e-9*eye(8);%0.0011*eye(8);


qddot = Im\(tau_m  - R*tau_c);%Fv*qdot - Fs*sign(qdot) - R*tau_c);

    for i = 1:8
        truncateSignalq(qddot(i));
    end


end