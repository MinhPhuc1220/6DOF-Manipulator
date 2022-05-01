%% Authors:
% Made by Tran Minh Phuc
% Date: 2022/05/01:
% NOTE: plot cau hinh robot (OK)

clc; clear all;
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;
e1 = 0; e2 = 0; e3 = 0; e4 = 0; e5 = 0; e6 = 0;
P = ...
[  0, a1*cos(e1), cos(e1)*(a1 + a2*sin(e2)), cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)), cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)), cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)), cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - d7*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5));
   0, a1*sin(e1), sin(e1)*(a1 + a2*sin(e2)), sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)), sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)), sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)), sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) + d7*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1));
  d1,         d1,           d1 + a2*cos(e2),           d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2),           d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2),           d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2),                                               d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) - d7*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5)) + a2*cos(e2)];

plot3(P(1,:), P(2,:), P(3,:),'-O','linewidth',2)
grid on