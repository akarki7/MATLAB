function R_B_E= Rodrigues(a_E, alpha, normalize)

if (nargin > 2) %nargin is the number of input arguments
    if normalize
        a= a_E./norm(a_E);
    else
        a= a_E;
    end
else
    a= a_E./norm(a_E); % By default, normalize
end

A= crosspr(a);
R_B_E= eye(3) + sin(alpha)*A + (1-cos(alpha))*(A*A);%Rodrigues rotation formula

%eye(3) makes a 3X3 Identity matrix; 
%A=axis of rotation in crossproduct matrix form

%https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula

%Rodrigues' rotation formula gives an efficient method for computing the 
%rotation matrix R in SO(3) corresponding to a rotation by an angle theta 
%about a fixed axis specified by the unit vector A^=(A_x,A_y,A_z) in R^3

%in our case the unit vector is a_E=(1,0,0) a_E=(0,1,0) and a_E=(0,0,1) which
%reprsent the axis of rotation