clc; clear all;
syms the1 the2 the3 the4 the5 the6 the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot ...
    d1 d2 d3 d4 d5 d6 d7 d8 l1 l2 l3 l4 l5 l6 l7 d1_dot d2_dot d3_dot;
% syms pi;
%%
% the1 = pi/2;
% the2 = pi/3;
% the3 = pi/4;
% the4 = pi/6;
% the5 = pi/6;
% the6 = 0;
% 
% l3 = 2.7;l4 = 0.9;l5 = 1.08;l6 = 0.4;l7 = 0.4;
% d1 = 0.75;
%% End-Effect
x = cos(the1)*(d2 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)) - (l6 + l7)*(sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) - sin(the2 + the3)*cos(the1)*cos(the5));
y = (l6 + l7)*(sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1)) + sin(the1)*(d2 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2));
z = l4*sin(the2 + the3) - l5*cos(the2 + the3) + l3*sin(the2) - (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7);
%%
P_BORG = [1, 0, 0, 0;
          0, 1, 0, 0;
          0, 0, 1, l6+l7;
          0, 0, 0, 1];
%% the1
T_0_1 = ...
[cos(the1), -sin(the1), 0, 0;
 sin(the1),  cos(the1), 0, 0;
         0,          0, 1, 0;
         0,          0, 0, 1];
%% the2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_1_2 = ...
[cos(the2), -sin(the2),  0, d2;
         0,          0, -1,  0;
 sin(the2),  cos(the2),  0,  0;
         0,          0,  0,  1];
     
T_0_2 = simplify(T_0_1*T_1_2);
% T_0_2 = ...
% [cos(the1)*cos(the2), -cos(the1)*sin(the2),  sin(the1), d1*cos(the1);
%  cos(the2)*sin(the1), -sin(the1)*sin(the2), -cos(the1), d1*sin(the1);
%            sin(the2),            cos(the2),          0,            0;
%                    0,                    0,          0,            1];
%% the3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_2_3 = ...
[cos(the3), -sin(the3), 0, l3;
 sin(the3),  cos(the3), 0,  0;
         0,          0, 1,  0;
         0,          0, 0,  1];
T_0_3 = simplify(T_0_2*T_2_3);

% T_0_3 = ...
% [cos(the2 + the3)*cos(the1), -sin(the2 + the3)*cos(the1),  sin(the1), cos(the1)*(d1 + l3*cos(the2));
%  cos(the2 + the3)*sin(the1), -sin(the2 + the3)*sin(the1), -cos(the1), sin(the1)*(d1 + l3*cos(the2));
%            sin(the2 + the3),            cos(the2 + the3),          0,                  l3*sin(the2);
%                           0,                           0,          0,                             1];
%% the4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_3_4 = ...
[cos(the4), -sin(the4),  0,   l4;
         0,          0, -1, - l5;
 sin(the4),  cos(the4),  0,    0;
         0,          0,  0,    1];
T_0_4 = simplify(T_0_3*T_3_4);

% T_0_4 = ...
% [sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4),   cos(the4)*sin(the1) - cos(the2 + the3)*cos(the1)*sin(the4), sin(the2 + the3)*cos(the1), cos(the1)*(d1 + l3*cos(the2)) + sin(the2 + the3)*cos(the1)*(l4 + l5);
%  cos(the2 + the3)*cos(the4)*sin(the1) - cos(the1)*sin(the4), - cos(the1)*cos(the4) - cos(the2 + the3)*sin(the1)*sin(the4), sin(the2 + the3)*sin(the1), sin(the1)*(d1 + l3*cos(the2)) + sin(the2 + the3)*sin(the1)*(l4 + l5);
%                                  sin(the2 + the3)*cos(the4),                                  -sin(the2 + the3)*sin(the4),          -cos(the2 + the3),                            l3*sin(the2) - cos(the2 + the3)*(l4 + l5);
%                                                           0,                                                            0,                          0,                                                                    1];
%% the5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_4_5 = ...
[cos(the5), -sin(the5),  0, 0;
         0,          0, -1, 0;
 sin(the5),  cos(the5),  0, 0;
         0,          0,  0, 1];
T_0_5 = simplify(T_0_4*T_4_5);
 
