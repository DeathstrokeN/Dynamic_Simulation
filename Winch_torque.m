function tau_m = Winch_torque(u)

tau_cd = u(1:8);
qddot = u(9:16);
%tau_c = u(17:24);

global R Fv Fs Im



tau_m = Im*qddot + R*tau_cd;% + 0.1*(R*tau_cd - R*tau_c) ;% - R*tau_c;% + 0*Fv*qdot;


end

