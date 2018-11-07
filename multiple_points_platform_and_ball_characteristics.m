clear;
close all;
clc;

%% MATTEO DANIELE 
% platform characteristics creation for cc_main example

% platform position
GND_X = 0.0;
GND_Y = 0.0;
GND_Z = 0.0;

% rectangular platform base [m]
lx = 10;
% rectangular platform height [m]
ly = 10;

% platform orientation in euler angles [deg]
PLATFORM_phi = 45.0;
PLATFORM_theta = -25.0;
PLATFORM_psi = 15.0;

% platform stiffness and damping
% damping factor
mu_z = 300.0;
% desired platform deformation at rest
delta_z_rest = 1.e-4;

% coulomb friction value (offset)
Coulomb_friction_value = .5;
% coefficient of viscous friction (gain)
coefficient_viscous_friction = 0.05;
% cosine flag threshold
ctflag_threshold = 3.9;
% local distance from ground threshold
dz_threshold = 0;

% normal reaction parameters
ground_stiffness = 1e9;
restitution_coefficient = 0.2;
% flores
dissipation_coefficient_model = 1; %2 %3
% impact_speed_threshold
impact_speed_threshold = 0.2;
% reaction_force exponential
reaction_force_exponential = 3;
% force sign
force_sign = -1;

%% three-point mass, dimensions and initial conditions
% initial position [m]
XB = 1.0;
YB = 1.0;
ZB = 15.0;

% initial triangular body orientation in euler angles [deg]
PhiB = 15.0;
ThetaB = 15.0;
PsiB = 0.0;

RB = eul2rotm([deg2rad(PsiB) deg2rad(ThetaB) deg2rad(PhiB)]);

% initial body velocity [m/s]
VXB = 0.0;
VYB = 0.0;
VZB = 0.0;
% initial body angular velocity (deg/s)
OmXB = 0.0;
OmYB = 0.0;
OmZB = 0.0;
% mass and moment of inertia
M_BALL = 14600;
R_BALL = 0.05;
I_BALL = (2/5)*M_BALL*(R_BALL^2);

% position of the triangle points
DT = 2; % distance from center in meters
T = zeros(3);
for k = 1:3
RT = eul2rotm([(k-1)*2*pi/3 0.0 0.0]);
T(:,k) =  [XB;YB;ZB] + RB*(RT*[DT; 0; 0]);

end


% bounding sphere to trigger contacts is automatically chosen as a multiple
% of the major dimension of the platform: if the distance between
% the ground point and the center of the body is below this value, the
% contact verification is activated, otherwise it is completely ignored

%% platform_and_ball_characteristics.set useful for MBDyn

ID = fopen('multiple_points_platform_and_ball_characteristics.set','w');
fprintf(ID,'# platform characteristics \n');
fprintf(ID,strcat('set: real Platform_Base = ',num2str(lx),'; \n'));
fprintf(ID,strcat('set: real Platform_Height = ',num2str(ly),'; \n'));
fprintf(ID,strcat('set: real GND_X = ',num2str(GND_X),'; \n'));
fprintf(ID,strcat('set: real GND_Y = ',num2str(GND_Y),'; \n'));
fprintf(ID,strcat('set: real GND_Z = ',num2str(GND_Z),'; \n'));
fprintf(ID,strcat('set: real Phi_GND = ',num2str(PLATFORM_phi),'*deg2rad; \n'));
fprintf(ID,strcat('set: real Theta_GND = ',num2str(PLATFORM_theta),'*deg2rad; \n'));
fprintf(ID,strcat('set: real Psi_GND = ',num2str(PLATFORM_psi),'*deg2rad; \n'));
fprintf(ID,'\n');
fprintf(ID,'# platform deformation factors \n');
fprintf(ID,strcat('set: real MU_Z = ',num2str(mu_z),'; \n'));
fprintf(ID,strcat('set: real DELTA_Z_REST = ',num2str(delta_z_rest),'; \n'));
fprintf(ID,'\n');
fprintf(ID,'# triangular object characteristics \n');
fprintf(ID,strcat('set: real XB = ',num2str(XB),'; \n'));
fprintf(ID,strcat('set: real YB = ',num2str(YB),'; \n'));
fprintf(ID,strcat('set: real ZB = ',num2str(ZB),'; \n'));

