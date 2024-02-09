function R = Rz(theta)

%%
%Transformation to the pulley frame pi/4 on z
R = [cos(theta) -sin(theta) 0;
      sin(theta)  cos(theta) 0;
      0           0          1];

end