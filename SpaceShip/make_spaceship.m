function [ myhandles ] = make_spaceship(trf_root, transparency)
% Makes a space-ship with the root transform as the given transform
%root transform = handle of main Transform object/parent object.
% The surfaces are drawn with the given transparency in [0,1]
% A vector of handles to all the surfaces is returned.

ship_dish_profile= 2*sin(linspace(0, pi, 15));
[Xc, Yc, Zc]= cylinder(ship_dish_profile);

% Top dish
trf_top_root= hgtransform('Parent', trf_root);
%trf_top_root is the object identifier for top dish
set(trf_top_root, 'Matrix', makehgtform('translate', [0, 0, 0.2]));
%set(H,Name,Value) specifies a value for the property Name on the
%object identified by H; so trf_top_root is an identifer of the Tobject
%color_top= [1, 0, 0];%color code for white
myhandles(1)= surface(Xc, Yc, Zc, 'Parent', trf_top_root, 'FaceColor', "r", 'FaceAlpha', transparency, 'EdgeColor', "k", 'EdgeAlpha', 0);

% Bottom dish
trf_bottom_root= hgtransform('Parent', trf_root);
%trf_bottom_root is the object identifier for bottom dish
set(trf_bottom_root, 'Matrix', makehgtform('translate', [0, 0, -0.2]));
color_bottom= [0, 0, 1];
myhandles(2)= surface(Xc, Yc, Zc, 'Parent', trf_bottom_root, 'FaceColor', color_bottom, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_bottom, 'EdgeAlpha', 0);

% creates x, y, z coordinates of unit cylinder to draw left tail
[Xt, Yt, Zt]= cylinder([0.4 , 0.3 , 0]); 
%0.4 radius at first, then 0.3 radius and finally 0 radius so looks pointed