fprintf(ID,strcat('set: real VXB = ',num2str(VXB),'; \n'));
fprintf(ID,strcat('set: real VYB = ',num2str(VYB),'; \n'));
fprintf(ID,strcat('set: real VZB = ',num2str(VZB),'; \n'));

fprintf(ID,strcat('set: real PhiB = ',num2str(PhiB),'*deg2rad; \n'));
fprintf(ID,strcat('set: real ThetaB = ',num2str(ThetaB),'*deg2rad; \n'));
fprintf(ID,strcat('set: real PsiB = ',num2str(PsiB),'*deg2rad; \n'));

fprintf(ID,strcat('set: real OmXB = ',num2str(OmXB),'*deg2rad; \n'));
fprintf(ID,strcat('set: real OmYB = ',num2str(OmYB),'*deg2rad; \n'));
fprintf(ID,strcat('set: real OmZB = ',num2str(OmZB),'*deg2rad; \n'));

fprintf(ID,strcat('set: real T1X = ',num2str(T(1,1)),'; \n'));
fprintf(ID,strcat('set: real T1Y = ',num2str(T(2,1)),'; \n'));
fprintf(ID,strcat('set: real T1Z = ',num2str(T(3,1)),'; \n'));

fprintf(ID,strcat('set: real T2X = ',num2str(T(1,2)),'; \n'));
fprintf(ID,strcat('set: real T2Y = ',num2str(T(2,2)),'; \n'));
fprintf(ID,strcat('set: real T2Z = ',num2str(T(3,2)),'; \n'));

fprintf(ID,strcat('set: real T3X = ',num2str(T(1,3)),'; \n'));
fprintf(ID,strcat('set: real T3Y = ',num2str(T(2,3)),'; \n'));
fprintf(ID,strcat('set: real T3Z = ',num2str(T(3,3)),'; \n'));

fprintf(ID,'\n');
fprintf(ID,strcat('set: real M_BALL = ',num2str(M_BALL),'; \n'));
fprintf(ID,strcat('set: real R_BALL = ',num2str(R_BALL),'; \n'));
fprintf(ID,strcat('set: real I_BALL = ',num2str(I_BALL),'; \n'));
fclose(ID);

%% plot of the initial conditions

vnorm = [VXB; VYB; VZB];%/norm([VXB VYB VZB]);

R = eul2rotm([deg2rad(PLATFORM_psi) deg2rad(PLATFORM_theta) deg2rad(PLATFORM_phi)]);
    
    gg = R*[lx -lx -lx lx
            ly  ly -ly -ly
            0  0  0  0] + [GND_X;GND_Y;GND_Z];
figure;
plot3(XB,YB,ZB,'om','MarkerFaceColor','k'); hold on;
plot3([XB XB+vnorm(1)],[YB YB+vnorm(2)],[ZB ZB+vnorm(3)],'b');
plot3(GND_X,GND_Y,GND_Z,'ok','MarkerFaceColor','r');
plot3([gg(1,1) gg(1,2)],[gg(2,1) gg(2,2)],[gg(3,1) gg(3,2)],'k');
plot3([gg(1,2) gg(1,3)],[gg(2,2) gg(2,3)],[gg(3,2) gg(3,3)],'k');
plot3([gg(1,3) gg(1,4)],[gg(2,3) gg(2,4)],[gg(3,3) gg(3,4)],'k');
plot3([gg(1,4) gg(1,1)],[gg(2,4) gg(2,1)],[gg(3,4) gg(3,1)],'k');
plot3([T(1,1) T(1,2)],[T(2,1) T(2,2)],[T(3,1) T(3,2)],'m',...
      [T(1,2) T(1,3)],[T(2,2) T(2,3)],[T(3,2) T(3,3)],'m',...
      [T(1,3) T(1,1)],[T(2,3) T(2,1)],[T(3,3) T(3,1)],'m');
plot3(T(1,1),T(2,1),T(3,1),'om','MarkerFaceColor','k'); hold on;
plot3(T(1,2),T(2,2),T(3,2),'om','MarkerFaceColor','k');
plot3(T(1,3),T(2,3),T(3,3),'om','MarkerFaceColor','k');


title('System at initial conditions');
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
grid on;
axis equal;
hold off;

legend('Flying Object',...
       'V_0 direction',...
       'platform center',...
       'platform','Location','best');


