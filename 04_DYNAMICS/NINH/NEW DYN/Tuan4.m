% Programmed by : Tong Hai Ninh
clc; clear all;close all;

syms the1 the2 the3 the4 the5 the6 the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot ...
    d1 d2 d3 d4 d5 d6 d7 d8 a0 a1 a2 a3 a4 a5 a6 a7 d1_dot d2_dot d3_dot...
    x1 y1 z1 x2 y2 z2 x3 y3 z3 x4 y4 z4 x5 y5 z5 x6 y6 z6; 
% syms the1 the2 the3 the4 the5 the6 the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot ...
%     d1 d2 d3 d4 d5 d6 d7 d8 a0 a1 a2 a3 a4 a5 a6 a7 d1_dot d2_dot d3_dot...
%     x1 y1 z1 x2 y2 z2 x3 y3 z3 x4 y4 z4 x5 y5 z5 x6 y6 z6; 
syms f_ee_x f_ee_y f_ee_z f_0_3x f_0_3y f_0_3z ;
syms the1_2dot the2_2dot the3_2dot the4_2dot the5_2dot the6_2dot ...
     d1_2dot d2_2dot d3_2dot d4_2dot;
%%
% l3 = 2.7;l4 = 0.9;l5 = 1.08;l6 = 1.87;l7 = 0.8;
% d1 = 0.75;

DH = [0     ,0      ,d1    ,the1;
      a1    ,-pi/2  ,0    ,the2-pi/2;
      a2    ,0      ,0     ,the3;
      a3    ,-pi/2  ,d4   ,the4;
      0     ,pi/2   ,0     ,the5;
      0     ,-pi/2  ,0     ,the6];
% DH = [l1     ,0      ,l0    ,the1;
%       l2    ,0      ,0    ,the2;
%       l3    ,0      ,0    ,the2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w_i_i = sym(zeros(3,length(DH(:,1))+1));
v_i_i = sym(zeros(3,length(DH(:,1))+2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
the_dot = [the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot];
d_dot = [0 0 0 0 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_i_1_i = eye(4);
T = zeros(4);
R_i_i = sym(zeros(3));
P_BORG = [0; 0; d7;1];
% P_BORG = [l4; 0; 0;1];
% Pc_i = ... % toa do trong tam
% [  0.0349, -0.0089, -0.0830, 1;
%    0.1275, -0.0046, -0.0773, 1;
%    0.0016,  0.0608,  0.0013, 1;
%    0.0002, -0.0001, -0.1097, 1;
%         0,  0.0058,       0, 1;
%         0,       0,  0.0592, 1];
Pc_i = ... % toa do trong tam
[  x1, y1, z1, 1;
   x2, y2, z2, 1;
   x3, y3, z3, 1;
   x4, y4, z4, 1;
   x5, y5, z5, 1;
   x6, y6, z6, 1];
% Pc_i = ... % toa do trong tam
% [  l1/2, 0, 0, 1;
%    l2/2, 0, 0, 1;
%    l3/2, 0, 0, 1];
P_i = sym(zeros(3,length(DH(:,1))+1));
P_ic = sym(zeros(3,length(DH(:,1))));
z_i = sym(zeros(3,length(DH(:,1))));
disp('--...--- Linear and Rotational Velocity ---...--');
disp('------------------------------------');
for i=1:length(DH(:,1))
    disp('---------------------------------');
    disp(sprintf("Buoc %02d",i-1));
    the = DH(i,4); anp = DH(i,2); a = DH(i,1); d = DH(i,3);
    T_i_1 = [cos(the)              ,-sin(the)            ,0              ,a;
             sin(the)*cos(anp)    ,cos(the)*cos(anp)   ,-sin(anp)     ,-sin(anp)*d;
             sin(the)*sin(anp)    ,cos(the)*sin(anp)   ,cos(anp)      ,cos(anp)*d;
             0                      ,0                     ,0              ,1];
    fprintf("T_%d_%d = \n",i-1,i);
    disp(T_i_1);
    R_i_i = T_i_1(1:3,1:3);
    
    fprintf("v_%d_%d = \n",i-1,i-1);
    v_i_i(:,i+1) = simplify(transpose(R_i_i)*(v_i_i(:,i) + Om_Rota(w_i_i(:,i))*T_i_1(1:3,4)) + d_dot(i)*[0;0;1]);
    disp(v_i_i(:,i+1));
    fprintf("w_%d_%d = \n",i-1,i-1);
    w_i_i(:,i+1) = simplify(transpose(R_i_i)*w_i_i(:,i) + the_dot(i)*[0;0;1]);
    disp(w_i_i(:,i+1));
    
    fprintf("T_0_%d = \n",i);
    T_i_1_i = (simplify(T_i_1_i*T_i_1));
    disp(T_i_1_i);
    P_i(:,i)= T_i_1_i(1:3,4); % P_i-1_i
    F = simplify(T_i_1_i*transpose(Pc_i(i,:)));
    P_ic(:,i) = F(1:3);
    z_i(:,i) = T_i_1_i(1:3,3);
end
disp('------------------------------------');
disp(sprintf("Buoc %02d",i));
fprintf("v_%d_%d = \n",i,i);
v_i_i(:,i+2) = simplify(v_i_i(:,i+1) + Om_Rota(w_i_i(:,i+1))*P_BORG(1:3));
disp(v_i_i(:,i+2));
disp('------------------------------------');
disp("Ket qua cuoi cung");
R_i_i = simplify(T_i_1_i(1:3,1:3));
w_0_EE = (R_i_i*w_i_i(:,i+1));
v_0_EE = (R_i_i*v_i_i(:,i+2));
P_A_BORG = T_i_1_i*P_BORG;
P_i(:,i+1)= P_A_BORG(1:3);
disp('Solved End-Effector Position of Robot');
disp('------------------------------------');
G = simplify(P_A_BORG(1:3));
fprintf("Diem dau cuoi P_0_EE: \n");
disp(G);
%% Jacobian Matrix
% %%
% Jac1 = simplify([cross(z_i(:,1), G - P_i(:,1)), cross(z_i(:,2), G - P_i(:,2)), cross(z_i(:,3), G - P_i(:,3)), cross(z_i(:,4), G - P_i(:,4)), cross(z_i(:,5), G - P_i(:,5)), cross(z_i(:,6), G - P_i(:,6));
%                  z_i(:,1), z_i(:,2), z_i(:,3), z_i(:,4), z_i(:,5), z_i(:,6)]);
