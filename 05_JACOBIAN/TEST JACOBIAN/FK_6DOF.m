function out = FK_6DOF(the)
the1 = the(1);
the2 = the(2);
the3 = the(3);
the4 = the(4);
the5 = the(5);
the6 = the(6);
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;
T_0_EE = ...
[ cos(the6)*(cos(the5)*sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*sin(the5) + cos(the1)*cos(the2)*cos(the4)*cos(the5)*sin(the3) + cos(the1)*cos(the3)*cos(the4)*cos(the5)*sin(the2)) - sin(the6)*(cos(the1)*cos(the2)*sin(the3)*sin(the4) - cos(the4)*sin(the1) + cos(the1)*cos(the3)*sin(the2)*sin(the4)), - cos(the6)*(cos(the1)*cos(the2)*sin(the3)*sin(the4) - cos(the4)*sin(the1) + cos(the1)*cos(the3)*sin(the2)*sin(the4)) - sin(the6)*(cos(the5)*sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*sin(the5) + cos(the1)*cos(the2)*cos(the4)*cos(the5)*sin(the3) + cos(the1)*cos(the3)*cos(the4)*cos(the5)*sin(the2)), cos(the2 + the3)*cos(the1)*cos(the5) - sin(the5)*(sin(the1)*sin(the4) + cos(the1)*cos(the2)*cos(the4)*sin(the3) + cos(the1)*cos(the3)*cos(the4)*sin(the2)), a1*cos(the1) + a2*cos(the1)*sin(the2) + d4*cos(the1)*cos(the2)*cos(the3) + a3*cos(the1)*cos(the2)*sin(the3) + a3*cos(the1)*cos(the3)*sin(the2) - d4*cos(the1)*sin(the2)*sin(the3) - d7*sin(the1)*sin(the4)*sin(the5) + d7*cos(the1)*cos(the2)*cos(the3)*cos(the5) - d7*cos(the1)*cos(the5)*sin(the2)*sin(the3) - d7*cos(the1)*cos(the2)*cos(the4)*sin(the3)*sin(the5) - d7*cos(the1)*cos(the3)*cos(the4)*sin(the2)*sin(the5);
  cos(the6)*(cos(the2 + the3)*sin(the1)*sin(the5) - cos(the1)*cos(the5)*sin(the4) + cos(the2)*cos(the4)*cos(the5)*sin(the1)*sin(the3) + cos(the3)*cos(the4)*cos(the5)*sin(the1)*sin(the2)) - sin(the6)*(cos(the1)*cos(the4) + cos(the2)*sin(the1)*sin(the3)*sin(the4) + cos(the3)*sin(the1)*sin(the2)*sin(the4)), - cos(the6)*(cos(the1)*cos(the4) + cos(the2)*sin(the1)*sin(the3)*sin(the4) + cos(the3)*sin(the1)*sin(the2)*sin(the4)) - sin(the6)*(cos(the2 + the3)*sin(the1)*sin(the5) - cos(the1)*cos(the5)*sin(the4) + cos(the2)*cos(the4)*cos(the5)*sin(the1)*sin(the3) + cos(the3)*cos(the4)*cos(the5)*sin(the1)*sin(the2)), cos(the2 + the3)*cos(the5)*sin(the1) - sin(the5)*(cos(the2)*cos(the4)*sin(the1)*sin(the3) - cos(the1)*sin(the4) + cos(the3)*cos(the4)*sin(the1)*sin(the2)), a1*sin(the1) + a2*sin(the1)*sin(the2) + d4*cos(the2)*cos(the3)*sin(the1) + a3*cos(the2)*sin(the1)*sin(the3) + a3*cos(the3)*sin(the1)*sin(the2) + d7*cos(the1)*sin(the4)*sin(the5) - d4*sin(the1)*sin(the2)*sin(the3) + d7*cos(the2)*cos(the3)*cos(the5)*sin(the1) - d7*cos(the5)*sin(the1)*sin(the2)*sin(the3) - d7*cos(the2)*cos(the4)*sin(the1)*sin(the3)*sin(the5) - d7*cos(the3)*cos(the4)*sin(the1)*sin(the2)*sin(the5);
                                                                                                                                                                                          - cos(the6)*(sin(the2 + the3)*sin(the5) - cos(the2 + the3)*cos(the4)*cos(the5)) - cos(the2 + the3)*sin(the4)*sin(the6),                                                                                                                                                                                             sin(the6)*(sin(the2 + the3)*sin(the5) - cos(the2 + the3)*cos(the4)*cos(the5)) - cos(the2 + the3)*cos(the6)*sin(the4),                                                                                        - sin(the2 + the3)*cos(the5) - cos(the2 + the3)*cos(the4)*sin(the5),                                                                                                                                        d1 + a2*cos(the2) + a3*cos(the2)*cos(the3) - d4*cos(the2)*sin(the3) - d4*cos(the3)*sin(the2) - a3*sin(the2)*sin(the3) - d7*cos(the2)*cos(the5)*sin(the3) - d7*cos(the3)*cos(the5)*sin(the2) - d7*cos(the2)*cos(the3)*cos(the4)*sin(the5) + d7*cos(the4)*sin(the2)*sin(the3)*sin(the5);
                                                                                                                                                                                                                                                                                                               0,                                                                                                                                                                                                                                                                                                                0,                                                                                                                                                          0,                                                                                                                                                                                                                                                                                                                                                                                                                            1];
 
r11 = T_0_EE(1,1);
r21 = T_0_EE(2,1);
r31 = T_0_EE(3,1);
r12 = T_0_EE(1,2);
r22 = T_0_EE(2,2);
r32 = T_0_EE(3,2);
r13 = T_0_EE(1,3);
r23 = T_0_EE(2,3);
r33 = T_0_EE(3,3);
px = T_0_EE(1,4);
py = T_0_EE(2,4);
pz = T_0_EE(3,4);
pitch = atan2(-r31,sqrt(r11^2+r21^2));
yaw = atan2(r21/cos(pitch),r11/cos(pitch));
roll = atan2(r32/cos(pitch),r33/cos(pitch));
out = [px;py;pz;roll;pitch;yaw];
end