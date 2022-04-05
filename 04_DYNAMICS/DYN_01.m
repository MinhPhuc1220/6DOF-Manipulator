%% Authors:
% Made by Tran Minh Phuc
% Date: 2021/02/12
% Topic: Tính toán DYN (dạng tổng quát)
% Lagrange approach
%% Total of kinetic energies:
K = 1/2*(m1*v01c'*v01c + I1*w1'*w1) + 1/2*(m2*v02c'*v02c + I2*w2'*w2) + 1/2*(m3*v03c'*v03c + I3*w3'*w3) + 1/2*(m4*v04c'*v04c + I4*w4'*w4) + 1/2*(m5*v05c'*v05c + I5*w5'*w5) + 1/2*(m6*v06c'*v06c + I6*w6'*w6);
%% Total of potential energies:
U = -m1*[0 0 g]*P01c - m2*[0 0 g]*P02c - m3*[0 0 g]*P03c - m4*[0 0 g]*P04c - m5*[0 0 g]*P05c - m6*[0 0 g]*P06c;
%% Lagrange function:
L = simplify(K-U);
dLdde1 = diff(L,de1);
dLdde2 = diff(L,de2);
dLdde3 = diff(L,de3);
dLdde4 = diff(L,de4);
dLdde5 = diff(L,de5);
dLdde6 = diff(L,de6);
dLde1 = diff(L,e1);
dLde2 = diff(L,e2);
dLde3 = diff(L,e3);
dLde4 = diff(L,e4);
dLde5 = diff(L,e5);
dLde6 = diff(L,e6);
%% Differential
t1 = simplify(diff(dLdde1,e1)*de1 + diff(dLdde1,e2)*de2 + diff(dLdde1,e3)*de3 + diff(dLdde1,e4)*de4 + diff(dLdde1,e5)*de5 + diff(dLdde1,e6)*de6 + diff(dLdde1,de1)*dde1 + diff(dLdde1,de2)*dde2 + diff(dLdde1,de3)*dde3 + diff(dLdde1,de4)*dde4 + diff(dLdde1,de5)*dde5 + diff(dLdde1,de6)*dde6 - dLde1);
t2 = simplify(diff(dLdde2,e1)*de1 + diff(dLdde2,e2)*de2 + diff(dLdde2,e3)*de3 + diff(dLdde2,e4)*de4 + diff(dLdde2,e5)*de5 + diff(dLdde2,e6)*de6 + diff(dLdde2,de1)*dde1 + diff(dLdde2,de2)*dde2 + diff(dLdde2,de3)*dde3 + diff(dLdde2,de4)*dde4 + diff(dLdde2,de5)*dde5 + diff(dLdde2,de6)*dde6 - dLde2);
t3 = simplify(diff(dLdde3,e1)*de1 + diff(dLdde3,e2)*de2 + diff(dLdde3,e3)*de3 + diff(dLdde3,e4)*de4 + diff(dLdde3,e5)*de5 + diff(dLdde3,e6)*de6 + diff(dLdde3,de1)*dde1 + diff(dLdde3,de2)*dde2 + diff(dLdde3,de3)*dde3 + diff(dLdde3,de4)*dde4 + diff(dLdde3,de5)*dde5 + diff(dLdde3,de6)*dde6 - dLde3);
t4 = simplify(diff(dLdde4,e1)*de1 + diff(dLdde4,e2)*de2 + diff(dLdde4,e3)*de3 + diff(dLdde4,e4)*de4 + diff(dLdde4,e5)*de5 + diff(dLdde4,e6)*de6 + diff(dLdde4,de1)*dde1 + diff(dLdde4,de2)*dde2 + diff(dLdde4,de3)*dde3 + diff(dLdde4,de4)*dde4 + diff(dLdde4,de5)*dde5 + diff(dLdde4,de6)*dde6 - dLde4);
t5 = simplify(diff(dLdde5,e1)*de1 + diff(dLdde5,e2)*de2 + diff(dLdde5,e3)*de3 + diff(dLdde5,e4)*de4 + diff(dLdde5,e5)*de5 + diff(dLdde5,e6)*de6 + diff(dLdde5,de1)*dde1 + diff(dLdde5,de2)*dde2 + diff(dLdde5,de3)*dde3 + diff(dLdde5,de4)*dde4 + diff(dLdde5,de5)*dde5 + diff(dLdde5,de6)*dde6 - dLde5);
t6 = simplify(diff(dLdde6,e1)*de1 + diff(dLdde6,e2)*de2 + diff(dLdde6,e3)*de3 + diff(dLdde6,e4)*de4 + diff(dLdde6,e5)*de5 + diff(dLdde6,e6)*de6 + diff(dLdde6,de1)*dde1 + diff(dLdde6,de2)*dde2 + diff(dLdde6,de3)*dde3 + diff(dLdde6,de4)*dde4 + diff(dLdde6,de5)*dde5 + diff(dLdde6,de6)*dde6 - dLde6);

