clc;
clear all;
close all;
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;
e1=0;e2=0;e3=0;e4=0;e5=0;e6=0;
P_0_EE = [ cos(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) - d7*(sin(e5)*(sin(e1)*sin(e4) + sin(e2 + e3)*cos(e1)*cos(e4)) - cos(e2 + e3)*cos(e1)*cos(e5));
           sin(e1)*(a1 + d4*cos(e2 + e3) + a3*sin(e2 + e3) + a2*sin(e2)) + d7*(sin(e5)*(cos(e1)*sin(e4) - sin(e2 + e3)*cos(e4)*sin(e1)) + cos(e2 + e3)*cos(e5)*sin(e1));
           d1 + a3*cos(e2 + e3) - d4*sin(e2 + e3) - d7*(sin(e2 + e3)*cos(e5) + cos(e2 + e3)*cos(e4)*sin(e5)) + a2*cos(e2)]