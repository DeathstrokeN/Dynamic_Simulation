function S = Srot_dot(psi, psidot)

%psi is vector of platform angles

S = [-psidot(3)*sin(psi(3))*cos(psi(2))-psidot(2)*cos(psi(3))*sin(psi(2))   -psidot(3)*cos(psi(3))   0;
      psidot(3)*cos(psi(3))*cos(psi(2))-psidot(2)*sin(psi(3))*sin(psi(2))   -psidot(3)*sin(psi(3))  0;
     -psidot(2)*cos(psi(2))  0   0];

end

