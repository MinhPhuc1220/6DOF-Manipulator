function out = FK_R6Dof(the)
l1 = 335;l3 = 270;l4 = 90;l5 = 315;l6 = 40;l7 = 40;
d1 = 75;

the1 = the(1);the2 = the(2);the3 = the(3);
the4 = the(4); the5 = the(5); the6 = the(6);

T = transform(the);
r11=  T(1,1); r12 = T(1,2); r13 = T(1,3);
r21=  T(2,1); r22 = T(2,2); r23 = T(2,3);
r31=  T(3,1); r32 = T(3,2); r33 = T(3,3);

pitch = atan2(-r31,sqrt(r11^2 + r21^2));
yaw = atan2(r21/cos(pitch),r11/cos(pitch));
roll = atan2(r32/cos(pitch),r33/cos(pitch));


x = cos(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)) - (l6 + l7)*(sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) - sin(the2 + the3)*cos(the1)*cos(the5));
y = (l6 + l7)*(sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1)) + sin(the1)*(d1 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2));
z = l4*sin(the2 + the3) - l5*cos(the2 + the3) + l3*sin(the2) - (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7);

out = [x;y;z;roll;pitch;yaw];
