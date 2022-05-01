%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2021/09/23
% Topic: Forward Kinematics and Find Jacobian Matrix
% NOTE: DONE
%%
clc; clear all;
syms a alpha d e
syms a1 a2 a3 d1 d4 d7 e1 e2 e3 e4 e5 e6
syms de1 de2 de3 de4 de5 de6
%% FIND T_0_1
T_0_1 = FK_6DOF(0,0,d1,e1);
%% FIND T_1_2
T_1_2 = FK_6DOF(a1,sym(-pi/2),0,e2-sym(pi/2));
%% FIND T_2_3
T_2_3 = FK_6DOF(a2,0,0,e3);
%% FIND T_3_4
T_3_4 = FK_6DOF(a3,sym(-pi/2),d4,e4);
%% FIND T_4_5
T_4_5 = FK_6DOF(0,sym(pi/2),0,e5);
%% FIND T_5_6
T_5_6 = FK_6DOF(0,sym(-pi/2),0,e6);
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
% pitch = atan2(T_0_EE(3,1),sqrt(T_0_EE(1,1)^2+T_0_EE(2,1)^2))
% yaw = atan2(T_0_EE(2,1)/cos(pitch),T_0_EE(1,1)/cos(pitch))
% roll = atan2(T_0_EE(3,2)/cos(pitch),T_0_EE(3,3)/cos(pitch))
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
e = [e1 e2 e3 e4 e5 e6];
de = [de1 de2 de3 de4 de5 de6];
% Angular Velocities:                
w00 = [0;0;0];
w11 = simplify(transpose(T_0_1(1:3,1:3))*w00 + [0;0;de1]);
w22 = simplify(transpose(T_1_2(1:3,1:3))*w11 + [0;0;de2]);
w33 = simplify(transpose(T_2_3(1:3,1:3))*w22 + [0;0;de3]);
w44 = simplify(transpose(T_3_4(1:3,1:3))*w33 + [0;0;de4]);
w55 = simplify(transpose(T_4_5(1:3,1:3))*w44 + [0;0;de5]);
w66 = simplify(transpose(T_5_6(1:3,1:3))*w55 + [0;0;de6]);
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
% Angular Velocities from e origin coordinate system
w01 = simplify(T_0_1(1:3,1:3)*w11);
w02 = simplify(T_0_2(1:3,1:3)*w22);
w03 = simplify(T_0_3(1:3,1:3)*w33);
w04 = simplify(T_0_4(1:3,1:3)*w44);
w05 = simplify(T_0_5(1:3,1:3)*w55);
w06 = simplify(T_0_6(1:3,1:3)*w66);
w0ee = simplify(T_0_EE(1:3,1:3)*wee);   % w0ee = w06

% gradient: dao ham rieng theo vecto (nhieu bien)
% diff: dao ham rieng theo 1 bien 
Jacobi_01 = simplify([diff(Px,e1) diff(Px,e2) diff(Px,e3) diff(Px,e4) diff(Px,e5) diff(Px,e6);
                      diff(Py,e1) diff(Py,e2) diff(Py,e3) diff(Py,e4) diff(Py,e5) diff(Py,e6);
                      diff(Pz,e1) diff(Pz,e2) diff(Pz,e3) diff(Pz,e4) diff(Pz,e5) diff(Pz,e6);
                      diff(w01(1),de1) diff(w02(1),de2) diff(w03(1),de3) diff(w04(1),de4) diff(w05(1),de5) diff(w06(1),de6);
                      diff(w01(2),de1) diff(w02(2),de2) diff(w03(2),de3) diff(w04(2),de4) diff(w05(2),de5) diff(w06(2),de6);
                      diff(w01(3),de1) diff(w02(3),de2) diff(w03(3),de3) diff(w04(3),de4) diff(w05(3),de5) diff(w06(3),de6)]);
                      %diff_jac(w01,de1), diff_jac(w02,de2), diff_jac(w03,de3), diff_jac(w04,de4), diff_jac(w05,de5), diff_jac(w06,de6)
Jacobi_02 = simplify([transpose(gradient(v0ee(1),de));
                      transpose(gradient(v0ee(2),de));
                      transpose(gradient(v0ee(3),de));
                      transpose(gradient(w0ee(1),de));
                      transpose(gradient(w0ee(2),de));
                      transpose(gradient(w0ee(3),de))]);
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
P0ee_diff = simplify([sum(diag(de)*gradient(T_0_EE(1,4),e));
                      sum(diag(de)*gradient(T_0_EE(2,4),e));
                      sum(diag(de)*gradient(T_0_EE(3,4),e))]);
err3 = simplify(expand(v0ee - P0ee_diff))
%
J11_0 = simplify(Jacobi_02(1:3,1:3));
J11_3 = simplify(inv(T_0_3(1:3,1:3))*J11_0);
J11_3_inv = simplify(inv(J11_3));
k1 = simplify(J11_3(3,1));
k2 = d4*cos(e3) + a3*sin(e3) + d7*cos(e3)*cos(e5) - d7*cos(e4)*sin(e3)*sin(e5);
A1 = [1/k1 0 0;0 1/k2 0;0 0 1/k2];
B1 = inv(A1)*J11_3_inv;
detA1 = simplify(det(A1)); % 1/((k2^2)*k1)
detB1 = simplify(det(B1)); % k2/a2
J22_0 = simplify(Jacobi_02(4:6,4:6));
J22_5 = simplify(inv(T_0_5(1:3,1:3))*J22_0);
J22_5_inv = simplify(inv(J22_5));
k3 = sin(e5);
% A2 = [1/k3 0 0;0 1 0;0 0 1/k3]
A2 = 1/k3;
B2 = inv(A2)*J22_5_inv;
detA2 = simplify(det(A2)); % 1/k3
detB2 = simplify(det(B2)); % -k3^2
% test
% J11_3_ = [0 a2*sin(e3)-d4 -d4;
%           0 a2*cos(e3)+a3 a3;
%           a3*cos(e2+e3)-d4*sin(e2+e3)+a2*cos(e2)+a1 0 0]
% J11_3_inv_ = simplify(inv(J11_3_))
% k1_ = a3*cos(e2+e3)-d4*sin(e2+e3)+a2*cos(e2)+a1;
% k2_ = a3*sin(e3)+d4*cos(e3);
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
k2 = d4*cos(e3) + a3*sin(e3);
A1 = [1/k1 0 0;0 1/k2 0;0 0 1/k2];
B1 = inv(A1)*J11_3_inv;
detA1 = simplify(det(A1)); % 1/((k2^2)*k1)
detB1 = simplify(det(B1)); % k2/a2

J22_0 = simplify(Jacobi_02(4:6,4:6));
J22_5 = simplify(inv(T_0_5(1:3,1:3))*J22_0);
J22_5_inv = simplify(inv(J22_5));
k3 = sin(e5);
% A2 = [1/k3 0 0;0 1 0;0 0 1/k3]
A2 = 1/k3;
B2 = inv(A2)*J22_5_inv;
detA2 = simplify(det(A2)); % 1/k3
detB2 = simplify(det(B2)); % -k3^2

de_u = A1*B1*v3ee;