%% Authors:
% Made by Tran Minh Phuc
% Date: 2021/03/29:
% NOTE:  Co xet vi tri trong tam, moment quan tinh, khoi luong tung khau
clc;
clear all;
close all;
syms e1 e2 e3 e4 e5 e6 
syms de1 de2 de3 de4 de5 de6 
syms dde1 dde2 dde3 dde4 dde5 dde6 
syms a1 a2 a3 d1 d4 d7 
syms m1 m2 m3 m4 m5 m6 
syms I1 I2 I3 I4 I5 I6 
syms g 
syms x1 x2 x3 x4 x5 x6 x7 
syms y1 y2 y3 y4 y5 y6 y7 
syms z1 z2 z3 z4 z5 z6 z7 
syms I1xx I1xy I1xz I1yx I1yy I1yz I1zx I1zy I1zz 
syms I2xx I2xy I2xz I2yx I2yy I2yz I2zx I2zy I2zz 
syms I3xx I3xy I3xz I3yx I3yy I3yz I3zx I3zy I3zz 
syms I4xx I4xy I4xz I4yx I4yy I4yz I4zx I4zy I4zz 
syms I5xx I5xy I5xz I5yx I5yy I5yz I5zx I5zy I5zz 
syms I6xx I6xy I6xz I6yx I6yy I6yz I6zx I6zy I6zz 
%% INTIAL VALUE
w0 = [0 0 0].';
v0 = [0 0 0].';
% POSITION OF CENTER OF MASS IN EACH LINKAGE:
P1c = [x1 y1 z1].';
P2c = [x2 y2 z2].';
P3c = [x3 y3 z3].';
P4c = [x4 y4 z4].';
P5c = [x5 y5 z5].';
P6c = [x6 y6 z6].';
% MOMENTS OF INERTIA
% I1 = [I1xx, I1xy, I1xz;
%       I1yx, I1yy, I1yz;
%       I1zx, I1zy, I1zz];
% I2 = [I2xx, I2xy, I2xz;
%       I2yx, I2yy, I2yz;
%       I2zx, I2zy, I2zz];
% I3 = [I3xx, I3xy, I3xz;
%       I3yx, I3yy, I3yz;
%       I3zx, I3zy, I3zz];
% I4 = [I4xx, I4xy, I4xz;
%       I4yx, I4yy, I4yz;
%       I4zx, I4zy, I4zz];
% I5 = [I5xx, I5xy, I5xz;
%       I5yx, I5yy, I5yz;
%       I5zx, I5zy, I5zz];
% I6 = [I6xx, I6xy, I6xz;
%       I6yx, I6yy, I6yz;
%       I6zx, I6zy, I6zz];
I1 = [I1xx,    0,    0;
         0, I1yy,    0;
         0,    0, I1zz];
I2 = [I2xx,    0,    0;
         0, I2yy,    0;
         0,    0, I2zz];
I3 = [I3xx,    0,    0;
         0, I3yy,    0;
         0,    0, I3zz];
I4 = [I4xx,    0,    0;
         0, I4yy,    0;
         0,    0, I4zz];
I5 = [I5xx,    0,    0;
         0, I5yy,    0;
         0,    0, I5zz];
I6 = [I6xx,    0,    0;
         0, I6yy,    0;
         0,    0, I6zz];
