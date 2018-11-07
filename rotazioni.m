clear;
close all;
clc;
set(0,'defaulttextinterpreter','latex');

b = 4;
h = 4;

P = [1; 2; 3];
GND = zeros(3,1);

phi = deg2rad(-0);
theta = deg2rad(-0);
psi = deg2rad(25);

GND_1 = GND + [b/2;h/2;0];
GND_2 = GND + [-b/2;h/2;0];
GND_3 = GND + [-b/2;-h/2;0];
GND_4 = GND + [b/2;-h/2;0];


R = eul2rotm([psi theta phi]);

GND = R*GND;
GND_1 = R*GND_1;
GND_2 = R*GND_2;
GND_3 = R*GND_3;
GND_4 = R*GND_4;

inertial_frame = eye(3);

local_frame = R*inertial_frame;


figure;
plot3(GND(1),GND(2),GND(3),'ok','MarkerFaceColor','r'); hold on;
plot3(GND_1(1),GND_1(2),GND_1(3),'ok','MarkerFaceColor','b');
plot3(GND_2(1),GND_2(2),GND_2(3),'ok','MarkerFaceColor','b');
plot3(GND_3(1),GND_3(2),GND_3(3),'ok','MarkerFaceColor','b');
plot3(GND_4(1),GND_4(2),GND_4(3),'ok','MarkerFaceColor','b');
plot3([GND_1(1) GND_4(1)],[GND_1(2) GND_4(2)],[GND_1(3) GND_4(3)],'k');
plot3([GND_1(1) GND_2(1)],[GND_1(2) GND_2(2)],[GND_1(3) GND_2(3)],'k');
plot3([GND_3(1) GND_4(1)],[GND_3(2) GND_4(2)],[GND_3(3) GND_4(3)],'k');
plot3([GND_2(1) GND_3(1)],[GND_2(2) GND_3(2)],[GND_2(3) GND_3(3)],'k');

plot3([GND(1) GND(1) + inertial_frame(1,1)],[GND(2) GND(2) + inertial_frame(2,1)],[GND(3) GND(3) + inertial_frame(3,1)],'k',...
      [GND(1) GND(1) + inertial_frame(1,2)],[GND(2) GND(2) + inertial_frame(2,2)],[GND(3) GND(3) + inertial_frame(3,2)],'k',...
      [GND(1) GND(1) + inertial_frame(1,3)],[GND(2) GND(2) + inertial_frame(2,3)],[GND(3) GND(3) + inertial_frame(3,3)],'k');
plot3([GND(1) GND(1)+ local_frame(1,1)],[GND(2) GND(2)+ local_frame(2,1)],[GND(3) GND(3)+local_frame(3,1)],'r',...
      [GND(1) GND(1)+ local_frame(1,2)],[GND(2) GND(2)+ local_frame(2,2)],[GND(3) GND(3)+local_frame(3,2)],'r',...
      [GND(1) GND(1)+ local_frame(1,3)],[GND(2) GND(2)+ local_frame(2,3)],[GND(3) GND(3)+local_frame(3,3)],'r'); 
plot3([P(1) P(1) + inertial_frame(1,1)],[P(2) P(2) + inertial_frame(2,1)],[P(3) P(3) + inertial_frame(3,1)],'m',...
      [P(1) P(1) + inertial_frame(1,2)],[P(2) P(2) + inertial_frame(2,2)],[P(3) P(3) + inertial_frame(3,2)],'m',...
      [P(1) P(1) + inertial_frame(1,3)],[P(2) P(2) + inertial_frame(2,3)],[P(3) P(3) + inertial_frame(3,3)],'m');

  
plot3(P(1),P(2),P(3),'om','MarkerFaceColor','k');

plot3([0 P(1)],[0 P(2)],[0 P(3)],'-.k',...
      [0 GND(1)],[0 GND(2)],[0 GND(3)],'-.k',...
      [GND(1) P(1)],[GND(2) P(2)],[GND(3) P(3)],'-.r');
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
axis equal;
title('Absolute POV');
grid on;



distance_vector_absolute_coordinates = P-GND;
distance_vector_local_coordinates = R'*distance_vector_absolute_coordinates
% 
% figure;
% plot3([GND(1) distance_vector_local_coordinates(1)],...
%       [GND(2) distance_vector_local_coordinates(2)],...
%       [GND(3) distance_vector_local_coordinates(3)],'g');
% 
% xlabel('x [m]');
% ylabel('y [m]');
% zlabel('z [m]');
% axis equal;
% title('Platform POV');
% grid on;