% Left tail front
trf_tailleft_root= hgtransform('Parent', trf_root);
%trf_tailleft_root is the object identifier for left tail
trf_scale= makehgtform('scale', [1,1,3]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T4= makehgtform('translate', [-3, 0.75, 2]);
% Interpret the order as BFT (left to right)
set(trf_tailleft_root, 'Matrix', trf_T4*trf_Ry*trf_scale); 
myhandles(3)= surface(Xt, Yt, Zt, 'Parent', trf_tailleft_root, 'FaceColor', "k", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha',0);

% Your code here. Use left tail as a reference and design spaceship as
% shown in the class. You can come up with a new design.

% Right tail front
trf_tailright_root= hgtransform('Parent', trf_root);
%trf_tailright_root is the object identifier for left tail
trf_scale2= makehgtform('scale', [1,1,3]);
trf_Ry4= makehgtform('yrotate', -pi/2);%rotate in anitclocwise direction by angle pi/2
%rotate= clockwise, imrotate=anti clockwise
trf_T4= makehgtform('translate', [-3, -0.75, 2]);
% Interpret the order as BFT (left to right)
set(trf_tailright_root, 'Matrix', trf_T4*trf_Ry4*trf_scale2); 
myhandles(4)= surface(Xt, Yt, Zt, 'Parent', trf_tailright_root, 'FaceColor', "k", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);


% Left tail front down
trf_tailleftdown_root= hgtransform('Parent', trf_root);
%trf_tailleft_root is the object identifier for left tail
trf_scale= makehgtform('scale', [1,1,4]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T4= makehgtform('translate', [-1, 0.75, 0]);
% Interpret the order as BFT (left to right)
set(trf_tailleftdown_root, 'Matrix', trf_T4*trf_Ry*trf_scale); 
myhandles(5)= surface(Xt, Yt, Zt, 'Parent', trf_tailleftdown_root, 'FaceColor', "k", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha',0);


% Right tail front down
trf_tailrightdown_root= hgtransform('Parent', trf_root);
%trf_tailright_root is the object identifier for left tail
trf_scale2= makehgtform('scale', [1,1,4]);
trf_Ry2= makehgtform('yrotate', -pi/2);%rotate in anitclocwise direction by angle pi/2
%rotate= clockwise, imrotate=anti clockwise
trf_T2= makehgtform('translate', [-1, -0.75, 0]);
% Interpret the order as BFT (left to right)
set(trf_tailrightdown_root, 'Matrix', trf_T2*trf_Ry2*trf_scale2); 
myhandles(6)= surface(Xt, Yt, Zt, 'Parent', trf_tailrightdown_root, 'FaceColor', "k", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%now for the tail at the back of spaceship
% Left tail back
trf_tailleftback_root= hgtransform('Parent', trf_root);
%trf_tailleft_root is the object identifier for left tail
trf_scaleback1= makehgtform('scale', [1,1,1]);
trf_Ryback1= makehgtform('yrotate', pi/2);
trf_T4back1= makehgtform('translate', [1.9, 0.75, 1.15]);
% Interpret the order as BFT (left to right)
set(trf_tailleftback_root, 'Matrix', trf_T4back1*trf_Ryback1*trf_scaleback1); 
myhandles(5)= surface(Xt, Yt, Zt, 'Parent', trf_tailleftback_root, 'FaceColor', "y", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha',0);


% Right tail back
trf_tailrightback_root= hgtransform('Parent', trf_root);
%trf_tailright_root is the object identifier for left tail
trf_scaleback2= makehgtform('scale', [1,1,1]);
trf_Ry4back2= makehgtform('yrotate', pi/2);%rotate in clocwise direction by angle pi/2
%rotate= clockwise, imrotate=anti clockwise
trf_T4back2= makehgtform('translate', [1.9, -0.75, 1.15]);
% Interpret the order as BFT (left to right)
set(trf_tailrightback_root, 'Matrix', trf_T4back2*trf_Ry4back2*trf_scaleback2); 
myhandles(6)= surface(Xt, Yt, Zt, 'Parent', trf_tailrightback_root, 'FaceColor', "y", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%tail to spaceship connector1
trf_connector_tailleft= hgtransform('Parent', trf_root);
trf_scale4= makehgtform('scale', [1,0.8,2.7]);
trf_Ry4= makehgtform('yrotate', -0.785398);
trf_T4= makehgtform('translate', [-2.5, 0.75, 0]);
% Interpret the order as BFT (left to right)
set(trf_connector_tailleft, 'Matrix', trf_T4*trf_Ry4*trf_scale4); 
myhandles(9)= surface(Xt, Yt, Zt, 'Parent', trf_connector_tailleft, 'FaceColor', "g", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%tail to spaceship connector2
trf_connector_tailright= hgtransform('Parent', trf_root);
%trf_connector_tailright is the object identifier for right tail
trf_scale4= makehgtform('scale', [1,0.8,2.7]);
trf_Ry4= makehgtform('yrotate', -0.785398);
trf_T4= makehgtform('translate', [-2.5, -0.75, 0]);
% Interpret the order as BFT (left to right)
set(trf_connector_tailright, 'Matrix', trf_T4*trf_Ry4*trf_scale4); 
myhandles(10)= surface(Xt, Yt, Zt, 'Parent', trf_connector_tailright, 'FaceColor', "g", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%tail connector for back tails of spaceship
%tail to spaceship connector3
trf_connector_tailleftback= hgtransform('Parent', trf_root);
%trf_taillconnector_tailleft is the object identifier for left tail
trf_scaleback4= makehgtform('scale', [1,1,1]);
trf_Ryback4= makehgtform('yrotate', -2.0944);
trf_Tback4= makehgtform('translate', [2.12, 0.75, 1.2]);
% Interpret the order as BFT (left to right)
set(trf_connector_tailleftback, 'Matrix', trf_Tback4*trf_Ryback4*trf_scaleback4); 
myhandles(17)= surface(Xt, Yt, Zt, 'Parent', trf_connector_tailleftback, 'FaceColor', "y", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%tail to spaceship connector4
trf_connector_tailrightback= hgtransform('Parent', trf_root);
%trf_connector_tailright is the object identifier for right tail
trf_scaleback4= makehgtform('scale', [1,1,1]);
trf_Ryback4= makehgtform('yrotate', -2.0944);
trf_Tback4= makehgtform('translate', [2.12, -0.75, 1.2]);
% Interpret the order as BFT (left to right)
set(trf_connector_tailrightback, 'Matrix', trf_Tback4*trf_Ryback4*trf_scaleback4); 
myhandles(18)= surface(Xt, Yt, Zt, 'Parent', trf_connector_tailrightback, 'FaceColor', "y", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

% creates x, y, z coordinates of unit cylinder to draw left tail
[Xs, Ys, Zs]= cylinder([0.4 ,0]);

%Tail Lid left tail front 
trf_connector_taillidright= hgtransform('Parent', trf_root);
trf_scale4= makehgtform('scale', [1,1,0.3]);
trf_Ry4= makehgtform('yrotate', pi/2);
trf_T4= makehgtform('translate', [-3, -0.75, 2]);
% Interpret the order as BFT (left to right)
set(trf_connector_taillidright, 'Matrix', trf_T4*trf_Ry4*trf_scale4); 
myhandles(11)= surface(Xs, Ys, Zs, 'Parent', trf_connector_taillidright, 'FaceColor', "b", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%Tail Lid Right tail front
trf_connector_taillidleft= hgtransform('Parent', trf_root);
trf_scale4= makehgtform('scale', [1,1,0.3]);
trf_Ry4= makehgtform('yrotate', pi/2);
trf_T4= makehgtform('translate', [-3, 0.75, 2]);
% Interpret the order as BFT (left to right)
set(trf_connector_taillidleft, 'Matrix', trf_T4*trf_Ry4*trf_scale4); 
myhandles(12)= surface(Xs, Ys, Zs, 'Parent', trf_connector_taillidleft, 'FaceColor', "b", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%Tail Lid left tail front down
trf_connector_taillidrightdown= hgtransform('Parent', trf_root);
trf_scale4= makehgtform('scale', [1,1,0.3]);
trf_Ry4= makehgtform('yrotate', pi/2);
trf_T4= makehgtform('translate', [-1, 0.75, 0]);
% Interpret the order as BFT (left to right)
set(trf_connector_taillidrightdown, 'Matrix', trf_T4*trf_Ry4*trf_scale4); 
myhandles(13)= surface(Xs, Ys, Zs, 'Parent', trf_connector_taillidrightdown, 'FaceColor', "b", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);

%Tail Lid Right tail front down
trf_connector_taillidleftdown= hgtransform('Parent', trf_root);
trf_scale4= makehgtform('scale', [1,1,0.3]);
trf_Ry4= makehgtform('yrotate', pi/2);
trf_T4= makehgtform('translate', [-1, -0.75, 0]);
% Interpret the order as BFT (left to right)
set(trf_connector_taillidleftdown, 'Matrix', trf_T4*trf_Ry4*trf_scale4); 
myhandles(14)= surface(Xs, Ys, Zs, 'Parent', trf_connector_taillidleftdown, 'FaceColor', "b", 'FaceAlpha', 1, 'EdgeColor', "k", 'EdgeAlpha', 0);
end

