function tau_c = Elasticity(u)

l0 = u(1:8);
l = u(9:16);
% use 
% l : for cable length with tension ti
% lo : free cable length

global AE

tau_c = nan(8,1);
for i=1:8
    tau_c(i) = (AE/l0(i)) * (l(i) - l0(i));
    %tau_c(i) = max(tau_c(i), 0);
end
