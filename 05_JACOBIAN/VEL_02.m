clc; clear all;close all
% ROBOT PARAMETERS
syms the1 the2 the3 the4 the5 the6
syms the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot
syms a1 a2 a3 d1 d4 d7
syms d1_dot d2_dot d3_dot

% BUILD DH TABLE
DH = [0     0           d1  the1;
      a1    sym(-pi/2)  0   the2-sym(-pi/2);
      a2    0           0   the3;
      a3    sym(-pi/2)  d4  the4;
      0     sym(pi/2)   0   the5;
      0     sym(-pi/2)  0   the6;
      0     0           d7  0];
d_dot = [0;0;0;0;0;0;0]; %dien vao neu la LAN TRUYEN TINH TIEN  %NHO DIEU CHINH
w_i_1_i_1 = zeros(3,1);
v_i_1_i_1 = zeros(3,1);
the_dot = [the1_dot;the2_dot;the3_dot;the4_dot;the5_dot;the6_dot;0]; %NHO DIEU CHINH
T_0_i_1 = eye(4);

for i=1:length(DH(:,1)),
    disp('---------------------------------');
    disp(sprintf("Buoc i=%01d",i-1));
    
    the = DH(i,4); anp = DH(i,2); a = DH(i,1); d = DH(i,3);
    T_i_i_1 = [ cos(the)            -sin(the)           0           a;
                sin(the)*cos(anp)   cos(the)*cos(anp)   -sin(anp)   -sin(anp)*d;
                sin(the)*sin(anp)   cos(the)*sin(anp)   cos(anp)    cos(anp)*d;
                0                   0                   0           1];
    R_i_1_i = transpose(T_i_i_1(1:3,1:3))
    P_i_i_1 = T_i_i_1(1:3,4)
    v_i_1_i_1 = simplify(R_i_1_i*(v_i_1_i_1 + Om_i_i(w_i_1_i_1)*P_i_i_1) + d_dot(i)*[0;0;1])
    w_i_1_i_1 = simplify(R_i_1_i*w_i_1_i_1 + the_dot(i)*[0;0;1])
  
    T_0_i_1 = simplify(T_0_i_1*T_i_i_1)
end
disp('------------------------------------');
disp("Ket qua cuoi cung");
P_0_i = T_0_i_1(1:3,4)
R_0_i = T_0_i_1(1:3,1:3)
w_0_EE = simplify(R_0_i*w_i_1_i_1)
v_0_EE = simplify(R_0_i*v_i_1_i_1)
disp('--------------------------');