%% FORWARD KINEMATICS
[T01,R01,R10,P01] = FKRobot2021(0,0,d1,e1);
[T12,R12,R21,P12] = FKRobot2021(a1,sym(-pi/2),0,e2-sym(pi/2));
[T23,R23,R32,P23] = FKRobot2021(a2,0,0,e3);
[T34,R34,R43,P34] = FKRobot2021(a3,sym(-pi/2),d4,e4);
[T45,R45,R54,P45] = FKRobot2021(0,sym(pi/2),0,e5);
[T56,R56,R65,P56] = FKRobot2021(0,sym(-pi/2),0,e6);
[T67,R67,R76,P67] = FKRobot2021(0,0,d7,0);
%% LINKAGE 1:
% Center of mass position of the first link in frame 0.
TP01c = (T01*[P1c; 1]);
P01c = TP01c(1:3);
% Angular velocity in frame 1:
w1 = simplify(R10*w0 + de1*[0;0;1])
% Linear velocity of the origin in frame 1:
v1 = simplify(R10*(v0 + cross(w0,P01)))
% Linear velocity in frame 0:
v01 = R01*v1;
% Linear velocity of the center of mass in frame 0:
v01c = simplify(R01*(v1 + cross(w1,P1c)))
v01c_ = simplify(diff(P01c,e1)*de1 + diff(P01c,e2)*de2 + diff(P01c,e3)*de3 + diff(P01c,e4)*de4 + diff(P01c,e5)*de5 + diff(P01c,e6)*de6)
err1 = simplify(expand(v01c - v01c_))
%% LINKAGE 2:
% Center of mass position of the first link in frame 0.
TP02c = (T01*T12*[P2c; 1]);
P02c = TP02c(1:3);
% Angular velocity in frame 1:
w2 = simplify(R21*w1 + de2*[0;0;1])
% Linear velocity of the origin in frame 1:
v2 = simplify(R21*(v1 + cross(w1,P12)))
% Linear velocity in frame 0:
v02 = R01*R12*v2;
% Linear velocity of the center of mass in frame 0:
v02c = simplify(R01*R12*(v2 + cross(w2,P2c)))
v02c_ = simplify(diff(P02c,e1)*de1 + diff(P02c,e2)*de2 + diff(P02c,e3)*de3 + diff(P02c,e4)*de4 + diff(P02c,e5)*de5 + diff(P02c,e6)*de6)
err2 = simplify(expand(v02c - v02c_))
%% LINKAGE 3:
% Center of mass position of the first link in frame 0.
TP03c = (T01*T12*T23*[P3c; 1]);
P03c = TP03c(1:3);
% Angular velocity in frame 1:
w3 = simplify(R32*w2 + de3*[0;0;1])
% Linear velocity of the origin in frame 1:
v3 = simplify(R32*(v2 + cross(w2,P23)))
% Linear velocity in frame 0:
v03 = R01*R12*R23*v3;
% Linear velocity of the center of mass in frame 0:
v03c = simplify(R01*R12*R23*(v3 + cross(w3,P3c)))
v03c_ = simplify(diff(P03c,e1)*de1 + diff(P03c,e2)*de2 + diff(P03c,e3)*de3 + diff(P03c,e4)*de4 + diff(P03c,e5)*de5 + diff(P03c,e6)*de6)
err3 = simplify(expand(v03c - v03c_))
%% LINKAGE 4:
% Center of mass position of the first link in frame 0.
TP04c = (T01*T12*T23*T34*[P4c; 1]);
P04c = TP04c(1:3);
% Angular velocity in frame 1:
w4 = simplify(R43*w3 + de4*[0;0;1])
% Linear velocity of the origin in frame 1:
v4 = simplify(R43*(v3 + cross(w3,P34)))
% Linear velocity in frame 0:
v04 = R01*R12*R23*R34*v4;
% Linear velocity of the center of mass in frame 0:
v04c = simplify(R01*R12*R23*R34*(v4 + cross(w4,P4c)))
v04c_ = simplify(diff(P04c,e1)*de1 + diff(P04c,e2)*de2 + diff(P04c,e3)*de3 + diff(P04c,e4)*de4 + diff(P04c,e5)*de5 + diff(P04c,e6)*de6)
err4 = simplify(expand(v04c - v04c_))
%% LINKAGE 5:
% Center of mass position of the first link in frame 0.
TP05c = (T01*T12*T23*T34*T45*[P5c; 1]);
P05c = TP05c(1:3);
% Angular velocity in frame 1:
w5 = simplify(R54*w4 + de5*[0;0;1])
% Linear velocity of the origin in frame 1:
v5 = simplify(R54*(v4 + cross(w4,P45)))
% Linear velocity in frame 0:
v05 = R01*R12*R23*R34*R45*v5;
% Linear velocity of the center of mass in frame 0:
v05c = simplify(R01*R12*R23*R34*R45*(v5 + cross(w5,P5c)))
v05c_ = simplify(diff(P05c,e1)*de1 + diff(P05c,e2)*de2 + diff(P05c,e3)*de3 + diff(P05c,e4)*de4 + diff(P05c,e5)*de5 + diff(P05c,e6)*de6)
err5 = simplify(expand(v05c - v05c_))
%% LINKAGE 6:
% Center of mass position of the first link in frame 0.
TP06c = (T01*T12*T23*T34*T45*T56*[P6c; 1]);
P06c = TP06c(1:3);
% Angular velocity in frame 1:
w6 = simplify(R65*w5 + de6*[0;0;1])
% Linear velocity of the origin in frame 1:
v6 = simplify(R65*(v5 + cross(w5,P56)))
% Linear velocity in frame 0:
v06 = R01*R12*R23*R34*R45*R56*v6;
% Linear velocity of the center of mass in frame 0:
v06c = simplify(R01*R12*R23*R34*R45*R56*(v6 + cross(w6,P6c)))
v06c_ = simplify(diff(P06c,e1)*de1 + diff(P06c,e2)*de2 + diff(P06c,e3)*de3 + diff(P06c,e4)*de4 + diff(P06c,e5)*de5 + diff(P06c,e6)*de6)
err6 = simplify(expand(v06c - v06c_))
%% check THN
 
