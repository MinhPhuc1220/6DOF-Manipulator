function [T,R,invR,P] = FKRobot2021( a,alpha,d,theta )
T=simplify([cos(theta)            -sin(theta)           0          a;...
            sin(theta)*cos(alpha) cos(theta)*cos(alpha) -sin(alpha) -sin(alpha)*d;...
            sin(theta)*sin(alpha) cos(theta)*sin(alpha) cos(alpha)  cos(alpha)*d;...
            0                     0                     0            1]);
R=T(1:3,1:3);
invR=R.';
P=T(1:3,4);
end