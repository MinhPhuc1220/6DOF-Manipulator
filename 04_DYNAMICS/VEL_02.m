%% Authors:
% Made by Tran Minh Phuc
% Date: 2021/03/29:
% NOTE: Có xét đến vị trí trọng tâm (lấy theo trục mình đặt từng khâu), moment quán tính, khối lượng từng khâu
clc;
clear all;
close all;
syms e1 e2 e3 e4 e5 e6 
syms de1 de2 de3 de4 de5 de6
syms dde1 dde2 dde3 dde4 dde5 dde6
% syms a1 a2 a3 d1 d4 d7
% syms m1 m2 m3 m4 m5 m6 
% syms I1 I2 I3 I4 I5 I6 
% syms g 
% syms x1 x2 x3 x4 x5 x6 x7
% syms y1 y2 y3 y4 y5 y6 y7
% syms z1 z2 z3 z4 z5 z6 z7
assume(e1,'real');
assume(e2,'real');
assume(e3,'real');
assume(e4,'real');
assume(e5,'real');
assume(e6,'real');
assume(de1,'real');
assume(de2,'real');
assume(de3,'real');
assume(de4,'real');
assume(de5,'real');
assume(de6,'real');
assume(dde1,'real');
assume(dde2,'real');
assume(dde3,'real');
assume(dde4,'real');
assume(dde5,'real');
assume(dde6,'real');
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
%% INTIAL VALUE
a1=0.75; a2=2.70; a3=0.90; d1=3.35; d4=2.95; d7=0.80;
m0 = 7.2407; m1 = 5.6511; m2 = 4.6061; m3 = 4.2963; m4 = 1.9151; m5 = 0.3399; m6 = 0.0714;
g = 9.80665;
w0 = [0 0 0]';
v0 = [0 0 0]';
%% POSITION OF CENTER OF MASS IN EACH LINKAGE:
P0c = [-0.0156,   0.0003,      0.1]';
P1c = [ 0.0373,  -0.0076,   0.1064]';
% P2c = [ 0.0062,   0.0613,   0.1146]';
P2c = [ 0.1127,   0.0065,   0.0648]';
% P3c = [-0.0055,   0.0561,   0.0452]';
P3c = [ 0.0447,   0.0125,  -0.0554]';
% P4c = [-0.1068,  -0.0052,  -0.0006]';
P4c = [ 0.0006,   0.0052,   0.1068]';
% P5c = [ 0.0062,   0.0195,        0]';
P5c = [      0,   0.0062,   0.0195]';
% P6c = [ 0.0113,        0,        0]';
P6c = [ -0.00001,  0.00001,  0.01126]';
%% MOMENTS OF INERTIA
I0 = [ 0.0413,  -0.0004,   0.0032;
      -0.0004,    0.055,        0;
       0.0032,        0,    0.049];
I1 = [ 0.0320,  -0.0017,   0.0093;
      -0.0017,   0.0364,  -0.0018;
       0.0093,  -0.0018,   0.0334];
% I2 = [0.0646,   0.0002,   0.0007;
%       0.0002   ,0.0683,   -0.002;
%       0.0007,   -0.002,   0.0099];
I2 = [ 0.0099,   0.0008,  -0.0002;
       0.0008,   0.0646,   0.0002;
      -0.0002,   0.0002,   0.0684];
% I3 = [0.0197,   0.0001,  -0.0006;
%       0.0001,    0.024,  -0.0006;
%      -0.0006,  -0.0006,   0.0173];
I3 = [ 0.0176,    0.001,   0.0007;
        0.001,   0.0195,   0.0002;
       0.0007,   0.0002,    0.024];
% I4 = [0.0037,   0.0002,        0;
%       0.0002,   0.0081,        0;
%            0,        0,    0.009];
I4 = [  0.009,        0,        0;
            0,   0.0081,   0.0002;
            0,   0.0002,   0.0037]; 
% I5 = [0.0002,        0,        0;
%            0,   0.0003,        0;
%            0,        0,   0.0003];
I5 = [ 0.0003,        0,        0;
            0,   0.0002,        0;
            0,        0,   0.0003];       
