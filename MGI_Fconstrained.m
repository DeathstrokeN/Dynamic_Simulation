function li = MGI_Fconstrained(X)

global Bp Ai rp 

X = reshape(X, 6, 1);

    
Bb = Rot(X(4:6))*Bp +  X(1:3); %B in base frame
    %Cables lenghts

    %for i=1:8
     %   l(i) = sqrt((B(1,i) - A(1,i))^2) + sqrt((B(2,i) - A(2,i))^2) + sqrt((B(3,i) - A(3,i))^2);
    %end

B = Bb - Ai;

    %%
    %Calculate the angles of pulley direction
    angle = zeros(8,1);
    for i=1:8
        angle(i) = atan2(B(2,i),B(1,i));
    end
    %Pulley is in (x,z) 
    
    %transform B in pulley plan
    for i=1:8
        B(:,i) = Rz(-angle(i))*B(:,i);
    end
    
    
    %%
    %Calculate A coordinates
    A = nan(3,8);
    
    %Nguyen maths
    %%
    %Changed to suspended (+) instead of (-)
    for i=1:8
        if(i==1 || i==4 || i==5 || i==8)    
            z = (B(3,i) * rp^2 + rp * abs(B(1,i) - rp) * sqrt(B(3,i)^2 +...
                (B(1,i) - rp)^2 - rp^2)) / (B(3,i)^2 + (B(1,i) - rp)^2);
        else
            z = (2*B(3,i) * rp^2 - rp * abs(B(1,i) - rp) * sqrt(B(3,i)^2 +...
                (B(1,i) - rp)^2 - rp^2)) / (B(3,i)^2 + (B(1,i) - rp)^2); 
        end
    
        A(1,i) = rp + sqrt(rp^2 - z^2);
    
        A(3,i) = z;
        A(2,i) = 0;
    end
    
    for i=1:8
        A(:,i) = Rz(angle(i))*A(:,i) + Ai(:,i);
    end


li = nan(8,1);

for i=1:8
    li(i) = norm(Bb(:,i) - A(:,i));% + 2*Ai(3,i);%Neglecting cable length in pulley 
end

end
