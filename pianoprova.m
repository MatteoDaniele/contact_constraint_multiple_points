clear;
close all;
clc;
set(0,'defaulttextinterpreter','latex');

b = 4;
h = 4;

GND = zeros(3,1);
GND_1 = GND + [b/2;h/2;0];
GND_2 = GND + [-b/2;h/2;0];
GND_3 = GND + [-b/2;-h/2;0];
GND_4 = GND + [b/2;-h/2;0];
%%
phi = deg2rad(5);
theta = deg2rad(-0);
psi = deg2rad(0);

R = eul2rotm([psi theta phi]);

GND = R*GND;
GND_1 = R*GND_1;
GND_2 = R*GND_2;
GND_3 = R*GND_3;
GND_4 = R*GND_4;

z = cross(GND_1,GND_2);
z = z/norm(z);
zb = -z;

time = linspace(0,1);
dt = diff(time(1:2));
N = length(time);
P = zeros(3,N);
P(1,:) = .5*ones(1,length(time));%.5*b*cos(100*time);
P(2,:) = 1*ones(1,length(time));%.5*h*sin(100*time);%1*ones(1,length(time));
P(3,:) = 3-9.81*time.^2;

ctflag = zeros(1,N);
ct12 = zeros(1,N);
ct23 = ct12;
ct34 = ct23;
ct41 = ct34;
m_ctflag = zeros(1,N);

figure;
for k = 1:N
Pk = P(:,k);

PG = Pk-GND;
PG_1 = Pk-GND_1;
PG_2 = Pk-GND_2;
PG_3 = Pk-GND_3;
PG_4 = Pk-GND_4;

PG_unit = PG/norm(PG);
PG_1_unit = PG_1/norm(PG_1);
PG_2_unit = PG_2/norm(PG_2);
PG_3_unit = PG_3/norm(PG_3);
PG_4_unit = PG_4/norm(PG_4);


% plane normals created by vector distances
z12 = cross(PG_1_unit,PG_2_unit);
z23 = cross(PG_2_unit,PG_3_unit);
z34 = cross(PG_3_unit,PG_4_unit);
z41 = cross(PG_4_unit,PG_1_unit);
% inverted plane normals created by vector distances
% z12 = cross(PG_2_unit,PG_1_unit);
% z23 = cross(PG_3_unit,PG_2_unit);
% z34 = cross(PG_4_unit,PG_3_unit);
% z41 = cross(PG_1_unit,PG_4_unit);

z12 = z12/norm(z12);
z23 = z23/norm(z23);
z34 = z34/norm(z34);
z41 = z41/norm(z41);

% cosine of the angle between z and zij
ct12(k) = z12'*z;
ct23(k) = z23'*z;
ct34(k) = z34'*z;
ct41(k) = z41'*z;
% cosine of the angle between zb and zij
% ct12(k) = z12'*zb;
% ct23(k) = z23'*zb;
% ct34(k) = z34'*zb;
% ct41(k) = z41'*zb;

% all cosines close to unit means that contact happens
ctflag(k) = ct12(k)+ct23(k)+ct34(k)+ct41(k);



plot3(GND(1),GND(2),GND(3),'ok','MarkerFaceColor','r'); hold on;
plot3(GND_1(1),GND_1(2),GND_1(3),'ok','MarkerFaceColor','b');
plot3(GND_2(1),GND_2(2),GND_2(3),'ok','MarkerFaceColor','b');
plot3(GND_3(1),GND_3(2),GND_3(3),'ok','MarkerFaceColor','b');
plot3(GND_4(1),GND_4(2),GND_4(3),'ok','MarkerFaceColor','b');
plot3([GND_1(1) GND_4(1)],[GND_1(2) GND_4(2)],[GND_1(3) GND_4(3)],'k');
plot3([GND_1(1) GND_2(1)],[GND_1(2) GND_2(2)],[GND_1(3) GND_2(3)],'k');
plot3([GND_3(1) GND_4(1)],[GND_3(2) GND_4(2)],[GND_3(3) GND_4(3)],'k');
plot3([GND_2(1) GND_3(1)],[GND_2(2) GND_3(2)],[GND_2(3) GND_3(3)],'k');
plot3(Pk(1),Pk(2),Pk(3),'ok','MarkerFaceColor','c');

plot3([GND_1(1) Pk(1)],[GND_1(2) Pk(2)],[GND_1(3) Pk(3)],'r');
plot3([GND_2(1) Pk(1)],[GND_2(2) Pk(2)],[GND_2(3) Pk(3)],'r');
plot3([GND_3(1) Pk(1)],[GND_3(2) Pk(2)],[GND_3(3) Pk(3)],'r');
plot3([GND_4(1) Pk(1)],[GND_4(2) Pk(2)],[GND_4(3) Pk(3)],'r');
plot3([z(1)+GND(1) GND(1)],[z(2)+GND(2) GND(2)],[z(3)+GND(3) GND(3)],'c');
plot3([zb(1)+GND(1) GND(1)],[zb(2)+GND(2) GND(2)],[zb(3)+GND(3) GND(3)],'r');
plot3([z12(1)+GND(1) GND(1)],[z12(2)+GND(2) GND(2)],[z12(3)+GND(3) GND(3)],'g');
plot3([z23(1)+GND(1) GND(1)],[z23(2)+GND(2) GND(2)],[z23(3)+GND(3) GND(3)],'b');
plot3([z34(1)+GND(1) GND(1)],[z34(2)+GND(2) GND(2)],[z34(3)+GND(3) GND(3)],'m');
plot3([z41(1)+GND(1) GND(1)],[z41(2)+GND(2) GND(2)],[z41(3)+GND(3) GND(3)],'y');

plot3(P(1,1:k),P(2,1:k),P(3,1:k));

grid on;
xlabel('x [m]');ylabel('y [m]');zlabel('z [m]');
axis equal;
title(strcat('t=',num2str(time(k)),' z=',num2str(Pk(3)),' ctflag =',num2str(ctflag(k))));
drawnow;
hold off;

bling = 1;
if Pk(3) <= 0
    disp('simulation paused');
    pause;
%     bling = 
end


end

figure;
plot(time,ctflag,'o',time,ctflag,'-'); hold on;
title('ctflag');
grid on;



