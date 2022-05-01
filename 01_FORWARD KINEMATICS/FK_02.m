%% Authors:
% Made by Tran Minh Phuc
% Date: 2022/05/01:
% Find Forward Kinematics, Velocity, Jacobian
% NOTE: 2 cach tinh van toc, 3 cach tinh Jacobian (test OK)
clc;
clear all;
close all;
syms e1 e2 e3 e4 e5 e6 
syms de1 de2 de3 de4 de5 de6  
syms a1 a2 a3 d1 d4 d7  
%% Forward kinematics:
[T01,R01,R10,P01] = FKRobot2021(0,0,d1,e1);
[T12,R12,R21,P12] = FKRobot2021(a1,sym(-pi/2),0,e2-sym(pi/2));
[T23,R23,R32,P23] = FKRobot2021(a2,0,0,e3);
[T34,R34,R43,P34] = FKRobot2021(a3,sym(-pi/2),d4,e4);
[T45,R45,R54,P45] = FKRobot2021(0,sym(pi/2),0,e5);
[T56,R56,R65,P56] = FKRobot2021(0,sym(-pi/2),0,e6);
[T67,R67,R76,P67] = FKRobot2021(0,0,d7,0);
T02 = simplify(T01*T12);
T03 = simplify(T02*T23);
T04 = simplify(T03*T34);
T05 = simplify(T04*T45);
T06 = simplify(T05*T56);
T07 = simplify(T06*T67);
R02 = T02(1:3,1:3);
R03 = T03(1:3,1:3);
R04 = T04(1:3,1:3);
R05 = T05(1:3,1:3);
R06 = T06(1:3,1:3);
R07 = T07(1:3,1:3);
P02 = T02(1:3,4);
P03 = T03(1:3,4);
P04 = T04(1:3,4);
P05 = T05(1:3,4);
P06 = T06(1:3,4);
P07 = T07(1:3,4);
P = [P01 P02 P03 P04 P05 P06 P07];
%% Velocity old version
w0 = [0 0 0].';
v0 = [0 0 0].';
w1 = simplify(R10*w0 + de1*[0;0;1]);
w01 = simplify(R01*w1);
v1 = simplify(R10*(v0 + cross(w0,P01)));
v01 = simplify(R01*v1);

w2 = simplify(R21*w1 + de2*[0;0;1]);
w02 = simplify(R02*w2);
v2 = simplify(R21*(v1 + cross(w1,P12)));
v02 = simplify(R02*v2);

w3 = simplify(R32*w2 + de3*[0;0;1]);
w03 = simplify(R03*w3);
v3 = simplify(R32*(v2 + cross(w2,P23)));
v03 = simplify(R03*v3);

w4 = simplify(R43*w3 + de4*[0;0;1]);
w04 = simplify(R04*w4);
v4 = simplify(R43*(v3 + cross(w3,P34)));
v04 = simplify(R04*v4);

w5 = simplify(R54*w4 + de5*[0;0;1]);
w05 = simplify(R05*w5);
v5 = simplify(R54*(v4 + cross(w4,P45)));
v05 = simplify(R05*v5);

w6 = simplify(R65*w5 + de6*[0;0;1]);
w06 = simplify(R06*w6);
v6 = simplify(R65*(v5 + cross(w5,P56)));
v06 = simplify(R06*v6);