I6 = [ 0.00002,        0,        0;
             0,  0.00002,        0;
             0,        0,  0.00003];
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
w1 = R10*w0 + de1*[0 0 1]';
% Linear velocity of the origin in frame 1:
v1 = R10*(v0 + [0 -w0(3) w0(2);w0(3) 0 -w0(1);-w0(2) w0(1) 0]*P01);
% Linear velocity in frame 0:
v01 = R01*v1;
% Linear velocity of the center of mass in frame 0:
v01c = R01*(v1 + [0 -w1(3) w1(2);w1(3) 0 -w1(1);-w1(2) w1(1) 0]*P1c);
%% LINKAGE 2:
% Center of mass position of the first link in frame 0.
TP02c = (T01*T12*[P2c; 1]);
P02c = TP02c(1:3);
% Angular velocity in frame 1:
w2 = R21*w1 + de2*[0 0 1]';
% Linear velocity of the origin in frame 1:
v2 = R21*(v1 + [0 -w1(3) w1(2);w1(3) 0 -w1(1);-w1(2) w1(1) 0]*P12);
% Linear velocity in frame 0:
v02 = R01*R12*v2;
% Linear velocity of the center of mass in frame 0:
v02c = R01*R12*(v2 + [0 -w2(3) w2(2);w2(3) 0 -w2(1);-w2(2) w2(1) 0]*P2c);
%% LINKAGE 3:
% Center of mass position of the first link in frame 0.
TP03c = (T01*T12*T23*[P3c; 1]);
P03c = TP03c(1:3);
% Angular velocity in frame 1:
w3 = R32*w2 + de3*[0 0 1]';
% Linear velocity of the origin in frame 1:
v3 = R32*(v2 + [0 -w2(3) w2(2);w2(3) 0 -w2(1);-w2(2) w2(1) 0]*P23);
% Linear velocity in frame 0:
v03 = R01*R12*R23*v3;
% Linear velocity of the center of mass in frame 0:
v03c = R01*R12*R23*(v3 + [0 -w3(3) w3(2);w3(3) 0 -w3(1);-w3(2) w3(1) 0]*P3c);
%% LINKAGE 4:
% Center of mass position of the first link in frame 0.
TP04c = (T01*T12*T23*T34*[P4c; 1]);
P04c = TP04c(1:3);
% Angular velocity in frame 1:
w4 = R43*w3 + de4*[0 0 1]';
% Linear velocity of the origin in frame 1:
v4 = R43*(v3 + [0 -w3(3) w3(2);w3(3) 0 -w3(1);-w3(2) w3(1) 0]*P34);
% Linear velocity in frame 0:
v04 = R01*R12*R23*R34*v4;
% Linear velocity of the center of mass in frame 0:
v04c = R01*R12*R23*R34*(v4 + [0 -w4(3) w4(2);w4(3) 0 -w4(1);-w4(2) w4(1) 0]*P4c);
%% LINKAGE 5:
% Center of mass position of the first link in frame 0.
TP05c = (T01*T12*T23*T34*T45*[P5c; 1]);
P05c = TP05c(1:3);
% Angular velocity in frame 1:
w5 = R54*w4 + de5*[0 0 1]';
% Linear velocity of the origin in frame 1:
v5 = R54*(v4 + [0 -w4(3) w4(2);w4(3) 0 -w4(1);-w4(2) w4(1) 0]*P45);
% Linear velocity in frame 0:
v05 = R01*R12*R23*R34*R45*v5;
% Linear velocity of the center of mass in frame 0:
v05c = R01*R12*R23*R34*R45*(v5 + [0 -w5(3) w5(2);w5(3) 0 -w5(1);-w5(2) w5(1) 0]*P5c);
%% LINKAGE 6:
% Center of mass position of the first link in frame 0.
TP06c = (T01*T12*T23*T34*T45*T56*[P6c; 1]);
P06c = TP06c(1:3);
% Angular velocity in frame 1:
w6 = R65*w5 + de6*[0 0 1]';
% Linear velocity of the origin in frame 1:
v6 = R65*(v5 + [0 -w5(3) w5(2);w5(3) 0 -w5(1);-w5(2) w5(1) 0]*P56);
% Linear velocity in frame 0:
v06 = simplify(R01*R12*R23*R34*R45*R56*v6);
% Linear velocity of the center of mass in frame 0:
v06c = R01*R12*R23*R34*R45*R56*(v6 + [0 -w6(3) w6(2);w6(3) 0 -w6(1);-w6(2) w6(1) 0]*P6c);