V_0_1 = ...
[-de1*(y1*cos(e1) + x1*sin(e1));
  de1*(x1*cos(e1) - y1*sin(e1));
                             0]
er1 = simplify(v01c - V_0_1)
 
V_0_2 = ...
[de2*cos(e1)*(x2*cos(e2)-y2*sin(e2))-de1*(a1*sin(e1)+z2*cos(e1)+y2*cos(e2)*sin(e1)+x2*sin(e1)*sin(e2));
 de1*(a1*cos(e1)-z2*sin(e1)+y2*cos(e1)*cos(e2)+x2*cos(e1)*sin(e2))+de2*sin(e1)*(x2*cos(e2)-y2*sin(e2));
                                                                          -de2*(y2*cos(e2)+x2*sin(e2))]
 
er2 = simplify(v02c - V_0_2) 
V_0_3 = ...
[ de3*cos(e1)*(x3*cos(e2 + e3) - y3*sin(e2 + e3)) - de1*(a1*sin(e1) + z3*cos(e1) + y3*cos(e2 + e3)*sin(e1) + x3*sin(e2 + e3)*sin(e1) + a2*sin(e1)*sin(e2)) + de2*cos(e1)*(x3*cos(e2 + e3) - y3*sin(e2 + e3) + a2*cos(e2));
  de1*(a1*cos(e1) - z3*sin(e1) + y3*cos(e2 + e3)*cos(e1) + x3*sin(e2 + e3)*cos(e1) + a2*cos(e1)*sin(e2)) + de3*sin(e1)*(x3*cos(e2 + e3) - y3*sin(e2 + e3)) + de2*sin(e1)*(x3*cos(e2 + e3) - y3*sin(e2 + e3) + a2*cos(e2));
                                                                                                                         - de3*(y3*cos(e2 + e3) + x3*sin(e2 + e3)) - de2*(y3*cos(e2 + e3) + x3*sin(e2 + e3) + a2*sin(e2))]
 
er3 = simplify(v03c - V_0_3)
V_0_4 = ...
[ de1*(x4*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + y4*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)) - sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - z4*cos(e2 + e3)*sin(e1)) - de4*(y4*sin(e1)*sin(e4) - x4*cos(e4)*sin(e1) + y4*sin(e2 + e3)*cos(e1)*cos(e4) + x4*sin(e2 + e3)*cos(e1)*sin(e4)) - de3*cos(e1)*(d4*sin(e2 + e3) - a3*cos(e2 + e3) + z4*sin(e2 + e3) - x4*cos(e2 + e3)*cos(e4) + y4*cos(e2 + e3)*sin(e4)) + de2*cos(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3) - z4*sin(e2 + e3) + a2*cos(e2) + x4*cos(e2 + e3)*cos(e4) - y4*cos(e2 + e3)*sin(e4));
  de1*(x4*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + y4*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) + cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) + z4*cos(e2 + e3)*cos(e1)) - de4*(x4*cos(e1)*cos(e4) - y4*cos(e1)*sin(e4) + y4*sin(e2 + e3)*cos(e4)*sin(e1) + x4*sin(e2 + e3)*sin(e1)*sin(e4)) - de3*sin(e1)*(d4*sin(e2 + e3) - a3*cos(e2 + e3) + z4*sin(e2 + e3) - x4*cos(e2 + e3)*cos(e4) + y4*cos(e2 + e3)*sin(e4)) + de2*sin(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3) - z4*sin(e2 + e3) + a2*cos(e2) + x4*cos(e2 + e3)*cos(e4) - y4*cos(e2 + e3)*sin(e4));
                                                                                                                                                                                                                                                                                                        - de2*(d4*cos(e2 + e3) + a3*sin(e2 + e3) + z4*cos(e2 + e3) + a2*sin(e2) + x4*sin(e2 + e3)*cos(e4) - y4*sin(e2 + e3)*sin(e4)) - de3*(d4*cos(e2 + e3) + a3*sin(e2 + e3) + z4*cos(e2 + e3) + x4*sin(e2 + e3)*cos(e4) - y4*sin(e2 + e3)*sin(e4)) - de4*cos(e2 + e3)*(y4*cos(e4) + x4*sin(e4))]
 
 er4 = simplify(v04c - V_0_4)
