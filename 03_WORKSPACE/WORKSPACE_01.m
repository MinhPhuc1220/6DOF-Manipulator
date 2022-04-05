%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2022/03/27
% Topic: Vẽ workspace 
% NOTE: DONE
%%
clc; clear all;close all;
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;
%tao ma tran rong
empty=[];
% ve toan bo khong gian lam viec cua robot 
i=0;
step = 30;
for the1 = -170:step:170
    for the2 = -100:step:135
        for the3 = -119:step:166
            for the4 = -190:step:190
                for the5 = -120:step:120
                    for the6 = -360:step:360
                        i=i+1;
                        Px = a1*cosd(the1) + a2*cosd(the1)*sind(the2) + d4*cosd(the1)*cosd(the2)*cosd(the3) + a3*cosd(the1)*cosd(the2)*sind(the3) + a3*cosd(the1)*cosd(the3)*sind(the2) - d4*cosd(the1)*sind(the2)*sind(the3) - d7*sind(the1)*sind(the4)*sind(the5) + d7*cosd(the1)*cosd(the2)*cosd(the3)*cosd(the5) - d7*cosd(the1)*cosd(the5)*sind(the2)*sind(the3) - d7*cosd(the1)*cosd(the2)*cosd(the4)*sind(the3)*sind(the5) - d7*cosd(the1)*cosd(the3)*cosd(the4)*sind(the2)*sind(the5);
                        Py = a1*sind(the1) + a2*sind(the1)*sind(the2) + d4*cosd(the2)*cosd(the3)*sind(the1) + a3*cosd(the2)*sind(the1)*sind(the3) + a3*cosd(the3)*sind(the1)*sind(the2) + d7*cosd(the1)*sind(the4)*sind(the5) - d4*sind(the1)*sind(the2)*sind(the3) + d7*cosd(the2)*cosd(the3)*cosd(the5)*sind(the1) - d7*cosd(the5)*sind(the1)*sind(the2)*sind(the3) - d7*cosd(the2)*cosd(the4)*sind(the1)*sind(the3)*sind(the5) - d7*cosd(the3)*cosd(the4)*sind(the1)*sind(the2)*sind(the5);
                        Pz = d1 + a2*cosd(the2) + a3*cosd(the2)*cosd(the3) - d4*cosd(the2)*sind(the3) - d4*cosd(the3)*sind(the2) - a3*sind(the2)*sind(the3) - d7*cosd(the2)*cosd(the5)*sind(the3) - d7*cosd(the3)*cosd(the5)*sind(the2) - d7*cosd(the2)*cosd(the3)*cosd(the4)*sind(the5) + d7*cosd(the4)*sind(the2)*sind(the3)*sind(the5);
                        empty(:,i)=[Px;Py;Pz];
%                         plot3(Px,Py,Pz,'b.');
%                         hold on;
                    end
                end
            end
        end
    end
end
% WORKSPACE 6DOF MANIPULATOR 3D
figure(1);
plot3(empty(1,:),empty(2,:),empty(3,:),'b.','MarkerSize',0.1);
title("3D VIEW");
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

% X-Y
figure(2);
plot(empty(1,:),empty(2,:),'b.','MarkerSize',0.1);
title("X-Y VIEW");
grid on;
xlabel('x');
ylabel('y');

% Y-Z
figure(3);
plot(empty(2,:),empty(3,:),'b.','MarkerSize',0.1);
title("Y-Z VIEW");
grid on;
xlabel('y');
ylabel('z');

% Z-X
figure(4);
plot(empty(3,:),empty(1,:),'b.','MarkerSize',0.1);
title("Z-X VIEW");
grid on;
xlabel('z');
ylabel('x');

whitebg('white')

Px_max = max(empty(1,:));
Px_min = min(empty(1,:));

Py_max = max(empty(2,:));
Py_min = min(empty(2,:));

Pz_max = max(empty(3,:));
Pz_min = min(empty(3,:));