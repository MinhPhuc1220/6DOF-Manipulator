clc; clear all; close all;
%%
% im = imread('ironman.jpg');
% % rescale
% im = imresize(im,[250 250]);
% % to gray
% img = rgb2gray(im);
% % get threshold
% thr = graythresh(img);
% imedge = imrotate(edge(img,'sobel'),-90);
% % imedge = ~imbinarize(img,thr);
% 
%  % vi tri x_0_6
% % x_i = -200;
% % y_i = -200;
% % r = 30;
% 
% [m,nn] = size(imedge);
% save = [];
% yt = 0;
% for i = 1:nn
%     for j = 1:m
%         if(imedge(i,j)==1)
%             yt=yt+1;
%             save(yt,1:2) = [i,j] + 100;
%         end
%     end
% end
% px = zeros(length(save(:,1)),1);
% py = zeros(length(save(:,1)),1);
% pz = zeros(length(save(:,1)),1);
%%
l1 = 335;l3 = 270;l4 = 90;l5 = 315;l6 = 40;l7 = 40;
d1 = 75;
Pxee = 400;%randi([-500 500]);
pyee = 300;%randi([-400 400]);
pzee = 200;%randi([-100 100]);
roll = pi/3;
pitch = pi/4;
yaw = 0;

r11 = cos(yaw)*cos(pitch);
r21 = sin(yaw)*cos(pitch);
r31 = -sin(pitch);

r12 = cos(yaw)*sin(pitch)*sin(roll) - sin(yaw)*cos(roll);
r22 = sin(yaw)*sin(pitch)*sin(roll) + cos(yaw)*cos(roll);
r32 = cos(pitch)*sin(roll);

r13 = cos(yaw)*sin(pitch)*cos(roll) + sin(yaw)*sin(roll);
r23 = sin(yaw)*sin(pitch)*cos(roll) - cos(yaw)*sin(roll);
r33 = cos(pitch)*cos(roll);

P_0_5 = [Pxee;pyee;pzee;roll;pitch;yaw];
n = 0.06;
t0 = rand(6,1);
t1 = t0;
px = zeros(400,1);
py = zeros(400,1);
pz = zeros(400,1);
tthe1 = zeros(400,1);
tthe2 = zeros(400,1);
tthe3 = zeros(400,1);
%%
for k=1:400%length(save(:,1))
%     Pxee = -100;
%     pyee = save(k,1);
%     pzee = save(k,2);
%     P_0_5 = [Pxee;pyee;pzee;roll;pitch;yaw];
%     for i =1:400,
        f0 = FK_R6Dof(t0) - P_0_5; % -> 0
%         t1 = t0 - n*transpose(Jac_R6Dof(t0))*inv(Jac_R6Dof(t0)*transpose(Jac_R6Dof(t0)) + 1*eye(6))*f0;
        t1 = t0 - n*pinv(Jac_R6Dof(t1))*f0
        t0 = t1;
%     end
    the1 = t0(1); the2 = t0(2); the3 = t0(3);
    the4 = t0(4); the5 = t0(5); the6 = t0(6);
    tthe1(k) = the1;
    tthe2(k) = the2;
    tthe3(k) = the3;
    x = [ 0,   0, d1*cos(the1), cos(the1)*(d1 + l3*cos(the2)), cos(the1)*(d1 + l4*cos(the2 + the3) + l3*cos(the2)), cos(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)), cos(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)), cos(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)) - (l6 + l7)*(sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) - sin(the2 + the3)*cos(the1)*cos(the5))];
    y = [ 0,   0, d1*sin(the1), sin(the1)*(d1 + l3*cos(the2)), sin(the1)*(d1 + l4*cos(the2 + the3) + l3*cos(the2)), sin(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)), sin(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)), (l6 + l7)*(sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1)) + sin(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2))];
    z = [-l1,  0,           0,                  l3*sin(the2),                  l4*sin(the2 + the3) + l3*sin(the2),                  l4*sin(the2 + the3) - l5*cos(the2 + the3) + l3*sin(the2),                  l4*sin(the2 + the3) - l5*cos(the2 + the3) + l3*sin(the2),                                                              l4*sin(the2 + the3) - l5*cos(the2 + the3) + l3*sin(the2) - (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)];

    px(k) = x(8);
    py(k) = y(8);
    pz(k) = z(8);
    FF = FK_R6Dof(t0);
    figure(1);
    lr = plot3(x,y,z,'-O',px(1:k),py(1:k),pz(1:k),'.r',Pxee,pyee,pzee,'gO');
    set(lr,{'LineWidth','MarkerSize'},{3,6; 2,0.1; 2,9});
    title(['\fontsize{13}',sprintf('x = %.2f, y = %.2f, z = %.2f\n roll = %.2f, pitch = %.2f, yaw = %.2f', FF(1), FF(2), FF(3), FF(4)*180/pi, FF(5)*180/pi, FF(6)*180/pi)]);
    grid on;
    xlim([-750 750]);
    ylim([-750 750]);
    zlim([-750 750]);
    
    pause(0.000000001);
end
orientation = [r11 r12 r13;
               r21 r22 r23;
               r31 r32 r33]
FK_R6Dof(t0)
TTT = transform(t0)
%%
figure(2)
plot(tthe1,'linewidth',2)
figure(3)
plot(tthe2,'linewidth',2)
figure(4)
plot(tthe3,'linewidth',2)