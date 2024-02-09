function S = Srot(psi)

S = [cos(psi(3))*cos(psi(2))    -sin(psi(3))   0;
     sin(psi(3))*cos(psi(2))     cos(psi(3))   0;
     -sin(psi(2))              0           1];


end

