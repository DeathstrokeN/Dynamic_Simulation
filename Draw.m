function Draw(Ai, A, B, X, angle, r_p)
%Inputs : cables points coordiantes
%Robot dimensions 1m*1m*1m
%end effector 0.1m*0.1m*0.1m


%limits
clf 
%figure('Name','Planar CDPR Simulation')
%Labels
xlabel('x')
ylabel('y')
zlabel('z')
title('Simulation')
grid
hold on




PulleyG(Ai, angle, r_p);

for i=1:8
    %Cable 1
    plot3([A(1,i) B(1,i)], [A(2,i) B(2,i)], [A(3,i) B(3,i)], 'k');
    plot3(A(1,i), A(2,i), A(3,i), '*');
    plot3(B(1,i), B(2,i), B(3,i), '*');
end



    xe = [B(1,1), B(1,8), B(1,5), B(1,4), B(1,3), B(1,6), B(1,5), B(1,6), B(1,7), B(1,8), B(1,7), B(1,2), B(1,1), B(1,4), B(1,3), B(1,2)];
    ye = [B(2,1), B(2,8), B(2,5), B(2,4), B(2,3), B(2,6), B(2,5), B(2,6), B(2,7), B(2,8), B(2,7), B(2,2), B(2,1), B(2,4), B(2,3), B(2,2)];
    ze = [B(3,1), B(3,8), B(3,5), B(3,4), B(3,3), B(3,6), B(3,5), B(3,6), B(3,7), B(3,8), B(3,7), B(3,2), B(3,1), B(3,4), B(3,3), B(3,2)];
    plot3(xe,ye,ze, 'r', 'LineWidth',2)
    plot3(X(1),X(2),X(3))
    xb = [Ai(1,1), Ai(1,8), Ai(1,5), Ai(1,4), Ai(1,3), Ai(1,6), Ai(1,5), Ai(1,6), Ai(1,7), Ai(1,8), Ai(1,7), Ai(1,2), Ai(1,1), Ai(1,4), Ai(1,3), Ai(1,2)];
    yb = [Ai(2,1), Ai(2,8), Ai(2,5), Ai(2,4), Ai(2,3), Ai(2,6), Ai(2,5), Ai(2,6), Ai(2,7), Ai(2,8), Ai(2,7), Ai(2,2), Ai(2,1), Ai(2,4), Ai(2,3), Ai(2,2)];
    zb = [Ai(3,1), Ai(3,8), Ai(3,5), Ai(3,4), Ai(3,3), Ai(3,6), Ai(3,5), Ai(3,6), Ai(3,7), Ai(3,8), Ai(3,7), Ai(3,2), Ai(3,1), Ai(3,4), Ai(3,3), Ai(3,2)];
    plot3(xb,yb,zb, 'b', 'LineWidth',3)
    view(3);
    axis equal

end