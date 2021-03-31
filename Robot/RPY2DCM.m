function R = RPY2DCM( roll, pitch, yaw )
% Angles given in radians
R_roll=  Rodrigues([1, 0, 0]', roll);%x axis; it might have been other axis as well
R_pitch= Rodrigues([0, 1, 0]', pitch);%y axis; it might have been other axis as well
R_yaw= Rodrigues([0, 0, 1]', yaw);%z axis; it might have been other axis as well
R= R_yaw*R_pitch*R_roll;
end

