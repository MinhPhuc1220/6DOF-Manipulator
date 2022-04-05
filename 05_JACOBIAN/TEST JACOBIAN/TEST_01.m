clc; clear all;
syms L1 L2 the1 the2 the3 
syms the1_dot the2_dot the3_dot
the = [the1 the2 the3];
the_dot = [the1_dot the2_dot the3_dot];
P_0_3 = [ L1*cos(the1) + L2*cos(the1+the2);
          L1*sin(the1) + L2*sin(the1+the2);
          0]
v_0_3 = [sum(diag(the_dot)*gradient(P_0_3(1),the));
         sum(diag(the_dot)*gradient(P_0_3(2),the))
         sum(diag(the_dot)*gradient(P_0_3(3),the))]



