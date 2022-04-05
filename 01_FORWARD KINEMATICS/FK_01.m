%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2021/09/23
% Topic: Forward Kinematics and Find Jacobian Matrix
% NOTE: DONE
%%
clc; clear all;
syms a alpha d the
syms a1 a2 a3 d1 d4 d7 the1 the2 the3 the4 the5 the6
syms the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot
%% FIND T_0_1
T_0_1 = FK_6DOF(0,0,d1,the1);
%% FIND T_1_2
T_1_2 = FK_6DOF(a1,sym(-pi/2),0,the2-sym(pi/2));
%% FIND T_2_3
T_2_3 = FK_6DOF(a2,0,0,the3);
%% FIND T_3_4
T_3_4 = FK_6DOF(a3,sym(-pi/2),d4,the4);
%% FIND T_4_5
T_4_5 = FK_6DOF(0,sym(pi/2),0,the5);
%% FIND T_5_6
T_5_6 = FK_6DOF(0,sym(-pi/2),0,the6);
%% FIND T_6_7 = T_6_EE
T_6_EE = FK_6DOF(0,0,d7,0);
%% FORWARD KINEMATICS T_0_7 = T_0_EE
T_0_EE = simplify(T_0_1 * T_1_2 * T_2_3 * T_3_4 * T_4_5 * T_5_6 * T_6_EE);
T_3_EE = simplify(T_3_4 * T_4_5 * T_5_6 * T_6_EE);
T_5_EE = simplify(T_5_6 * T_6_EE);
T_0_2 = simplify(T_0_1 * T_1_2);
T_0_3 = simplify(T_0_1 * T_1_2 * T_2_3);
T_0_4 = simplify(T_0_1 * T_1_2 * T_2_3 * T_3_4);
T_0_5 = simplify(T_0_1 * T_1_2 * T_2_3 * T_3_4 * T_4_5);
T_0_6 = simplify(T_0_1 * T_1_2 * T_2_3 * T_3_4 * T_4_5 * T_5_6);
%% FIND Px Py Pz
Px=T_0_EE(1,4);
Py=T_0_EE(2,4);
Pz=T_0_EE(3,4);
pitch = atan2(T_0_EE(3,1),sqrt(T_0_EE(1,1)^2+T_0_EE(2,1)^2))
yaw = atan2(T_0_EE(2,1)/cos(pitch),T_0_EE(1,1)/cos(pitch))
roll = atan2(T_0_EE(3,2)/cos(pitch),T_0_EE(3,3)/cos(pitch))
disp('-----------------------------');
fprintf("End-Effect XAxis: \nPx = %s\n\n",Px);
fprintf("End-Effect YAxis: \nPy = %s\n\n",Py);
fprintf("End-Effect ZAxis: \nPz = %s\n\n",Pz);
%% SUPPORT FOR INVERSE KINEMATICS
syms r11 r21 r31 r12 r22 r32 r13 r23 r33 px py pz
FK_test = [r11 r12 r13 px;
           r21 r22 r23 py;
           r31 r32 r33 pz;
           0   0  0  1];
