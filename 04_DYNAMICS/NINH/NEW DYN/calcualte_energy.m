clc; 
syms m1 m2 m3 m4 m5 m6 g ...
    Ixx1 Iyy1 Izz1 IPx1 IPy1 IPz1 ...
    Ixx2 Iyy2 Izz2 IPx2 IPy2 IPz2 ...
    Ixx3 Iyy3 Izz3 IPx3 IPy3 IPz3 ...
    Ixx4 Iyy4 Izz4 IPx4 IPy4 IPz4 ...
    Ixx5 Iyy5 Izz5 IPx5 IPy5 IPz5 ...
    Ixx6 Iyy6 Izz6 IPx6 IPy6 IPz6 ...
    I1xx I1yy I1zz I2xx I2yy I2zz ...
    I3xx I3yy I3zz I4xx I4yy I4zz ...
    I5xx I5yy I5zz I6xx I6yy I6zz ...
    I1xy I1yz I1zx I2xy I2yz I2zx ...
    I3xy I3yz I3zx I4xy I4yz I4zx ...
    I5xy I5yz I5zx I6xy I6yz I6zx ;
gi = [0 0 g];
%% Inertia
% Ic1 = inertia(Ixx1, Iyy1, Izz1, IPx1, IPy1, IPz1);
% Ic2 = inertia(Ixx2, Iyy2, Izz2, IPx2, IPy2, IPz2);
% Ic3 = inertia(Ixx3, Iyy3, Izz3, IPx3, IPy3, IPz3);
% Ic4 = inertia(Ixx4, Iyy4, Izz4, IPx4, IPy4, IPz4);
% Ic5 = inertia(Ixx5, Iyy5, Izz5, IPx5, IPy5, IPz5);
% Ic6 = inertia(Ixx6, Iyy6, Izz6, IPx6, IPy6, IPz6);
Ic1 = inertia(I1xx, I1yy, I1zz, I1xy, I1yz, I1zx);
Ic2 = inertia(I2xx, I2yy, I2zz, I2xy, I2yz, I2zx);
Ic3 = inertia(I3xx, I3yy, I3zz, I3xy, I3yz, I3zx);
Ic4 = inertia(I4xx, I4yy, I4zz, I4xy, I4yz, I4zx);
Ic5 = inertia(I5xx, I5yy, I5zz, I5xy, I5yz, I5zx);
Ic6 = inertia(I6xx, I6yy, I6zz, I6xy, I6yz, I6zx);
%% velocity
V_0_1 = simplify(diff(P_ic(:,1),the1)*the1_dot + diff(P_ic(:,1),the2)*the2_dot + diff(P_ic(:,1),the3)*the3_dot + diff(P_ic(:,1),the4)*the4_dot + diff(P_ic(:,1),the5)*the5_dot + diff(P_ic(:,1),the6)*the6_dot)

V_0_2 = simplify(diff(P_ic(:,2),the1)*the1_dot + diff(P_ic(:,2),the2)*the2_dot + diff(P_ic(:,2),the3)*the3_dot + diff(P_ic(:,2),the4)*the4_dot + diff(P_ic(:,2),the5)*the5_dot + diff(P_ic(:,2),the6)*the6_dot)

V_0_3 = simplify(diff(P_ic(:,3),the1)*the1_dot + diff(P_ic(:,3),the2)*the2_dot + diff(P_ic(:,3),the3)*the3_dot + diff(P_ic(:,3),the4)*the4_dot + diff(P_ic(:,3),the5)*the5_dot + diff(P_ic(:,3),the6)*the6_dot)

V_0_4 = simplify(diff(P_ic(:,4),the1)*the1_dot + diff(P_ic(:,4),the2)*the2_dot + diff(P_ic(:,4),the3)*the3_dot + diff(P_ic(:,4),the4)*the4_dot + diff(P_ic(:,4),the5)*the5_dot + diff(P_ic(:,4),the6)*the6_dot)

V_0_5 = simplify(diff(P_ic(:,5),the1)*the1_dot + diff(P_ic(:,5),the2)*the2_dot + diff(P_ic(:,5),the3)*the3_dot + diff(P_ic(:,5),the4)*the4_dot + diff(P_ic(:,5),the5)*the5_dot + diff(P_ic(:,5),the6)*the6_dot)

