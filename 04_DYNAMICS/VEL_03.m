%% Authors:
% Made by Tran Minh Phuc
% Date: 2021/03/29:
% NOTE: Có xét đến vị trí trọng tâm (lấy theo trục mình đặt từng khâu), moment quán tính, khối lượng từng khâu
% công thức tổng quát
clc;
clear all;
close all;
syms e1 e2 e3 e4 e5 e6 real
syms de1 de2 de3 de4 de5 de6 real
syms dde1 dde2 dde3 dde4 dde5 dde6 real
syms a1 a2 a3 d1 d4 d7 real
syms m1 m2 m3 m4 m5 m6 real
syms I1 I2 I3 I4 I5 I6 real
syms g real
syms x1 x2 x3 x4 x5 x6 x7 real
syms y1 y2 y3 y4 y5 y6 y7 real
syms z1 z2 z3 z4 z5 z6 z7 real
syms I1xx I1xy I1xz I1yx I1yy I1yz I1zx I1zy I1zz real
syms I2xx I2xy I2xz I2yx I2yy I2yz I2zx I2zy I2zz real
syms I3xx I3xy I3xz I3yx I3yy I3yz I3zx I3zy I3zz real
syms I4xx I4xy I4xz I4yx I4yy I4yz I4zx I4zy I4zz real
syms I5xx I5xy I5xz I5yx I5yy I5yz I5zx I5zy I5zz real
syms I6xx I6xy I6xz I6yx I6yy I6yz I6zx I6zy I6zz real 
% assume(e1,'real');
% assume(e2,'real');
% assume(e3,'real');
% assume(e4,'real');
% assume(e5,'real');
% assume(e6,'real');
% assume(de1,'real');
% assume(de2,'real');
% assume(de3,'real');
% assume(de4,'real');
% assume(de5,'real');
% assume(de6,'real');
% assume(dde1,'real');
% assume(dde2,'real');
% assume(dde3,'real');
% assume(dde4,'real');
% assume(dde5,'real');
% assume(dde6,'real');
% assume(a1,'real');
% assume(a2,'real');
% assume(a3,'real');
% assume(d1,'real');
% assume(d4,'real');
% assume(d7,'real');
% assume(m1,'real');
% assume(m2,'real');
% assume(m3,'real');
% assume(m4,'real');
% assume(m5,'real');
% assume(m6,'real');
% assume(I1,'real');
% assume(I2,'real');
% assume(I3,'real');
% assume(I4,'real');
% assume(I5,'real');
% assume(I6,'real');
% assume(g,'real');
% assume(x1,'real');
% assume(x2,'real');
% assume(x3,'real');
% assume(x4,'real');
% assume(x5,'real');
% assume(x6,'real');
% assume(y1,'real');
% assume(y2,'real');
% assume(y3,'real');
% assume(y4,'real');
% assume(y5,'real');
% assume(y6,'real');
% assume(z1,'real');
% assume(z2,'real');
% assume(z3,'real');
% assume(z4,'real');
% assume(z5,'real');
% assume(z6,'real');
% 
% assume(I1xx,'real');
% assume(I1xy,'real');
% assume(I1xz,'real');
% assume(I1yx,'real');
% assume(I1yy,'real');
% assume(I1yz,'real');
% assume(I1zx,'real');
% assume(I1zy,'real');
% assume(I1zz,'real');
% 
% assume(I2xx,'real');
% assume(I2xy,'real');
% assume(I2xz,'real');
% assume(I2yx,'real');
% assume(I2yy,'real');
% assume(I2yz,'real');
% assume(I2zx,'real');
% assume(I2zy,'real');
% assume(I2zz,'real');
% 
% assume(I3xx,'real');
% assume(I3xy,'real');
% assume(I3xz,'real');
% assume(I3yx,'real');
% assume(I3yy,'real');
% assume(I3yz,'real');
% assume(I3zx,'real');
% assume(I3zy,'real');
% assume(I3zz,'real');
% 
% assume(I4xx,'real');
% assume(I4xy,'real');
% assume(I4xz,'real');
% assume(I4yx,'real');
% assume(I4yy,'real');
% assume(I4yz,'real');
% assume(I4zx,'real');
% assume(I4zy,'real');
% assume(I4zz,'real');
% 
% assume(I5xx,'real');
% assume(I5xy,'real');
% assume(I5xz,'real');
% assume(I5yx,'real');
% assume(I5yy,'real');
% assume(I5yz,'real');
% assume(I5zx,'real');
% assume(I5zy,'real');
% assume(I5zz,'real');
% 
% assume(I6xx,'real');
% assume(I6xy,'real');
% assume(I6xz,'real');
% assume(I6yx,'real');
% assume(I6yy,'real');
% assume(I6yz,'real');
% assume(I6zx,'real');
% assume(I6zy,'real');
% assume(I6zz,'real');
%% INTIAL VALUE
w0 = [0 0 0]';
v0 = [0 0 0]';
% POSITION OF CENTER OF MASS IN EACH LINKAGE:
P1c = [x1 y1 z1]';
P2c = [x2 y2 z2]';
P3c = [x3 y3 z3]';
P4c = [x4 y4 z4]';
P5c = [x5 y5 z5]';
P6c = [x6 y6 z6]';
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
w1 = simplify(R10*w0 + de1*[0 0 1]')
% Linear velocity of the origin in frame 1:
v1 = simplify(R10*(v0 + cross(w0,P01)))
% Linear velocity in frame 0:
v01 = R01*v1;
% Linear velocity of the center of mass in frame 0:
v01c = simplify(R01*(v1 + cross(w1,P1c)))
%% LINKAGE 2:
% Center of mass position of the first link in frame 0.
TP02c = (T01*T12*[P2c; 1]);
P02c = TP02c(1:3);
% Angular velocity in frame 1:
w2 = simplify(R21*w1 + de2*[0 0 1]')
% Linear velocity of the origin in frame 1:
v2 = simplify(R21*(v1 + cross(w1,P12)))
% Linear velocity in frame 0:
v02 = R01*R12*v2;
% Linear velocity of the center of mass in frame 0:
v02c = simplify(R01*R12*(v2 + cross(w2,P2c)))
%% LINKAGE 3:
% Center of mass position of the first link in frame 0.
TP03c = (T01*T12*T23*[P3c; 1]);
P03c = TP03c(1:3);
% Angular velocity in frame 1:
w3 = simplify(R32*w2 + de3*[0 0 1]')
% Linear velocity of the origin in frame 1:
v3 = simplify(R32*(v2 + cross(w2,P23)))
% Linear velocity in frame 0:
v03 = R01*R12*R23*v3;
% Linear velocity of the center of mass in frame 0:
v03c = simplify(R01*R12*R23*(v3 + cross(w3,P3c)))
%% LINKAGE 4:
% Center of mass position of the first link in frame 0.
TP04c = (T01*T12*T23*T34*[P4c; 1]);
P04c = TP04c(1:3);
% Angular velocity in frame 1:
w4 = simplify(R43*w3 + de4*[0 0 1]')
% Linear velocity of the origin in frame 1:
v4 = simplify(R43*(v3 + cross(w3,P34)))
% Linear velocity in frame 0:
v04 = R01*R12*R23*R34*v4;
% Linear velocity of the center of mass in frame 0:
v04c = simplify(R01*R12*R23*R34*(v4 + cross(w4,P4c)))
%% LINKAGE 5:
% Center of mass position of the first link in frame 0.
TP05c = (T01*T12*T23*T34*T45*[P5c; 1]);
P05c = TP05c(1:3);
% Angular velocity in frame 1:
w5 = simplify(R54*w4 + de5*[0 0 1]')
% Linear velocity of the origin in frame 1:
v5 = simplify(R54*(v4 + cross(w4,P45)))
% Linear velocity in frame 0:
v05 = R01*R12*R23*R34*R45*v5;
% Linear velocity of the center of mass in frame 0:
v05c = simplify(R01*R12*R23*R34*R45*(v5 + cross(w5,P5c)))
%% LINKAGE 6:
% Center of mass position of the first link in frame 0.
TP06c = (T01*T12*T23*T34*T45*T56*[P6c; 1]);
P06c = TP06c(1:3);
% Angular velocity in frame 1:
w6 = simplify(R65*w5 + de6*[0 0 1]')
% Linear velocity of the origin in frame 1:
v6 = simplify(R65*(v5 + cross(w5,P56)))
% Linear velocity in frame 0:
v06 = R01*R12*R23*R34*R45*R56*v6;
% Linear velocity of the center of mass in frame 0:
v06c = simplify(R01*R12*R23*R34*R45*R56*(v6 + cross(w6,P6c)))