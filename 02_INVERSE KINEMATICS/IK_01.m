%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2021/09/23
% Topic: Inverse Kinematics Solution and Optimization of 6DOF Manipulator 
% NOTE: File test động học nghịch
clc;
clear all;
close all;
%%
the1_d=1; the2_d=1; the3_d=1; the4_d=1; the5_d=1; the6_d=1; 
% a1=35; a2=125; a3=-5.4; d1=75; d4=150; d7=30.3;
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;

%y = roll, b = pitch, a = yaw;
% r11 = cos(yaw)*cos(pitch);
% r21 = sin(yaw)*cos(pitch);
% r31 = -sin(pitch);
% r12 = cos(yaw)*sin(pitch)*sin(roll) - sin(yaw)*cos(roll);
% r22 = sin(yaw)*sin(pitch)*sin(roll) + cos(yaw)*cos(roll);
% r32 = cos(pitch)*sin(roll);
% r13 = cos(yaw)*sin(pitch)*cos(roll) + sin(yaw)*sin(roll);
% r23 = sin(yaw)*sin(pitch)*cos(roll) - cos(yaw)*sin(roll);
% r33 = cos(pitch)*cos(roll);

[r11,r21,r31,r12,r22,r32,r13,r23,r33,px,py,pz] = FK_6DOF(the1_d,the2_d,the3_d,the4_d,the5_d,the6_d);

% basic_01: a*cos(x) + b*sin(x) = d
%% The1
% (3,4): py*cos(the1) - px*sin(the1) + r13*d7*sin(the1) - r23*d7*cos(the1) = 0
a_1 = py - r23*d7;
b_1 = - px + r13*d7;
d_1 = 0;
the1 = basic_01(a_1,b_1,d_1)

%% The2
% (1,4): pz*cos(the2) - d1*cos(the2) - a1*sin(the2) + px*cos(the1)*sin(the2) + py*sin(the1)*sin(the2) - r33*d7*cos(the2) - r13*d7*cos(the1)*sin(the2) - r23*d7*sin(the1)*sin(the2)
% (2,4): d1*sin(the2) - a1*cos(the2) - pz*sin(the2) + r33*d7*sin(the2) + px*cos(the1)*cos(the2) + py*cos(the2)*sin(the1) - r13*d7*cos(the1)*cos(the2) - r23*d7*cos(the2)*sin(the1)
u = cos(the1(1))*(px-d7*r13) + sin(the1(1))*(py-r23*d7) - a1;
v = pz - d1 - r33*d7;
% u*sin(the2) + v*cos(the2) = a2 + a3*cos(the3) - d4*sin(the3)
% u*cos(the2) - v*sin(the2) = d4*cos(the3) + a3*sin(the3)
% a3^2 + d4^2 = u^2 + v^2 - 2*a2*u*sin(the2) - 2*a2*v*cos(the2) + a2^2
% u*sin(the2) + v*cos(the2) = (a3^2 + d4^2 - u^2 - v^2 - a2^2)/(-2*a2)
a_2 = v;
b_2 = u;
d_2 = (a3^2+d4^2-u^2-v^2-a2^2)/(-2*a2);
the2 = basic_01(a_2,b_2,d_2)

%% The3
% (1,4) (2,4)
a_3 = a3;
b_3 = d4;
c_3 = u*sin(the2(2)) + v*cos(the2(2)) - a2;
d_3 = u*cos(the2(2)) - v*sin(the2(2));
% basic_02: a*cos(x) - b*sin(x) = c ; b*cos(x) + a*sin(x) = d
the3 = basic_02(a_3,b_3,c_3,d_3)

%% The5
% (1,2) (2,2)
c5 = (r13*cos(the1(1))*cos(the2(2)) - r33*sin(the2(2)) + r23*cos(the2(2))*sin(the1(1)))*cos(the3) - (r33*cos(the2(2)) + r13*cos(the1(1))*sin(the2(2)) + r23*sin(the1(1))*sin(the2(2)))*sin(the3);
the5 = basic_01(1,0,c5)

%% The4
% (1,2) (3,2)
s4 = (r23*cos(the1(1)) - r13*sin(the1(1)))/(sin(the5(1)));
c4 = (r33*cos(the2(2)) + r13*cos(the1(1))*sin(the2(2)) + r23*sin(the1(1))*sin(the2(2)) + sin(the3)*cos(the5(1))) / (-cos(the3)*sin(the5(1)));
the4 = atan2(s4,c4)

%% The6
% (3,1) (3,3)
% r21*cos(the1)*cos(the6) - r11*cos(the6)*sin(the1) - r22*cos(the1)*sin(the6) + r12*sin(the1)*sin(the6)
% cos(the6)*(r21*cos(the1) - r11*sin(the1)) - sin(the6)(r22*cos(the1) - r12*sin(the1)) % A*c6 - B*s6 = C
% r12*cos(the6)*sin(the1) - r21*cos(the1)*sin(the6) - r22*cos(the1)*cos(the6) + r11*sin(the1)*sin(the6)
% -sin(the6)(r21*cos(the1) - r11*sin(the1)) - cos(the6)*(r22*cos(the1 - r12*sin(the1))  % -A*s6 - B*c6 = D
a_6 = r21*cos(the1(1)) - r11*sin(the1(1));
b_6 = r22*cos(the1(1)) - r12*sin(the1(1));
c_6 = -sin(the4)*cos(the5(1));
d_6 = cos(the4);
the6 = basic_02(a_6,b_6,c_6,-d_6)