V_0_6 = simplify(diff(P_ic(:,6),the1)*the1_dot + diff(P_ic(:,6),the2)*the2_dot + diff(P_ic(:,6),the3)*the3_dot + diff(P_ic(:,6),the4)*the4_dot + diff(P_ic(:,6),the5)*the5_dot + diff(P_ic(:,6),the6)*the6_dot)

%% Kinetic Energy
v1 = transpose(V_0_1)*V_0_1;

v2 = transpose(V_0_2)*V_0_2;

v3 = transpose(V_0_3)*V_0_3;

v4 = transpose(V_0_4)*V_0_4;

v5 = transpose(V_0_5)*V_0_5;

v6 = transpose(V_0_6)*V_0_6;

w1 = transpose(w_i_i(:,2))*Ic1*w_i_i(:,2);
w2 = transpose(w_i_i(:,3))*Ic2*w_i_i(:,3);
w3 = transpose(w_i_i(:,4))*Ic3*w_i_i(:,4);
w4 = transpose(w_i_i(:,5))*Ic4*w_i_i(:,5);
w5 = transpose(w_i_i(:,6))*Ic5*w_i_i(:,6);
w6 = transpose(w_i_i(:,7))*Ic6*w_i_i(:,7);

K = 0.5*(m1*v1 + m2*v2 + m3*v3 + m4*v4 + m5*v5 + m6*v6) + 0.5*(w1 + w2 + w3 + w4 + w5 + w6)
%% Potential Energy
U = -simplify((m1*gi*P_ic(:,1) + m2*gi*P_ic(:,2) + m3*gi*P_ic(:,3) + m4*gi*P_ic(:,4) + m5*gi*P_ic(:,5) + m6*gi*P_ic(:,6)))

%% Lagrange Equation
L = (K - U)
%%
thedd = [the1 the2 the3 the4 the5 the6 the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot];
ddthe = diag([the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot]);
dthe = diag([the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot the1_2dot the2_2dot the3_2dot the4_2dot the5_2dot the6_2dot]);
%%
dL_dthe1 = diff(L,the1)
dL_dthe2 = diff(L,the2)
dL_dthe3 = diff(L,the3)
dL_dthe4 = diff(L,the4)
dL_dthe5 = diff(L,the5)
dL_dthe6 = diff(L,the6)
%%
dL_ddthe1 = diff(L,the1_dot)

dL_ddthe2 = diff(L,the2_dot)

dL_ddthe3 = diff(L,the3_dot)

dL_ddthe4 = diff(L,the4_dot)

dL_ddthe5 = diff(L,the5_dot)

dL_ddthe6 = diff(L,the6_dot)
%%
dL_ddthe1_dt = sum(dthe*gradient(dL_ddthe1,thedd))

dL_ddthe2_dt = sum(dthe*gradient(dL_ddthe2,thedd))

dL_ddthe3_dt = sum(dthe*gradient(dL_ddthe3,thedd))

dL_ddthe4_dt = sum(dthe*gradient(dL_ddthe4,thedd))

dL_ddthe5_dt = sum(dthe*gradient(dL_ddthe5,thedd))

dL_ddthe6_dt = sum(dthe*gradient(dL_ddthe6,thedd))

%% Computed Torque
tau1 = simplify(dL_ddthe1_dt - dL_dthe1)
tau2 = simplify(dL_ddthe2_dt - dL_dthe2)
tau3 = simplify(dL_ddthe3_dt - dL_dthe3)
tau4 = simplify(dL_ddthe4_dt - dL_dthe4)
tau5 = simplify(dL_ddthe5_dt - dL_dthe5)
tau6 = simplify(dL_ddthe6_dt - dL_dthe6)
%% Computed Inertia Matrix
M11 = (diff(tau1,the1_2dot))
M22 = (diff(tau2,the2_2dot))
M33 = (diff(tau3,the3_2dot))
M44 = (diff(tau4,the4_2dot))
M55 = (diff(tau5,the5_2dot))
M66 = (diff(tau6,the6_2dot))

%%
M12 = (diff(tau1,the2_2dot))
M13 = (diff(tau1,the3_2dot))
M14 = (diff(tau1,the4_2dot))
M15 = (diff(tau1,the5_2dot))
M16 = (diff(tau1,the6_2dot))

%%
M21 = (diff(tau2,the1_2dot))
M23 = (diff(tau2,the3_2dot))
M24 = (diff(tau2,the4_2dot))
M25 = (diff(tau2,the5_2dot))
M26 = (diff(tau2,the6_2dot))

