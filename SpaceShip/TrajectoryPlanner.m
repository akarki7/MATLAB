% Shows the initial and final pose of a space-ship which undergoes
% roll-pitch-yaw and translation.
%clear all
clf
handle_axes= axes('xLim', [-4 4], 'xLim', [-4 4], 'zLim', [-4 4]);
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

set(gcf,'Renderer','opengl')

lon=[4 6 8 12 16 18 20 22 24 26];
lat=[-0.5 -1.5 -2 -2.5 -3 -3.5 -4 -4.5 -5 -5.5];
roll= [pi/12,pi/11,pi/10,pi/9,pi/8,pi/7,pi/6,pi/5,pi/4,pi/3];
pitch=[pi/20,pi/19,pi/18,pi/17,pi/16,pi/15,pi/15,pi/13,pi/12,pi/11];
yaw=[-pi/12,-pi/11,-pi/10,-pi/9,-pi/8,-pi/7,-pi/6,-pi/5,-pi/4,-pi/3];

xlim ([-4 30])
ylim([-10,10])
zlim([-4,7])


for i=1:numel(lat)
    trf_roll= makehgtform('xrotate', roll(i));
    trf_pitch= makehgtform('yrotate', pitch(i));
    trf_yaw= makehgtform('zrotate', yaw(i));
    trf_rpy= trf_yaw*trf_pitch*trf_roll;
    
    trf_translate= makehgtform('translate', [lon(i),lat(i),0]);
    trf_final= trf_translate*trf_rpy;
    
    set(trf_ship1_root, 'Matrix', trf_final);
    
    drawnow;
    pause(0.2);
end





