% clear;
% close all;
% clc;
% set(0,'defaulttextinterpreter','latex');

%%

datamov = dlmread('cc_multiple_points_out.mov');

ground = datamov(datamov(:,1)==0,:);
% ground_1 = datamov(datamov(:,1)==1,:);
ball = datamov(datamov(:,1)==100,:);
ball_1 = datamov(datamov(:,1)==101,:);
ball_2 = datamov(datamov(:,1)==102,:);
ball_3 = datamov(datamov(:,1)==103,:);


% lx = 30;
% ly = 30;

R = eul2rotm([deg2rad(GND_psi) deg2rad(GND_theta) deg2rad(GND_phi)]);
% gg = R*[lx -lx -lx lx
%         ly  ly -ly -ly
%         0  0  0  0];
%   


dt = 1e-3;
N = length(ball_1);

time = 0:dt:(N-1)*dt;

figure;

for k = 1:500:N
    
    R_om = eul2rotm([deg2rad(ground(k,7)) deg2rad(ground(k,6)) deg2rad(ground(k,5))]);
    
    gg = (ground(k,2:4)' +  R*[lx -lx -lx  lx
                                    ly  ly -ly -ly
                                     0   0   0   0]);
        
%     plot3(ball(k,2),ball(k,3),ball(k,4),'om','MarkerFaceColor','k'); hold on;
%     plot3(ball(1:k,2),ball(1:k,3),ball(1:k,4),'m');
    plot3(ball_1(k,2),ball_1(k,3),ball_1(k,4),'om','MarkerFaceColor','k'); hold on;
    plot3(ball_1(1:k,2),ball_1(1:k,3),ball_1(1:k,4),'m');
    plot3(ball_2(k,2),ball_2(k,3),ball_2(k,4),'om','MarkerFaceColor','k');
    plot3(ball_2(1:k,2),ball_2(1:k,3),ball_2(1:k,4),'m');
    plot3(ball_3(k,2),ball_3(k,3),ball_3(k,4),'om','MarkerFaceColor','k');
    plot3(ball_3(1:k,2),ball_3(1:k,3),ball_3(1:k,4),'m');
    plot3(ground(k,2),ground(k,3),ground(k,4),'ok','MarkerFaceColor','r');
    plot3([gg(1,1) gg(1,2)],[gg(2,1) gg(2,2)],[gg(3,1) gg(3,2)],'k');
    plot3([gg(1,2) gg(1,3)],[gg(2,2) gg(2,3)],[gg(3,2) gg(3,3)],'k');
    plot3([gg(1,3) gg(1,4)],[gg(2,3) gg(2,4)],[gg(3,3) gg(3,4)],'k');
    plot3([gg(1,4) gg(1,1)],[gg(2,4) gg(2,1)],[gg(3,4) gg(3,1)],'k');
    
    plot3([ball_1(k,2) ball_2(k,2)],[ball_1(k,3) ball_2(k,3)],[ball_1(k,4) ball_2(k,4)],'k');
    plot3([ball_1(k,2) ball_3(k,2)],[ball_1(k,3) ball_3(k,3)],[ball_1(k,4) ball_3(k,4)],'k');
    plot3([ball_3(k,2) ball_2(k,2)],[ball_3(k,3) ball_2(k,3)],[ball_3(k,4) ball_2(k,4)],'k');
%     plot3(ground_1(k,2),ground_1(k,3),ground_1(k,4),'dk','MarkerFaceColor','c');
    title(strcat('time =',num2str(time(k)),' s'));
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('z [m]');
    grid on;
    drawnow;
    
    axis equal;
    hold off;
end
