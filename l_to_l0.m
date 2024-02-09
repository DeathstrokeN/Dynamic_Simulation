function l0 = l_to_l0(u)

global AE

tau_c = u(1:8);
l = u(9:16);

l0 = nan(8,1);

for i=1:8
    l0(i) = (AE * l(i))/(tau_c(i) + AE);
end


end