fileTorque = fopen('Torque.txt','w');
fprintf(fileTorque,'Torque =...\n[%s;\n%s;\n%s;\n%s;\n%s;\n%s];',t1,t2,t3,t4,t5,t6);
%% Compute Inertia matrix:
M = simplify([diff(t1,dde1), diff(t1,dde2), diff(t1,dde3), diff(t1,dde4), diff(t1,dde5), diff(t1,dde6);
              diff(t2,dde1), diff(t2,dde2), diff(t2,dde3), diff(t2,dde4), diff(t2,dde5), diff(t2,dde6);
              diff(t3,dde1), diff(t3,dde2), diff(t3,dde3), diff(t3,dde4), diff(t3,dde5), diff(t3,dde6);
              diff(t4,dde1), diff(t4,dde2), diff(t4,dde3), diff(t4,dde4), diff(t4,dde5), diff(t4,dde6);
              diff(t5,dde1), diff(t5,dde2), diff(t5,dde3), diff(t5,dde4), diff(t5,dde5), diff(t5,dde6);
              diff(t6,dde1), diff(t6,dde2), diff(t6,dde3), diff(t6,dde4), diff(t6,dde5), diff(t6,dde6)]);
%% Compute gravity vector:
G = simplify([diff(U,e1);...
              diff(U,e2);...
              diff(U,e3);...
              diff(U,e4);...
              diff(U,e5);...
              diff(U,e6)]);
