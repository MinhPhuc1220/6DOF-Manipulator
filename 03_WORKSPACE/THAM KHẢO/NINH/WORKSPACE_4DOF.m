clc; clear all; close all;

emtry1 = [];
t=0;
l1 = 335;l3 = 270;l4 = 90;l5 = 315;l6 = 40;l7 = 40;
d2 = 75;
the1 = 0;
the2 = 0;
the3 = 0;
the4 = 0;
the5 = 0;
the6 = 0;
step = 1;
for the1 = -170:step:170
    for the2 = -45:step:150
        for the3 = -166:step:119
            for the4 = -190:38:190
                for the5 = -120:40:120
                    if(det(Jac_R6Dof([the1,the2,the3,the4,the5,the6])) == 0)
                        t=t+1;
                        x = cos(the1)*(d2 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2)) - (l6 + l7)*(sin(the5)*(sin(the1)*sin(the4) + cos(the2 + the3)*cos(the1)*cos(the4)) - sin(the2 + the3)*cos(the1)*cos(the5));
                        y = (l6 + l7)*(sin(the5)*(cos(the1)*sin(the4) - cos(the2 + the3)*cos(the4)*sin(the1)) + sin(the2 + the3)*cos(the5)*sin(the1)) + sin(the1)*(d2 + l4*cos(the2 + the3) + l5*sin(the2 + the3) + l3*cos(the2));
                        z = l4*sin(the2 + the3) - l5*cos(the2 + the3) + l3*sin(the2) - (cos(the2 + the3)*cos(the5) + sin(the2 + the3)*cos(the4)*sin(the5))*(l6 + l7);

                        emtry1(:,t) = [x;y;z];
                    end
                end
            end
        end
    end
end
figure(1);
plot3(emtry1(1,:),emtry1(2,:),emtry1(3,:),'b.','MarkerSize',3);
title("Case 1");
grid on;
xlim([-750 750]);
ylim([-750 750]);
zlim([-750 750]);