T_1_0 = inv(T_0_1);
T_2_1 = inv(T_1_2);
T_6_5 = inv(T_5_6);
T_EE_6 = inv(T_6_EE);
A = simplify(T_2_1*T_1_0*FK_test*T_EE_6*T_6_5)
B = simplify(T_2_3 * T_3_4 * T_4_5)
%% FIND JACOBIAN MATRICES 6DOF
the = [the1 the2 the3 the4 the5 the6];
thed = [the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot];
% Angular Velocities:                
w00 = [0;0;0];
w11 = simplify(transpose(T_0_1(1:3,1:3))*w00 + [0;0;the1_dot]);
w22 = simplify(transpose(T_1_2(1:3,1:3))*w11 + [0;0;the2_dot]);
w33 = simplify(transpose(T_2_3(1:3,1:3))*w22 + [0;0;the3_dot]);
w44 = simplify(transpose(T_3_4(1:3,1:3))*w33 + [0;0;the4_dot]);
w55 = simplify(transpose(T_4_5(1:3,1:3))*w44 + [0;0;the5_dot]);
w66 = simplify(transpose(T_5_6(1:3,1:3))*w55 + [0;0;the6_dot]);
wee = simplify(transpose(T_6_EE(1:3,1:3))*w66);  % wee = w66
% Linear Velocities  
v00 = [0;0;0];
v11 = simplify(transpose(T_0_1(1:3,1:3))*(v00 + cross(w00,T_0_1(1:3,4))));
v22 = simplify(transpose(T_1_2(1:3,1:3))*(v11 + cross(w11,T_1_2(1:3,4))));
v33 = simplify(transpose(T_2_3(1:3,1:3))*(v22 + cross(w22,T_2_3(1:3,4))));
v44 = simplify(transpose(T_3_4(1:3,1:3))*(v33 + cross(w33,T_3_4(1:3,4))));
v55 = simplify(transpose(T_4_5(1:3,1:3))*(v44 + cross(w44,T_4_5(1:3,4))));
v66 = simplify(transpose(T_5_6(1:3,1:3))*(v55 + cross(w55,T_5_6(1:3,4))));
vee = simplify(transpose(T_6_EE(1:3,1:3))*(v66 + cross(w66,T_6_EE(1:3,4))));
v0ee = simplify(T_0_EE(1:3,1:3)*vee);
v3ee = simplify(T_3_EE(1:3,1:3)*vee);
% v3ee_ = simplify(inv(T_0_3(1:3,1:3))*v0ee);
% err_v = simplify(expand(v3ee - v3ee_));
v5ee = simplify(T_5_EE(1:3,1:3)*vee);
% Angular Velocities from the origin coordinate system
w01 = simplify(T_0_1(1:3,1:3)*w11);
w02 = simplify(T_0_2(1:3,1:3)*w22);
w03 = simplify(T_0_3(1:3,1:3)*w33);
w04 = simplify(T_0_4(1:3,1:3)*w44);
w05 = simplify(T_0_5(1:3,1:3)*w55);
w06 = simplify(T_0_6(1:3,1:3)*w66);
w0ee = simplify(T_0_EE(1:3,1:3)*wee);   % w0ee = w06

% gradient: dao ham rieng theo vecto (nhiều biến)
% diff: dao ham rieng theo 1 bien 
Jacobi_01 = simplify([diff(Px,the1) diff(Px,the2) diff(Px,the3) diff(Px,the4) diff(Px,the5) diff(Px,the6);
                      diff(Py,the1) diff(Py,the2) diff(Py,the3) diff(Py,the4) diff(Py,the5) diff(Py,the6);
                      diff(Pz,the1) diff(Pz,the2) diff(Pz,the3) diff(Pz,the4) diff(Pz,the5) diff(Pz,the6);
                      diff(w01(1),the1_dot) diff(w02(1),the2_dot) diff(w03(1),the3_dot) diff(w04(1),the4_dot) diff(w05(1),the5_dot) diff(w06(1),the6_dot);
                      diff(w01(2),the1_dot) diff(w02(2),the2_dot) diff(w03(2),the3_dot) diff(w04(2),the4_dot) diff(w05(2),the5_dot) diff(w06(2),the6_dot);
                      diff(w01(3),the1_dot) diff(w02(3),the2_dot) diff(w03(3),the3_dot) diff(w04(3),the4_dot) diff(w05(3),the5_dot) diff(w06(3),the6_dot)]);
                      %diff_jac(w01,the1_dot), diff_jac(w02,the2_dot), diff_jac(w03,the3_dot), diff_jac(w04,the4_dot), diff_jac(w05,the5_dot), diff_jac(w06,the6_dot)
Jacobi_02 = simplify([transpose(gradient(v0ee(1),thed));
                      transpose(gradient(v0ee(2),thed));
                      transpose(gradient(v0ee(3),thed));
                      transpose(gradient(w0ee(1),thed));
                      transpose(gradient(w0ee(2),thed));
                      transpose(gradient(w0ee(3),thed))]);
% NEW JACOBIAN
J1 = [cross(T_0_1(1:3,3), T_0_EE(1:3,4) - T_0_1(1:3,4));
      T_0_1(1:3,3)];
J2 = simplify([cross(T_0_2(1:3,3), T_0_EE(1:3,4) - T_0_2(1:3,4));
              T_0_2(1:3,3)]);
J3 = simplify([cross(T_0_3(1:3,3), T_0_EE(1:3,4) - T_0_3(1:3,4));
              T_0_3(1:3,3)]);
J4 = simplify([cross(T_0_4(1:3,3), T_0_EE(1:3,4) - T_0_4(1:3,4));
              T_0_4(1:3,3)]);
J5 = simplify(expand([cross(T_0_5(1:3,3), T_0_EE(1:3,4) - T_0_5(1:3,4));
              T_0_5(1:3,3)]));
J6 = simplify([cross(T_0_6(1:3,3), T_0_EE(1:3,4) - T_0_6(1:3,4));
              T_0_6(1:3,3)]);