%% Compute Coriolis matrix
dM = simplify([diff(M(1,1),e1)*de1 + diff(M(1,1),e2)*de2 + diff(M(1,1),e3)*de3 + diff(M(1,1),e4)*de4 + diff(M(1,1),e5)*de5 + diff(M(1,1),e6)*de6, diff(M(1,2),e1)*de1 + diff(M(1,2),e2)*de2 + diff(M(1,2),e3)*de3 + diff(M(1,2),e4)*de4 + diff(M(1,2),e5)*de5 + diff(M(1,2),e6)*de6, diff(M(1,3),e1)*de1 + diff(M(1,3),e2)*de2 + diff(M(1,3),e3)*de3 + diff(M(1,3),e4)*de4 + diff(M(1,3),e5)*de5 + diff(M(1,3),e6)*de6, diff(M(1,4),e1)*de1 + diff(M(1,4),e2)*de2 + diff(M(1,4),e3)*de3 + diff(M(1,4),e4)*de4 + diff(M(1,4),e5)*de5 + diff(M(1,4),e6)*de6, diff(M(1,5),e1)*de1 + diff(M(1,5),e2)*de2 + diff(M(1,5),e3)*de3 + diff(M(1,5),e4)*de4 + diff(M(1,5),e5)*de5 + diff(M(1,5),e6)*de6, diff(M(1,6),e1)*de1 + diff(M(1,6),e2)*de2 + diff(M(1,6),e3)*de3 + diff(M(1,6),e4)*de4 + diff(M(1,6),e5)*de5 + diff(M(1,6),e6)*de6;...
               diff(M(2,1),e1)*de1 + diff(M(2,1),e2)*de2 + diff(M(2,1),e3)*de3 + diff(M(2,1),e4)*de4 + diff(M(2,1),e5)*de5 + diff(M(2,1),e6)*de6, diff(M(2,2),e1)*de1 + diff(M(2,2),e2)*de2 + diff(M(2,2),e3)*de3 + diff(M(2,2),e4)*de4 + diff(M(2,2),e5)*de5 + diff(M(2,2),e6)*de6, diff(M(2,3),e1)*de1 + diff(M(2,3),e2)*de2 + diff(M(2,3),e3)*de3 + diff(M(2,3),e4)*de4 + diff(M(2,3),e5)*de5 + diff(M(2,3),e6)*de6, diff(M(2,4),e1)*de1 + diff(M(2,4),e2)*de2 + diff(M(2,4),e3)*de3 + diff(M(2,4),e4)*de4 + diff(M(2,4),e5)*de5 + diff(M(2,4),e6)*de6, diff(M(2,5),e1)*de1 + diff(M(2,5),e2)*de2 + diff(M(2,5),e3)*de3 + diff(M(2,5),e4)*de4 + diff(M(2,5),e5)*de5 + diff(M(2,5),e6)*de6, diff(M(2,6),e1)*de1 + diff(M(2,6),e2)*de2 + diff(M(2,6),e3)*de3 + diff(M(2,6),e4)*de4 + diff(M(2,6),e5)*de5 + diff(M(2,6),e6)*de6;...
               diff(M(3,1),e1)*de1 + diff(M(3,1),e2)*de2 + diff(M(3,1),e3)*de3 + diff(M(3,1),e4)*de4 + diff(M(3,1),e5)*de5 + diff(M(3,1),e6)*de6, diff(M(3,2),e1)*de1 + diff(M(3,2),e2)*de2 + diff(M(3,2),e3)*de3 + diff(M(3,2),e4)*de4 + diff(M(3,2),e5)*de5 + diff(M(3,2),e6)*de6, diff(M(3,3),e1)*de1 + diff(M(3,3),e2)*de2 + diff(M(3,3),e3)*de3 + diff(M(3,3),e4)*de4 + diff(M(3,3),e5)*de5 + diff(M(3,3),e6)*de6, diff(M(3,4),e1)*de1 + diff(M(3,4),e2)*de2 + diff(M(3,4),e3)*de3 + diff(M(3,4),e4)*de4 + diff(M(3,4),e5)*de5 + diff(M(3,4),e6)*de6, diff(M(3,5),e1)*de1 + diff(M(3,5),e2)*de2 + diff(M(3,5),e3)*de3 + diff(M(3,5),e4)*de4 + diff(M(3,5),e5)*de5 + diff(M(3,5),e6)*de6, diff(M(3,6),e1)*de1 + diff(M(3,6),e2)*de2 + diff(M(3,6),e3)*de3 + diff(M(3,6),e4)*de4 + diff(M(3,6),e5)*de5 + diff(M(3,6),e6)*de6;...
               diff(M(4,1),e1)*de1 + diff(M(4,1),e2)*de2 + diff(M(4,1),e3)*de3 + diff(M(4,1),e4)*de4 + diff(M(4,1),e5)*de5 + diff(M(4,1),e6)*de6, diff(M(4,2),e1)*de1 + diff(M(4,2),e2)*de2 + diff(M(4,2),e3)*de3 + diff(M(4,2),e4)*de4 + diff(M(4,2),e5)*de5 + diff(M(4,2),e6)*de6, diff(M(4,3),e1)*de1 + diff(M(4,3),e2)*de2 + diff(M(4,3),e3)*de3 + diff(M(4,3),e4)*de4 + diff(M(4,3),e5)*de5 + diff(M(4,3),e6)*de6, diff(M(4,4),e1)*de1 + diff(M(4,4),e2)*de2 + diff(M(4,4),e3)*de3 + diff(M(4,4),e4)*de4 + diff(M(4,4),e5)*de5 + diff(M(4,4),e6)*de6, diff(M(4,5),e1)*de1 + diff(M(4,5),e2)*de2 + diff(M(4,5),e3)*de3 + diff(M(4,5),e4)*de4 + diff(M(4,5),e5)*de5 + diff(M(4,5),e6)*de6, diff(M(4,6),e1)*de1 + diff(M(4,6),e2)*de2 + diff(M(4,6),e3)*de3 + diff(M(4,6),e4)*de4 + diff(M(4,6),e5)*de5 + diff(M(4,6),e6)*de6;...
               diff(M(5,1),e1)*de1 + diff(M(5,1),e2)*de2 + diff(M(5,1),e3)*de3 + diff(M(5,1),e4)*de4 + diff(M(5,1),e5)*de5 + diff(M(5,1),e6)*de6, diff(M(5,2),e1)*de1 + diff(M(5,2),e2)*de2 + diff(M(5,2),e3)*de3 + diff(M(5,2),e4)*de4 + diff(M(5,2),e5)*de5 + diff(M(5,2),e6)*de6, diff(M(5,3),e1)*de1 + diff(M(5,3),e2)*de2 + diff(M(5,3),e3)*de3 + diff(M(5,3),e4)*de4 + diff(M(5,3),e5)*de5 + diff(M(5,3),e6)*de6, diff(M(5,4),e1)*de1 + diff(M(5,4),e2)*de2 + diff(M(5,4),e3)*de3 + diff(M(5,4),e4)*de4 + diff(M(5,4),e5)*de5 + diff(M(5,4),e6)*de6, diff(M(5,5),e1)*de1 + diff(M(5,5),e2)*de2 + diff(M(5,5),e3)*de3 + diff(M(5,5),e4)*de4 + diff(M(5,5),e5)*de5 + diff(M(5,5),e6)*de6, diff(M(5,6),e1)*de1 + diff(M(5,6),e2)*de2 + diff(M(5,6),e3)*de3 + diff(M(5,6),e4)*de4 + diff(M(5,6),e5)*de5 + diff(M(5,6),e6)*de6;...
               diff(M(6,1),e1)*de1 + diff(M(6,1),e2)*de2 + diff(M(6,1),e3)*de3 + diff(M(6,1),e4)*de4 + diff(M(6,1),e5)*de5 + diff(M(6,1),e6)*de6, diff(M(6,2),e1)*de1 + diff(M(6,2),e2)*de2 + diff(M(6,2),e3)*de3 + diff(M(6,2),e4)*de4 + diff(M(6,2),e5)*de5 + diff(M(6,2),e6)*de6, diff(M(6,3),e1)*de1 + diff(M(6,3),e2)*de2 + diff(M(6,3),e3)*de3 + diff(M(6,3),e4)*de4 + diff(M(6,3),e5)*de5 + diff(M(6,3),e6)*de6, diff(M(6,4),e1)*de1 + diff(M(6,4),e2)*de2 + diff(M(6,4),e3)*de3 + diff(M(6,4),e4)*de4 + diff(M(6,4),e5)*de5 + diff(M(6,4),e6)*de6, diff(M(6,5),e1)*de1 + diff(M(6,5),e2)*de2 + diff(M(6,5),e3)*de3 + diff(M(6,5),e4)*de4 + diff(M(6,5),e5)*de5 + diff(M(6,5),e6)*de6, diff(M(6,6),e1)*de1 + diff(M(6,6),e2)*de2 + diff(M(6,6),e3)*de3 + diff(M(6,6),e4)*de4 + diff(M(6,6),e5)*de5 + diff(M(6,6),e6)*de6]);
