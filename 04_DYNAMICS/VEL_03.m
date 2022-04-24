%% Authors:
% Made by Tran Minh Phuc
% Date: 2021/03/29:
% NOTE: Có xét đến vị trí trọng tâm (lấy theo trục mình đặt từng khâu), moment quán tính, khối lượng từng khâu
% công thức tổng quát
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