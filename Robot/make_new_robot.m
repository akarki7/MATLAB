clear all
close all
clf
handle_axes= axes('XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [0,0.4]);

xlabel('e_1'); 
ylabel('e_2');
zlabel('e_3');

view(-130, 26);
grid on;
axis equal
camlight
axis_length= 0.05;

%% Root frame E
trf_E_axes= hgtransform('Parent', handle_axes); 
% The root-link transform should be created as a child of the axes from the
% beginning to avoid the error "Cannot set property to a deleted object".
% E is synonymous with the axes, so there is no need for plot_axes(trf_E_axes, 'E');

%% Link-0: Base-link

trf_link0_E= make_transform([0, 0, 0], 0, 0, 0, trf_E_axes); 

trf_viz_link0= make_transform([0, 0, 0.1], 0, pi/2, 0, trf_link0_E);
length0= 0.6; radius0= 0.02;
h(1)= link_cylinder(radius0, length0, trf_viz_link0, [0.8 0.2 0.2]);


%% Link-1
trf_viz_link1= make_transform([0, 0, 0.1], 0, pi/2, 0);
length1= 0.3; radius1= 0.05;
h(2)= link_cylinder(radius1, length1, trf_viz_link1, [0.823529 0.411765 0.117647]);

%% Link-2
trf_viz_link2= make_transform([0, 0, -0.025], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
length2= 0.2; radius2= 0.04;
h(3)= link_cylinder(radius2, length2, trf_viz_link2, [0, 0, 1]); 


%% Link-3
trf_viz_link3= make_transform([0, 0, -0.15], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
length3= 0.1; radius3= 0.02;
h(4)= link_cylinder(radius3, length3, trf_viz_link3, [0.5, 0.3, 0.3]); 


%% Link-4
trf_viz_link4= make_transform([0, 0, -0.24], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
length4= 0.1; radius4= 0.01;
h(4)= link_cylinder(radius4, length4, trf_viz_link4, [0.5, 0.3, 1]); 


%% Link-5
trf_viz_link5= make_transform([-0.1, 0, -0.28], 0, pi/2, 0); % Do not specify parent yet: It will be done in the joint
length5= 0.2; radius5= 0.01;
h(5)= link_cylinder(radius5, length5, trf_viz_link5, [0.4, 0.4, 1]); 

%% Link-End-Effector
trf_viz_linkEE= make_transform([-0.2, 0, -0.28], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(6)= link_sphere(0.01, trf_viz_linkEE, [1, 0, 0]); 


%% Now define all the joints
j1_translation_axis_j1= [1,0,0]'; %translation done in x axis
j1_translation= 0; % [-0.04, 0.04]

trf_joint1_link0= make_transform([0, 0, 0], 0, 0, 0, trf_link0_E); 
trf_link1_joint1= make_transform_prismatic(j1_translation_axis_j1, j1_translation, trf_joint1_link0);

try3= make_transform([0, 0, 0.1], 0, 0, 0, trf_link1_joint1); 
plot_axes(try3, 'L_1', false, axis_length);

make_child(trf_link1_joint1, trf_viz_link1);


%% Joint: Links 1,2: Fixed
trf_link2_link1= make_transform([0, 0, 0], 0, 0, 0, trf_link1_joint1); 
make_child(trf_link2_link1, trf_viz_link2);

%% Joint2: Links 2,3: Revoulute
j2_rot_axis_j2= [0,0,1]';%tranpose 
j2_rot_angle= 0; % [-pi/2, pi/2]

trf_joint2_link1= make_transform([0, 0, 0], 0, 0, 0, trf_link1_joint1); 
trf_link2_joint2= make_transform_revolute(j2_rot_axis_j2, j2_rot_angle, trf_joint2_link1);

try2= make_transform([0, 0, -0.12], 0, 0, 0, trf_link2_joint2); 
plot_axes(try2, 'L_2', false, axis_length);

make_child(trf_link2_joint2, trf_viz_link3);

%% Joint3: Links 3,4: Prismatic
j3_translation_axis_j3= [0,0,1]'; %translation done in x axis
j3_translation= 0; % [-0.04, 0.04]

trf_joint3_link1= make_transform([0, 0, 0], 0, 0, 0, trf_link2_joint2); 
trf_link2_joint3= make_transform_prismatic(j3_translation_axis_j3, j3_translation, trf_joint3_link1);

try1= make_transform([0, 0, -0.25], 0, 0, 0, trf_link2_joint3); %for printing axes in good position
plot_axes(try1, 'L_3', false, axis_length);

make_child(trf_link2_joint3, trf_viz_link4);

%% Joint: Links 4,3: Fixed
trf_link4_link3= make_transform([0, 0, 0], 0, 0, 0, trf_link2_joint3); 
make_child(trf_link4_link3, trf_viz_link5);

%% Joint: Links 5,3: Fixed
trf_link5_link3= make_transform([0, 0, 0], 0, 0, 0, trf_link2_joint3); 
make_child(trf_link5_link3, trf_viz_linkEE);

%% Animation: One joint at a time

for q1=[linspace(0, -0.1, 30), linspace(-0.1, 0, 30),linspace(0, 0.1, 30),linspace(0.1, 0, 30)]
    set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [-0.4,0.2]);
    trf_q1= makehgtform('translate', j1_translation_axis_j1*q1);
    set(trf_link1_joint1, 'Matrix', trf_q1);
    drawnow;
    pause(0.02);
end

for q2=[linspace(0, -pi/2, 30), linspace(-pi/2, pi/2, 30), linspace(pi/2, 3*pi/2, 30),linspace(3*pi/2,0, 30)]
    set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [-0.4,0.2]);
    trf_q2= makehgtform('axisrotate', j2_rot_axis_j2, q2);
    set(trf_link2_joint2, 'Matrix', trf_q2);
    drawnow;
    pause(0.02);
end

for q3=[linspace(0, 0.04, 30),linspace(0.04, 0, 30),linspace(0, 0.04, 30),linspace(0.04, 0, 30)]
    set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [-0.4,0.2]);
    trf_q3= makehgtform('translate', j3_translation_axis_j3*q3);
    set(trf_link2_joint3, 'Matrix', trf_q3);
    drawnow;
    pause(0.02);
end


%% Animation: All joints together.
q_init= 0.5*ones(4,1); % This leads to all joints being at 0.

for i= 1:20
    q_next= rand(4,1); 
    % rand() gives uniformly distributed random numbers in the interval [0,1]
    
    for t=0:0.02:1
        q= q_init + t*(q_next - q_init);
        q1=(0.08)*(2*q(1) - 1);
        q2=(pi/2)*(2*q(2) - 1);
        q3=(0.03)*(2*q(3));
        
        set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [-0.4,0.2]);
        trf_q1= makehgtform('translate', j1_translation_axis_j1*q1);
        set(trf_link1_joint1, 'Matrix', trf_q1);
        
        set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [-0.4,0.2]);
        trf_q2= makehgtform('axisrotate', j2_rot_axis_j2, q2);
        set(trf_link2_joint2, 'Matrix', trf_q2);
        
        set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [-0.4,0.2]);
        trf_q3= makehgtform('translate', j3_translation_axis_j3*q3);
        set(trf_link2_joint3, 'Matrix', trf_q3);
        
        drawnow;
        pause(0.005);
        
    end
    
    q_init= q_next;
    
end



