clc;
clear all;
close all;
syms the1 the2 the3 the4 the5 the6 the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot
% syms the1_2dot the2_2dot the3_2dot the4_2dot the5_2dot the6_2dot
syms a1 a2 a3 d1 d4 d7
% syms m1 m2 m3 I1 I2 I3 g 
assume(the1,'real');
assume(the2,'real');
assume(the3,'real');
assume(the4,'real');
assume(the5,'real');
assume(the6,'real');
assume(the1_dot,'real');
assume(the2_dot,'real');
assume(the3_dot,'real');
assume(the4_dot,'real');
assume(the5_dot,'real');
assume(the6_dot,'real');
% assume(the1_2dot,'real');
% assume(the2_2dot,'real');
% assume(the3_2dot,'real');
% assume(the4_2dot,'real');
% assume(the5_2dot,'real');
% assume(the6_2dot,'real');
assume(a1,'real');
assume(a2,'real');
assume(a3,'real');
assume(d1,'real');
assume(d4,'real');
assume(d7,'real');
%% INTIAL VALUE
w_0_0 = [0 0 0]';
v_0_0 = [0 0 0]';
%% FORWARD KINEMATICS
[T_0_1,R_0_1,R_1_0,P_0_1] = FKRobot2021(0,0,d1,the1);
[T_1_2,R_1_2,R_2_1,P_1_2] = FKRobot2021(a1,sym(-pi/2),0,the2-sym(pi/2));
[T_2_3,R_2_3,R_3_2,P_2_3] = FKRobot2021(a2,0,0,the3);
[T_3_4,R_3_4,R_4_3,P_3_4] = FKRobot2021(a3,sym(-pi/2),d4,the4);
[T_4_5,R_4_5,R_5_4,P_4_5] = FKRobot2021(0,sym(pi/2),0,the5);
[T_5_6,R_5_6,R_6_5,P_5_6] = FKRobot2021(0,sym(-pi/2),0,the6);
[T_6_7,R_6_7,R_7_6,P_6_7] = FKRobot2021(0,0,d7,0);
%% LINKAGE 1:
% Angular velocity in frame 1:
w_1_1 = R_1_0*w_0_0 + the1_dot*[0 0 1]';
% Linear velocity of the origin in frame 1:
v_1_1 = R_1_0*(v_0_0 + [0 -w_0_0(3) w_0_0(2);w_0_0(3) 0 -w_0_0(1);-w_0_0(2) w_0_0(1) 0]*P_0_1);
% Linear velocity in frame 0:
v_0_1 = R_0_1*v_1_1;

%% LINKAGE 2:
% Angular velocity in frame 1:
w_2_2 = R_2_1*w_1_1 + the2_dot*[0 0 1]';
% Linear velocity of the origin in frame 1:
v_2_2 = R_2_1*(v_1_1 + [0 -w_1_1(3) w_1_1(2);w_1_1(3) 0 -w_1_1(1);-w_1_1(2) w_1_1(1) 0]*P_1_2);
% Linear velocity in frame 0:
v_0_2 = R_0_1*R_1_2*v_2_2;

%% LINKAGE 3:
% Angular velocity in frame 1:
w_3_3 = R_3_2*w_2_2 + the3_dot*[0 0 1]';
% Linear velocity of the origin in frame 1:
v_3_3 = R_3_2*(v_2_2 + [0 -w_2_2(3) w_2_2(2);w_2_2(3) 0 -w_2_2(1);-w_2_2(2) w_2_2(1) 0]*P_2_3);
% Linear velocity in frame 0:
v_0_3 = R_0_1*R_1_2*R_2_3*v_3_3;

%% LINKAGE 4:
% Angular velocity in frame 1:
w_4_4 = R_4_3*w_3_3 + the4_dot*[0 0 1]';
% Linear velocity of the origin in frame 1:
v_4_4 = R_4_3*(v_3_3 + [0 -w_3_3(3) w_3_3(2);w_3_3(3) 0 -w_3_3(1);-w_3_3(2) w_3_3(1) 0]*P_3_4);
% Linear velocity in frame 0:
v_0_4 = R_0_1*R_1_2*R_2_3*R_3_4*v_4_4;

%% LINKAGE 5:
% Angular velocity in frame 1:
w_5_5 = R_5_4*w_4_4 + the5_dot*[0 0 1]';
% Linear velocity of the origin in frame 1:
v_5_5 = R_5_4*(v_4_4 + [0 -w_4_4(3) w_4_4(2);w_4_4(3) 0 -w_4_4(1);-w_4_4(2) w_4_4(1) 0]*P_4_5);
% Linear velocity in frame 0:
v_0_5 = R_0_1*R_1_2*R_2_3*R_3_4*R_4_5*v_5_5;

%% LINKAGE 6:
% Angular velocity in frame 1:
w_6_6 = R_6_5*w_5_5 + the6_dot*[0 0 1]';
% Linear velocity of the origin in frame 1:
v_6_6 = R_6_5*(v_5_5 + [0 -w_5_5(3) w_5_5(2);w_5_5(3) 0 -w_5_5(1);-w_5_5(2) w_5_5(1) 0]*P_5_6);
% Linear velocity in frame 0:
v_0_6 = simplify(R_0_1*R_1_2*R_2_3*R_3_4*R_4_5*R_5_6*v_6_6)