w7 = simplify(R76*w6); %w7 = w6
w07 = simplify(R07*w7);
v7 = simplify(R76*(v6 + cross(w6,P67)));
v07 = simplify(R07*v7);
%% Velocity new version
% dR01 = simplify(diff(R01,e1)*de1);
% S1 = simplify(R01.'*dR01);
% w1 = [S1(3,2); S1(1,3); S1(2,1)];
% w01 = simplify(R01*w1);
% v01 = simplify(diff(P01,e1)*de1)
% 
% dR02 = simplify(diff(R02,e1)*de1 + diff(R02,e2)*de2);
% S2 = simplify(R02.'*dR02);
% w2 = [S2(3,2); S2(1,3); S2(2,1)];
% w02 = simplify(R02*w2);
% v02 = simplify(diff(P02,e1)*de1 + diff(P02,e2)*de2)
% 
% dR03 = simplify(diff(R03,e1)*de1 + diff(R03,e2)*de2 + diff(R03,e3)*de3);
% S3 = simplify(R03.'*dR03);
% w3 = [S3(3,2); S3(1,3); S3(2,1)];
% w03 = simplify(R03*w3);
% v03 = simplify(diff(P03,e1)*de1 + diff(P03,e2)*de2 + diff(P03,e3)*de3)
% 
% dR04 = simplify(diff(R04,e1)*de1 + diff(R04,e2)*de2 + diff(R04,e3)*de3 + diff(R04,e4)*de4);
% S4 = simplify(R04.'*dR04);
% w4 = [S4(3,2); S4(1,3); S4(2,1)];
% w04 = simplify(R04*w4);
% v04 = simplify(diff(P04,e1)*de1 + diff(P04,e2)*de2 + diff(P04,e3)*de3 + diff(P04,e4)*de4)
% 
% dR05 = simplify(diff(R05,e1)*de1 + diff(R05,e2)*de2 + diff(R05,e3)*de3 + diff(R05,e4)*de4 + diff(R05,e5)*de5);
% S5 = simplify(R05.'*dR05);
% w5 = [S5(3,2); S5(1,3); S5(2,1)];
% w05 = simplify(R05*w5);
% v05 = simplify(diff(P05,e1)*de1 + diff(P05,e2)*de2 + diff(P05,e3)*de3 + diff(P05,e4)*de4 + diff(P05,e5)*de5)
% 
% dR06 = simplify(diff(R06,e1)*de1 + diff(R06,e2)*de2 + diff(R06,e3)*de3 + diff(R06,e4)*de4 + diff(R06,e5)*de5 + diff(R06,e6)*de6);
% S6 = simplify(R06.'*dR06);
% w6 = [S6(3,2); S6(1,3); S6(2,1)];
% w06 = simplify(R06*w6);
% v06 = simplify(diff(P06,e1)*de1 + diff(P06,e2)*de2 + diff(P06,e3)*de3 + diff(P06,e4)*de4 + diff(P06,e5)*de5 + diff(P06,e6)*de6)
% 
% dR07 = simplify(diff(R07,e1)*de1 + diff(R07,e2)*de2 + diff(R07,e3)*de3 + diff(R07,e4)*de4 + diff(R07,e5)*de5 + diff(R07,e6)*de6);
% S7 = simplify(R07.'*dR07);
% w7 = [S7(3,2); S7(1,3); S7(2,1)];
% w07 = simplify(R07*w7);
% v07 = simplify(diff(P07,e1)*de1 + diff(P07,e2)*de2 + diff(P07,e3)*de3 + diff(P07,e4)*de4 + diff(P07,e5)*de5 + diff(P07,e6)*de6)
%% Jacobian 1
Jacobian1 = simplify([diff(P07,e1)  diff(P07,e2)  diff(P07,e3)  diff(P07,e4)  diff(P07,e5)  diff(P07,e6);
                      diff(w01,de1) diff(w02,de2) diff(w03,de3) diff(w04,de4) diff(w05,de5) diff(w06,de6)]); 
%% Jacobian 2
Jacobian2 = simplify([diff(v07,de1) diff(v07,de2) diff(v07,de3) diff(v07,de4) diff(v07,de5) diff(v07,de6);
                      diff(w07,de1) diff(w07,de2) diff(w07,de3) diff(w07,de4) diff(w07,de5) diff(w07,de6)]);
%% Jacobian 3
J1 = simplify([cross(T01(1:3,3), T07(1:3,4) - T01(1:3,4));
               T01(1:3,3)]);
J2 = simplify([cross(T02(1:3,3), T07(1:3,4) - T02(1:3,4));
              T02(1:3,3)]);
J3 = simplify([cross(T03(1:3,3), T07(1:3,4) - T03(1:3,4));
              T03(1:3,3)]);
J4 = simplify([cross(T04(1:3,3), T07(1:3,4) - T04(1:3,4));
              T04(1:3,3)]);
J5 = simplify([cross(T05(1:3,3), T07(1:3,4) - T05(1:3,4));
              T05(1:3,3)]);
J6 = simplify([cross(T06(1:3,3), T07(1:3,4) - T06(1:3,4));
              T06(1:3,3)]);
Jacobian3 = [J1 J2 J3 J4 J5 J6];
%% check
err1 = simplify(expand(Jacobian1 - Jacobian2))
err2 = simplify(expand(Jacobian2 - Jacobian3))
err3 = simplify(expand(Jacobian3 - Jacobian1))