Jacobi_03 = [J1 J2 J3 J4 J5 J6];
% Check Jacobian
err1 = simplify(expand(Jacobi_01 - Jacobi_02))
err2 = simplify(expand(Jacobi_02 - Jacobi_03))
% Check linear velocity v_0_EE = P_0_EE'
P0ee_diff = simplify([sum(diag(thed)*gradient(T_0_EE(1,4),the));
                      sum(diag(thed)*gradient(T_0_EE(2,4),the));
                      sum(diag(thed)*gradient(T_0_EE(3,4),the))]);
err3 = simplify(expand(v0ee - P0ee_diff))
%
J11_0 = simplify(Jacobi_02(1:3,1:3));
J11_3 = simplify(inv(T_0_3(1:3,1:3))*J11_0);
J11_3_inv = simplify(inv(J11_3));
k1 = simplify(J11_3(3,1));
k2 = d4*cos(the3) + a3*sin(the3) + d7*cos(the3)*cos(the5) - d7*cos(the4)*sin(the3)*sin(the5);
A1 = [1/k1 0 0;0 1/k2 0;0 0 1/k2];
B1 = inv(A1)*J11_3_inv;
detA1 = simplify(det(A1)); % 1/((k2^2)*k1)
detB1 = simplify(det(B1)); % k2/a2
J22_0 = simplify(Jacobi_02(4:6,4:6));
J22_5 = simplify(inv(T_0_5(1:3,1:3))*J22_0);
J22_5_inv = simplify(inv(J22_5));
k3 = sin(the5);
% A2 = [1/k3 0 0;0 1 0;0 0 1/k3]
A2 = 1/k3;
B2 = inv(A2)*J22_5_inv;
detA2 = simplify(det(A2)); % 1/k3
detB2 = simplify(det(B2)); % -k3^2
% test
% J11_3_ = [0 a2*sin(the3)-d4 -d4;
%           0 a2*cos(the3)+a3 a3;
%           a3*cos(the2+the3)-d4*sin(the2+the3)+a2*cos(the2)+a1 0 0]
% J11_3_inv_ = simplify(inv(J11_3_))
% k1_ = a3*cos(the2+the3)-d4*sin(the2+the3)+a2*cos(the2)+a1;
% k2_ = a3*sin(the3)+d4*cos(the3);
% A_ = [1/k1_ 0 0;0 1/k2_ 0;0 0 1/k2_];
% B_ = inv(A_)*J11_3_inv_
% detA_ = simplify(det(A_))
% detB_ = det(B_)

% NEW JACOBIAN 2
J1 = simplify([cross(T_0_1(1:3,3), T_0_4(1:3,4) - T_0_1(1:3,4));
              T_0_1(1:3,3)]);
J2 = simplify([cross(T_0_2(1:3,3), T_0_4(1:3,4) - T_0_2(1:3,4));
              T_0_2(1:3,3)]);
J3 = simplify([cross(T_0_3(1:3,3), T_0_4(1:3,4) - T_0_3(1:3,4));
              T_0_3(1:3,3)]);
J4 = simplify([cross(T_0_4(1:3,3), T_0_4(1:3,4) - T_0_4(1:3,4));
              T_0_4(1:3,3)]);
J5 = simplify(expand([cross(T_0_5(1:3,3), T_0_4(1:3,4) - T_0_5(1:3,4));
              T_0_5(1:3,3)]));
J6 = simplify([cross(T_0_6(1:3,3), T_0_4(1:3,4) - T_0_6(1:3,4));
              T_0_6(1:3,3)]);
Jacobi_03 = [J1 J2 J3 J4 J5 J6];

J11_0 = simplify(Jacobi_03(1:3,1:3));
J11_3 = simplify(inv(T_0_3(1:3,1:3))*J11_0);
J11_3_inv = simplify(inv(J11_3));
k1 = simplify(J11_3(3,1));
k2 = d4*cos(the3) + a3*sin(the3);
A1 = [1/k1 0 0;0 1/k2 0;0 0 1/k2];
B1 = inv(A1)*J11_3_inv;
detA1 = simplify(det(A1)); % 1/((k2^2)*k1)
detB1 = simplify(det(B1)); % k2/a2

J22_0 = simplify(Jacobi_02(4:6,4:6));
J22_5 = simplify(inv(T_0_5(1:3,1:3))*J22_0);
J22_5_inv = simplify(inv(J22_5));
k3 = sin(the5);
% A2 = [1/k3 0 0;0 1 0;0 0 1/k3]
A2 = 1/k3;
B2 = inv(A2)*J22_5_inv;
detA2 = simplify(det(A2)); % 1/k3
detB2 = simplify(det(B2)); % -k3^2

de_u = A1*B1*v3ee;