V_0_5 = ...
[ de3*(cos(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3)) - x5*(sin(e2 + e3)*cos(e1)*sin(e5) - cos(e2 + e3)*cos(e1)*cos(e4)*cos(e5)) - y5*(sin(e2 + e3)*cos(e1)*cos(e5) + cos(e2 + e3)*cos(e1)*cos(e4)*sin(e5)) + z5*cos(e2 + e3)*cos(e1)*sin(e4)) - de1*(z5*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)) + sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - x5*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) + y5*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1))) - de5*(x5*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5)) + y5*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5))) + de4*(z5*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + x5*cos(e5)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) - y5*sin(e5)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4))) + de2*(cos(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2)) - x5*(sin(e2 + e3)*cos(e1)*sin(e5) - cos(e2 + e3)*cos(e1)*cos(e4)*cos(e5)) - y5*(sin(e2 + e3)*cos(e1)*cos(e5) + cos(e2 + e3)*cos(e1)*cos(e4)*sin(e5)) + z5*cos(e2 + e3)*cos(e1)*sin(e4));
  de2*(sin(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2)) - x5*(sin(e2 + e3)*sin(e1)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)*sin(e1)) - y5*(sin(e2 + e3)*cos(e5)*sin(e1) + cos(e2 + e3)*cos(e4)*sin(e1)*sin(e5)) + z5*cos(e2 + e3)*sin(e1)*sin(e4)) - de1*(z5*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) - cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - x5*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)) + y5*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5))) + de5*(x5*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1)) + y5*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5))) - de4*(z5*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + x5*cos(e5)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)) - y5*sin(e5)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) + de3*(sin(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3)) - x5*(sin(e2 + e3)*sin(e1)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)*sin(e1)) - y5*(sin(e2 + e3)*cos(e5)*sin(e1) + cos(e2 + e3)*cos(e4)*sin(e1)*sin(e5)) + z5*cos(e2 + e3)*sin(e1)*sin(e4));
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             de4*(z5*cos(e2 + e3)*cos(e4) - x5*cos(e2 + e3)*cos(e5)*sin(e4) + y5*cos(e2 + e3)*sin(e4)*sin(e5)) - de5*(x5*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5)) - y5*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5))) - de2*(d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2) + x5*(cos(e2 + e3)*sin(e5) + sin(e2 + e3)*cos(e4)*cos(e5)) + y5*(cos(e2 + e3)*cos(e5) - sin(e2 + e3)*cos(e4)*sin(e5)) + z5*sin(e2 + e3)*sin(e4)) - de3*(d4*cos(e2 + e3) + a3*sin(e2 + e3) + x5*(cos(e2 + e3)*sin(e5) + sin(e2 + e3)*cos(e4)*cos(e5)) + y5*(cos(e2 + e3)*cos(e5) - sin(e2 + e3)*cos(e4)*sin(e5)) + z5*sin(e2 + e3)*sin(e4))]
 