dMde1 = Comp_dMdei(M,e1);
dMde2 = Comp_dMdei(M,e2);
dMde3 = Comp_dMdei(M,e3);
dMde4 = Comp_dMdei(M,e4);
dMde5 = Comp_dMdei(M,e5);
dMde6 = Comp_dMdei(M,e6);
de = [de1, de2, de3, de4, de5, de6]';
dde = [dde1, dde2, dde3, dde4, dde5, dde6]';
t = [t1,t2,t3,t4,t5,t6]';
C = simplify(dM - 1/2*([de'*dMde1; de'*dMde2 ;de'*dMde3; de'*dMde4; de'*dMde5; de'*dMde6]));
%% check
simplify(t-M*dde-C*de-G)

%%
fileM = fopen('M.txt','w'); 
fprintf(fileM,'M = ...\n[%s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s];',M(1,1),M(1,2),M(1,3),M(1,4),M(1,5),M(1,6),M(2,1),M(2,2),M(2,3),M(2,4),M(2,5),M(2,6),M(3,1),M(3,2),M(3,3),M(3,4),M(3,5),M(3,6),M(4,1),M(4,2),M(4,3),M(4,4),M(4,5),M(4,6),M(5,1),M(5,2),M(5,3),M(5,4),M(5,5),M(5,6),M(6,1),M(6,2),M(6,3),M(6,4),M(6,5),M(6,6));

fileC = fopen('C.txt','w');
fprintf(fileC,'C = ...\n[%s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s];',C(1,1),C(1,2),C(1,3),C(1,4),C(1,5),C(1,6),C(2,1),C(2,2),C(2,3),C(2,4),C(2,5),C(2,6),C(3,1),C(3,2),C(3,3),C(3,4),C(3,5),C(3,6),C(4,1),C(4,2),C(4,3),C(4,4),C(4,5),C(4,6),C(5,1),C(5,2),C(5,3),C(5,4),C(5,5),C(5,6),C(6,1),C(6,2),C(6,3),C(6,4),C(6,5),C(6,6));
 
fileG = fopen('G.txt','w');
fprintf(fileG,'G = ...\n[%s;\n%s;\n%s;\n%s;\n%s;\n%s];',G(1),G(2),G(3),G(4),G(5),G(6));