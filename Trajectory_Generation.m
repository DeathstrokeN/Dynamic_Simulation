function [y]  = Trajectory_Generation(t)

global tf Xi Xf ts

xddot = zeros(6,1);
xdot = zeros(6,1);

D = Xf - Xi;
%r = t/tf;
%X = Xi + r*D;  

if t < tf 
    r = 126*(t/tf)^5 - 420*(t/tf)^6 + 540*(t/tf)^7 - 315*(t/tf)^8 + 70*(t/tf)^9;
    X    = r*D + Xi;
    % X_k1 = 
    xdot  = (5*126*(t)^4/tf^5 - 6*420*(t)^5/tf^6 + 7*540*(t)^6/tf^7 - 315*8*(t)^7/tf^8 + 9*70*(t)^8/tf^9)*D;
    xddot = (4*5*126*(t)^3/tf^5 - 5*6*420*(t)^4/tf^6 + 7*540*6*(t)^5/tf^7 - 7*315*8*(t)^6/tf^8 + 8*9*70*(t)^7/tf^9)*D;
else
    X = Xf;
    xdot = zeros(6,1);
    xddot = zeros(6,1);
end

y = [X; xdot;xddot];
% for i = 1:6
%     if (abs(xddot(i)) <= 1e-3)
%         xddot(i) = 0;
%     end
% end

end