er5 = simplify(v05c - V_0_5) 
V_0_6 = ...
[ de3*(cos(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3)) - z6*(sin(e2 + e3)*cos(e1)*cos(e5) + cos(e2 + e3)*cos(e1)*cos(e4)*sin(e5)) - x6*(cos(e6)*(sin(e2 + e3)*cos(e1)*sin(e5) - cos(e2 + e3)*cos(e1)*cos(e4)*cos(e5)) + cos(e2 + e3)*cos(e1)*sin(e4)*sin(e6)) + y6*(sin(e6)*(sin(e2 + e3)*cos(e1)*sin(e5) - cos(e2 + e3)*cos(e1)*cos(e4)*cos(e5)) - cos(e2 + e3)*cos(e1)*cos(e6)*sin(e4))) - de1*(sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) + z6*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1)) - x6*(cos(e6)*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) + sin(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) + y6*(sin(e6)*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) - cos(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)))) - de5*(z6*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)) + x6*cos(e6)*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5)) - y6*sin(e6)*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5))) - de6*(x6*(sin(e6)*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)) - cos(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4))) + y6*(sin(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) + cos(e6)*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)))) - de4*(x6*(sin(e6)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e5)*cos(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4))) + y6*(cos(e6)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e5)*sin(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4))) + z6*sin(e5)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4))) + de2*(cos(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2)) - z6*(sin(e2 + e3)*cos(e1)*cos(e5) + cos(e2 + e3)*cos(e1)*cos(e4)*sin(e5)) - x6*(cos(e6)*(sin(e2 + e3)*cos(e1)*sin(e5) - cos(e2 + e3)*cos(e1)*cos(e4)*cos(e5)) + cos(e2 + e3)*cos(e1)*sin(e4)*sin(e6)) + y6*(sin(e6)*(sin(e2 + e3)*cos(e1)*sin(e5) - cos(e2 + e3)*cos(e1)*cos(e4)*cos(e5)) - cos(e2 + e3)*cos(e1)*cos(e6)*sin(e4)));
  de4*(x6*(sin(e6)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e5)*cos(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) + y6*(cos(e6)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e5)*sin(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) + z6*sin(e5)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) - de3*(x6*(cos(e6)*(sin(e2 + e3)*sin(e1)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)*sin(e1)) + cos(e2 + e3)*sin(e1)*sin(e4)*sin(e6)) - y6*(sin(e6)*(sin(e2 + e3)*sin(e1)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)*sin(e1)) - cos(e2 + e3)*cos(e6)*sin(e1)*sin(e4)) - sin(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3)) + z6*(sin(e2 + e3)*cos(e5)*sin(e1) + cos(e2 + e3)*cos(e4)*sin(e1)*sin(e5))) - de2*(x6*(cos(e6)*(sin(e2 + e3)*sin(e1)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)*sin(e1)) + cos(e2 + e3)*sin(e1)*sin(e4)*sin(e6)) - y6*(sin(e6)*(sin(e2 + e3)*sin(e1)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)*sin(e1)) - cos(e2 + e3)*cos(e6)*sin(e1)*sin(e4)) - sin(e1)*(a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2)) + z6*(sin(e2 + e3)*cos(e5)*sin(e1) + cos(e2 + e3)*cos(e4)*sin(e1)*sin(e5))) + de5*(z6*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) + x6*cos(e6)*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1)) - y6*sin(e6)*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1))) + de1*(cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - z6*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5)) + x6*(sin(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) + cos(e6)*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5))) - y6*(sin(e6)*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)) - cos(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)))) + de6*(x6*(sin(e6)*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) - cos(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) + y6*(cos(e6)*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) + sin(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))));
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  de6*(x6*(sin(e6)*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)) - cos(e2 + e3)*cos(e6)*sin(e4)) + y6*(cos(e6)*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)) + cos(e2 + e3)*sin(e4)*sin(e6))) - de3*(d4*cos(e2 + e3) + x6*(cos(e6)*(cos(e2 + e3)*sin(e5) + sin(e2 + e3)*cos(e4)*cos(e5)) - sin(e2 + e3)*sin(e4)*sin(e6)) - y6*(sin(e6)*(cos(e2 + e3)*sin(e5) + sin(e2 + e3)*cos(e4)*cos(e5)) + sin(e2 + e3)*cos(e6)*sin(e4)) + a3*sin(e2 + e3) + z6*(cos(e2 + e3)*cos(e5) - sin(e2 + e3)*cos(e4)*sin(e5))) - de2*(d4*cos(e2 + e3) + x6*(cos(e6)*(cos(e2 + e3)*sin(e5) + sin(e2 + e3)*cos(e4)*cos(e5)) - sin(e2 + e3)*sin(e4)*sin(e6)) - y6*(sin(e6)*(cos(e2 + e3)*sin(e5) + sin(e2 + e3)*cos(e4)*cos(e5)) + sin(e2 + e3)*cos(e6)*sin(e4)) + a3*sin(e2 + e3) + a2*sin(e2) + z6*(cos(e2 + e3)*cos(e5) - sin(e2 + e3)*cos(e4)*sin(e5))) - de4*(x6*(cos(e2 + e3)*cos(e4)*sin(e6) + cos(e2 + e3)*cos(e5)*cos(e6)*sin(e4)) + y6*(cos(e2 + e3)*cos(e4)*cos(e6) - cos(e2 + e3)*cos(e5)*sin(e4)*sin(e6)) - z6*cos(e2 + e3)*sin(e4)*sin(e5)) + de5*(z6*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)) - x6*cos(e6)*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5)) + y6*sin(e6)*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5)))]
 