%%
M31 = (diff(tau3,the1_2dot))
M32 = (diff(tau3,the2_2dot))
M34 = (diff(tau3,the4_2dot))
M35 = (diff(tau3,the5_2dot))
M36 = (diff(tau3,the6_2dot))

%%
M41 = (diff(tau4,the1_2dot))
M42 = (diff(tau4,the2_2dot))
M43 = (diff(tau4,the3_2dot))
M45 = (diff(tau4,the5_2dot))
M46 = (diff(tau4,the6_2dot))

%%
M51 = (diff(tau5,the1_2dot))
M52 = (diff(tau5,the2_2dot))
M53 = (diff(tau5,the3_2dot))
M54 = (diff(tau5,the4_2dot))
M56 = (diff(tau5,the6_2dot))

%%
M61 = (diff(tau6,the1_2dot))
M62 = (diff(tau6,the2_2dot))
M63 = (diff(tau6,the3_2dot))
M64 = (diff(tau6,the4_2dot))
M65 = (diff(tau6,the5_2dot))
%% Computed Gravity Matrix
G1 = (diff(U,the1))
G2 = (diff(U,the2))
G3 = (diff(U,the3))
G4 = (diff(U,the4))
G5 = (diff(U,the5))
G6 = (diff(U,the6))
%% Mass Matrix and Gravity Vector
M = simplify([M11 ,M12 ,M13 ,M14 ,M15, M16;
              M21 ,M22 ,M23 ,M24 ,M25, M26;
              M31 ,M32 ,M33 ,M34 ,M35, M36;
              M41 ,M42 ,M43 ,M44 ,M45, M46;
              M51 ,M52 ,M53 ,M54 ,M55, M56;
              M61 ,M62 ,M63 ,M64 ,M65, M66])
G = simplify([G1; G2; G3; G4; G5; G6])

%% Computed Coriolis Matrix
dM = simplify([sum(ddthe*gradient(M(1,1), thedd(1:6))) ,sum(ddthe*gradient(M(1,2), thedd(1:6))) ,sum(ddthe*gradient(M(1,3), thedd(1:6))) ,sum(ddthe*gradient(M(1,4), thedd(1:6))) ,sum(ddthe*gradient(M(1,5), thedd(1:6))), sum(ddthe*gradient(M(1,6), thedd(1:6)));
               sum(ddthe*gradient(M(2,1), thedd(1:6))) ,sum(ddthe*gradient(M(2,2), thedd(1:6))) ,sum(ddthe*gradient(M(2,3), thedd(1:6))) ,sum(ddthe*gradient(M(2,4), thedd(1:6))) ,sum(ddthe*gradient(M(2,5), thedd(1:6))), sum(ddthe*gradient(M(2,6), thedd(1:6)));
               sum(ddthe*gradient(M(3,1), thedd(1:6))) ,sum(ddthe*gradient(M(3,2), thedd(1:6))) ,sum(ddthe*gradient(M(3,3), thedd(1:6))) ,sum(ddthe*gradient(M(3,4), thedd(1:6))) ,sum(ddthe*gradient(M(3,5), thedd(1:6))), sum(ddthe*gradient(M(3,6), thedd(1:6)));
               sum(ddthe*gradient(M(4,1), thedd(1:6))) ,sum(ddthe*gradient(M(4,2), thedd(1:6))) ,sum(ddthe*gradient(M(4,3), thedd(1:6))) ,sum(ddthe*gradient(M(4,4), thedd(1:6))) ,sum(ddthe*gradient(M(4,5), thedd(1:6))), sum(ddthe*gradient(M(4,6), thedd(1:6)));
               sum(ddthe*gradient(M(5,1), thedd(1:6))) ,sum(ddthe*gradient(M(5,2), thedd(1:6))) ,sum(ddthe*gradient(M(5,3), thedd(1:6))) ,sum(ddthe*gradient(M(5,4), thedd(1:6))) ,sum(ddthe*gradient(M(5,5), thedd(1:6))), sum(ddthe*gradient(M(5,6), thedd(1:6)));
               sum(ddthe*gradient(M(6,1), thedd(1:6))) ,sum(ddthe*gradient(M(6,2), thedd(1:6))) ,sum(ddthe*gradient(M(6,3), thedd(1:6))) ,sum(ddthe*gradient(M(6,4), thedd(1:6))) ,sum(ddthe*gradient(M(6,5), thedd(1:6))), sum(ddthe*gradient(M(6,6), thedd(1:6)))])
           