% T_0_5 = ...
% [cos(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) + sin(the2 + the3)*cos(the1)*sin(the5), sin(the2 + the3)*cos(the1)*cos(the5) - sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)), cos(the2 + the3)*cos(the1)*sin(the4) - cos(the4)*sin(the1), cos(the1)*(d1 + l3*cos(the2)) + sin(the2 + the3)*cos(the1)*(l4 + l5);
%  sin(the2 + the3)*sin(the1)*sin(the5) - cos(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)), sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1), cos(the1)*cos(the4) + cos(the2 + the3)*sin(the1)*sin(the4), sin(the1)*(d1 + l3*cos(the2)) + sin(the2 + the3)*sin(the1)*(l4 + l5);
%                                              sin(the2 + the3)*cos(the4)*cos(the5) - cos(the2 + the3)*sin(the5),                                           - cos(the2 + the3)*cos(the5) - sin(the2 + the3)*cos(the4)*sin(the5),                                 sin(the2 + the3)*sin(the4),                            l3*sin(the2) - cos(the2 + the3)*(l4 + l5);
%                                                                                                              0,                                                                                                             0,                                                          0,                                                                    1];
%% the6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_5_6 = ...
[ cos(the6), -sin(the6), 0, 0;
          0,          0, 1, 0;
 -sin(the6), -cos(the6), 0, 0;
          0,          0, 0, 1];
% T_6_6 = [1, 0, 0, 0;
%          0, 1, 0, 0;
%          0, 0, 1, l6+l7;
%          0, 0, 0, 1];
T_5_EE = simplify(T_5_6*P_BORG);
T_0_6 = simplify(T_0_5*T_5_6);
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_0_EE = simplify(T_0_6*P_BORG)
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_1_6 = simplify(inv(T_0_1)*T_0_EE)
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_1_3 = simplify(T_1_2*T_2_3)
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_3_6 = simplify(inv(T_0_3)*T_0_EE)
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_4_6 = simplify(inv(T_0_4)*T_0_EE)
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_5_6 = simplify(inv(T_0_5)*T_0_EE)
%%
syms Px Py Pz r11 r12 r13 r21 r22 r23 r31 r32 r33;
R_E_E = [r11,r12,r13,Px;
         r21,r22,r23,Py;
         r31,r32,r33,Pz;
         0  ,  0,  0, 1];
T_0_E = simplify(expand(inv(T_0_3)*R_E_E))

%%%% Jacobian Matrix
%%
w00 = [0;0;0];
w11 = simplify(transpose(T_0_1(1:3,1:3))*w00 + [0;0;the1_dot])
w22 = simplify(transpose(T_1_2(1:3,1:3))*w11 + [0;0;the2_dot])
w33 = simplify(transpose(T_2_3(1:3,1:3))*w22 + [0;0;the3_dot])
w44 = simplify(transpose(T_3_4(1:3,1:3))*w33 + [0;0;the4_dot])
w55 = simplify(transpose(T_4_5(1:3,1:3))*w44 + [0;0;the5_dot])
w66 = simplify(transpose(T_5_6(1:3,1:3))*w55 + [0;0;the6_dot])

v00 = [0;0;0];
v11 = simplify(transpose(T_0_1(1:3,1:3))*(v00 + cross(w00,T_0_1(1:3,4))))
v22 = simplify(transpose(T_1_2(1:3,1:3))*(v11 + cross(w11,T_1_2(1:3,4))))
v33 = simplify(transpose(T_2_3(1:3,1:3))*(v22 + cross(w22,T_2_3(1:3,4))))
v44 = simplify(transpose(T_3_4(1:3,1:3))*(v33 + cross(w33,T_3_4(1:3,4))))
v55 = simplify(transpose(T_4_5(1:3,1:3))*(v44 + cross(w44,T_4_5(1:3,4))))
v66 = simplify(transpose(T_5_EE(1:3,1:3))*(v55 + cross(w55,T_5_EE(1:3,4))))
%%
w01 = simplify(T_0_1(1:3,1:3)*w11)
w02 = simplify(T_0_2(1:3,1:3)*w22)
w03 = simplify(T_0_3(1:3,1:3)*w33)
w04 = simplify(T_0_4(1:3,1:3)*w44)
w05 = simplify(T_0_5(1:3,1:3)*w55)
w06 = simplify(T_0_6(1:3,1:3)*w66)
v06 = T_0_6(1:3,1:3)*v66
%%
the = [the1 the2 the3 the4 the5 the6];
thed = [the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot];
J06 = simplify([transpose(gradient(v06(1),thed));
                transpose(gradient(v06(2),thed));
                transpose(gradient(v06(3),thed));
                diff_jac(w01,the1_dot), diff_jac(w02,the2_dot), diff_jac(w03,the3_dot), diff_jac(w04,the4_dot), diff_jac(w05,the5_dot), diff_jac(w06,the6_dot)])

            
