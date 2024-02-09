function tau_c = TDA(u)

tau_c = 100*ones(8,1);

X = u(1:6);
fd  = u(7:12);
tau_ci = u(13:20);

W = WrenchMatrix(X);

% tau_c = pinv(W)*fd;
for i=1:8
    tau_c(i) = max(tau_c(i), 0);
end
options = optimoptions('quadprog','Algorithm','active-set');
tau_c = nan(8,1);
Aeq = real(W);
beq = fd;
H = 2*ones(8);
f = zeros(1,8);
tau_c = quadprog(H, f, [], [], Aeq, beq, 50*ones(8,1), 5000*ones(8,1),tau_ci, options);

end

