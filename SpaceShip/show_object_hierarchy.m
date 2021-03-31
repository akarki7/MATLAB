% Shows the initial and final pose of a space-ship which undergoes
% roll-pitch-yaw and translation.
clear all
clf
handle_axes= axes('XLim', [-4,40], 'YLim', [-4,4], 'ZLim', [-4,4]);
xlabel('e_1');
ylabel('e_2');
zlabel('e_3');

view(3);
grid on;
axis equal
camlight

% Create ship-1
trf_ship1_root= hgtransform('Parent', handle_axes); 
%Parent, specified as an Axes, Group, or Transform object.
h_original_ship= make_spaceship(trf_ship1_root, 1);
% Create ship-2 translated and rotated w.r.t. ship-1
trf_ship2_ship1= hgtransform('Parent',trf_ship1_root);
h_ship2= make_spaceship(trf_ship2_ship1, 1);

roll1= 0;%-pi/10;
pitch1=0;% pi/8;
yaw1=pi;

trf_roll1= makehgtform('xrotate', roll1);
trf_pitch1= makehgtform('yrotate', pitch1);
trf_yaw1= makehgtform('zrotate', yaw1);


trf_rpy= trf_yaw1*trf_pitch1*trf_roll1;

translation= [10,-1,0]; % 4,2,2
trf_translate= makehgtform('translate', translation);
trf_final1= trf_translate*trf_rpy;

set(trf_ship2_ship1, 'Matrix', trf_final1);


drawnow;