er6 = simplify(v06c - V_0_6)



P1 = ...
[x1*cos(e1) - y1*sin(e1);
 y1*cos(e1) + x1*sin(e1);
                    d1 + z1]
ee1 = simplify(P1-P01c)
P2 = ...
[ a1*cos(e1) - z2*sin(e1) + y2*cos(e1)*cos(e2) + x2*cos(e1)*sin(e2);
  a1*sin(e1) + z2*cos(e1) + y2*cos(e2)*sin(e1) + x2*sin(e1)*sin(e2);
                                               d1 + x2*cos(e2) - y2*sin(e2)]
 ee2 = simplify(P2-P02c)
P3 = ...
[ cos(e1)*(a1 + a2*sin(e2)) - z3*sin(e1) + y3*cos(e2 + e3)*cos(e1) + x3*sin(e2 + e3)*cos(e1);
  sin(e1)*(a1 + a2*sin(e2)) + z3*cos(e1) + y3*cos(e2 + e3)*sin(e1) + x3*sin(e2 + e3)*sin(e1);
                                                 d1 + x3*cos(e2 + e3) - y3*sin(e2 + e3) + a2*cos(e2)]
 ee3 = simplify(P3-P03c)
P4 = ...
[ x4*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + y4*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) + cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) + z4*cos(e2 + e3)*cos(e1);
  sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - y4*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)) - x4*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + z4*cos(e2 + e3)*sin(e1);
                                                                                           d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) - z4*sin(e2 + e3) + a2*cos(e2) + x4*cos(e2 + e3)*cos(e4) - y4*cos(e2 + e3)*sin(e4)]
ee4 = simplify(P4-P04c) 
P5 = ...
[ cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - z5*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) + x5*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)) - y5*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5));
  z5*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)) + sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - x5*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) + y5*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1));
                                                                                                                                      d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2) - x5*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)) - y5*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5)) + z5*cos(e2 + e3)*sin(e4)]
 
 ee5 = simplify(P5-P05c)
P6 = ...
[ cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - z6*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5)) + x6*(sin(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)) + cos(e6)*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5))) - y6*(sin(e6)*(cos(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) + cos(e2 + e3)*cos(e1)*sin(e5)) - cos(e6)*(cos(e4)*sin(e1) - sin(e2 + e3)*cos(e1)*sin(e4)));
  sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) + z6*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1)) - x6*(cos(e6)*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) + sin(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4))) + y6*(sin(e6)*(cos(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) - cos(e2 + e3)*sin(e1)*sin(e5)) - cos(e6)*(cos(e1)*cos(e4) + sin(e2 + e3)*sin(e1)*sin(e4)));
                                                                                                                                                                                                                     d1 - x6*(cos(e6)*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)) + cos(e2 + e3)*sin(e4)*sin(e6)) + y6*(sin(e6)*(sin(e2 + e3)*sin(e5) - cos(e2 + e3)*cos(e4)*cos(e5)) - cos(e2 + e3)*cos(e6)*sin(e4)) + a3*cos(e2 + e3) - d4*sin(e2 + e3) + a2*cos(e2) - z6*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5))]
 ee6 = simplify(P6-P06c)