%% 
J = simplify([diff(x,the1),diff(x,the2),diff(x,the3),diff(x,the4),diff(x,the5),diff(x,the6);
              diff(y,the1),diff(y,the2),diff(y,the3),diff(y,the4),diff(y,the5),diff(y,the6);
              diff(z,the1),diff(z,the2),diff(z,the3),diff(z,the4),diff(z,the5),diff(z,the6)])
%%
Jac1 =...
[ - (l6 + l7)*(sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1)) - sin(the1)*(d2 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)),                                                         cos(the1)*(l5*cos(the2 + the3) - l4*sin(the2 + the3) - l3*sin(the2) + (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)),                                                                                                                                                                                                                                                                                             cos(the1)*(l5*cos(the2 + the3) - l4*sin(the2 + the3) + (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)), -sin(the5)*(l6 + l7)*(cos(the4)*sin(the1) - cos(the2 + the3)*cos(the1)*sin(the4)), - (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)*(cos(the1)*cos(the4) + cos(the2 + the3)*sin(the1)*sin(the4)) - sin(the2 + the3)*sin(the4)*(l6 + l7)*(sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1)),                                                                                                             0
    cos(the1)*(d2 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)) - (l6 + l7)*(sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) - sin(the2 + the3)*cos(the1)*cos(the5)),                                                         sin(the1)*(l5*cos(the2 + the3) - l4*sin(the2 + the3) - l3*sin(the2) + (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)),                                                                                                                                                                                                                                                                                             sin(the1)*(l5*cos(the2 + the3) - l4*sin(the2 + the3) + (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)),  sin(the5)*(l6 + l7)*(cos(the1)*cos(the4) + cos(the2 + the3)*sin(the1)*sin(the4)), - (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7)*(cos(the4)*sin(the1) - cos(the2 + the3)*cos(the1)*sin(the4)) - sin(the2 + the3)*sin(the4)*(l6 + l7)*(sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) - sin(the2 + the3)*cos(the1)*cos(the5)),                                                                                                             0
                                                                                                                                                                                                        0, l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2) + l6*sin(the2 + the3)*cos(the5) + l7*sin(the2 + the3)*cos(the5) - l6*cos(the2 + the3)*cos(the4)*sin(the5) - l7*cos(the2 + the3)*cos(the4)*sin(the5), l4*cos(the2)*cos(the3) + l5*cos(the2)*sin(the3) + l5*cos(the3)*sin(the2) - l4*sin(the2)*sin(the3) + l6*cos(the2)*cos(the5)*sin(the3) + l6*cos(the3)*cos(the5)*sin(the2) + l7*cos(the2)*cos(the5)*sin(the3) + l7*cos(the3)*cos(the5)*sin(the2) - l6*cos(the2)*cos(the3)*cos(the4)*sin(the5) - l7*cos(the2)*cos(the3)*cos(the4)*sin(the5) + l6*cos(the4)*sin(the2)*sin(the3)*sin(the5) + l7*cos(the4)*sin(the2)*sin(the3)*sin(the5),                                    sin(the2 + the3)*sin(the4)*sin(the5)*(l6 + l7),                                                                                                                                                                                                                       (cos(the2 + the3)*sin(the5) - sin(the2 + the3)*cos(the4)*cos(the5))*(l6 + l7),                                                                                                             0
                                                                                                                                                                                                        0,                                                                                                                                                                                                    sin(the1),                                                                                                                                                                                                                                                                                                                                                                                                                         sin(the1),                                                        sin(the2 + the3)*cos(the1),                                                                                                                                                                                                                                          cos(the2 + the3)*cos(the1)*sin(the4) - cos(the4)*sin(the1), sin(the2 + the3)*cos(the1)*cos(the5) - sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4))
                                                                                                                                                                                                        0,                                                                                                                                                                                                   -cos(the1),                                                                                                                                                                                                                                                                                                                                                                                                                        -cos(the1),                                                        sin(the2 + the3)*sin(the1),                                                                                                                                                                                                                                          cos(the1)*cos(the4) + cos(the2 + the3)*sin(the1)*sin(the4), sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1) 
                                                                                                                                                                                                        1,                                                                                                                                                                                                            0,                                                                                                                                                                                                                                                                                                                                                                                                                                 0,                                                                 -cos(the2 + the3),                                                                                                                                                                                                                                                                          sin(the2 + the3)*sin(the4),                                           - cos(the2 + the3)*cos(the5) - sin(the2 + the3)*cos(the4)*sin(the5)]
simplify(expand(J06 - Jac1))