% dMthe1 = Com_dMthei(M,the1); dMthe2 = Com_dMthei(M,the2); dMthe3 = Com_dMthei(M,the3); 
% dMthe4 = Com_dMthei(M,the4); dMthe5 = Com_dMthei(M,the5); dMthe6 = Com_dMthei(M,the6);
dei = transpose([the1_dot the2_dot the3_dot the4_dot the5_dot the6_dot]);
ddei = transpose([the1_2dot the2_2dot the3_2dot the4_2dot the5_2dot the6_2dot]);
t = transpose([tau1, tau2, tau3, tau4, tau5, tau6]);
the = [the1 the2 the3 the4 the5 the6];
dMthe1 = Com_dMthei(M,the,1); dMthe2 = Com_dMthei(M,the,2); dMthe3 = Com_dMthei(M,the,3); 
dMthe4 = Com_dMthei(M,the,4); dMthe5 = Com_dMthei(M,the,5); dMthe6 = Com_dMthei(M,the,6); 
C = simplify([dei.'*dMthe1;dei.'*dMthe2;dei.'*dMthe3;...
              dei.'*dMthe4;dei.'*dMthe5;dei.'*dMthe6])
% C = simplify(dM - 1/2*([transpose(dei)*dMthe1;transpose(dei)*dMthe2;transpose(dei)*dMthe3;transpose(dei)*dMthe4;transpose(dei)*dMthe5;transpose(dei)*dMthe6]));

%% Check
simplify(t - M*ddei - C*dei - G)
xi = [1;2;1;50;1;-6]
skew = simplify(xi.'*(dM- 2*C)*xi)
%%
filedM = fopen('dM.txt','w'); 
fprintf(filedM,'dM = ...\n[%s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s];\n',dM(1,1),dM(1,2),dM(1,3),dM(1,4),dM(1,5),dM(1,6),dM(2,1),dM(2,2),dM(2,3),dM(2,4),dM(2,5),dM(2,6),dM(3,1),dM(3,2),dM(3,3),dM(3,4),dM(3,5),dM(3,6),dM(4,1),dM(4,2),dM(4,3),dM(4,4),dM(4,5),dM(4,6),dM(5,1),dM(5,2),dM(5,3),dM(5,4),dM(5,5),dM(5,6),dM(6,1),dM(6,2),dM(6,3),dM(6,4),dM(6,5),dM(6,6));

fileM = fopen('M.txt','w'); 
fprintf(fileM,'M = ...\n[%s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s];\n',M(1,1),M(1,2),M(1,3),M(1,4),M(1,5),M(1,6),M(2,1),M(2,2),M(2,3),M(2,4),M(2,5),M(2,6),M(3,1),M(3,2),M(3,3),M(3,4),M(3,5),M(3,6),M(4,1),M(4,2),M(4,3),M(4,4),M(4,5),M(4,6),M(5,1),M(5,2),M(5,3),M(5,4),M(5,5),M(5,6),M(6,1),M(6,2),M(6,3),M(6,4),M(6,5),M(6,6));

fileC = fopen('C.txt','w');
fprintf(fileC,'C = ...\n[%s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s;\n %s,%s,%s,%s,%s,%s];\n',C(1,1),C(1,2),C(1,3),C(1,4),C(1,5),C(1,6),C(2,1),C(2,2),C(2,3),C(2,4),C(2,5),C(2,6),C(3,1),C(3,2),C(3,3),C(3,4),C(3,5),C(3,6),C(4,1),C(4,2),C(4,3),C(4,4),C(4,5),C(4,6),C(5,1),C(5,2),C(5,3),C(5,4),C(5,5),C(5,6),C(6,1),C(6,2),C(6,3),C(6,4),C(6,5),C(6,6));

fileG = fopen('G.txt','w');
fprintf(fileG,'G=...\n[%s;\n%s;\n%s;\n%s;\n%s;\n%s];\n',G1,G2,G3,G4,G5,G6);
%% 
filetau = fopen('tau.txt','w');
fprintf(filetau,'tau =...\n[%s;\n%s;\n%s;\n%s;\n%s;\n%s];',tau1,tau2,tau3,tau4,tau5,tau6);