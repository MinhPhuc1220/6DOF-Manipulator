%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2022/03/27
% Topic: Vẽ tất cả điểm kỳ dị nằm trong không gian làm việc 
% NOTE: 80%
%%
clc; clear all;close all;
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;
%tao ma tran rong
empty=[];
% ve toan bo khong gian lam viec cua robot 
i=0;
step = 20;
for the1 = -170:step:170
    for the2 = -100:step:135
        for the3 = -119:step:166
            for the4 = -190:step:190
                for the5 = -120:step:120
%                     for the6 = -360:step:360
                        k1 = round(a1 + d4*cosd(the2 + the3) + a3*sind(the2 + the3) + a2*sind(the2),6);
                        k2 = round(d4*cosd(the3) + a3*sind(the3),6);
                        k3 = round(sind(the5),6);
                        if k1==0 || k2==0.05 || k3==0
                            i=i+1;
                            Px = a1*cosd(the1) + a2*cosd(the1)*sind(the2) + d4*cosd(the1)*cosd(the2)*cosd(the3) + a3*cosd(the1)*cosd(the2)*sind(the3) + a3*cosd(the1)*cosd(the3)*sind(the2) - d4*cosd(the1)*sind(the2)*sind(the3) - d7*sind(the1)*sind(the4)*sind(the5) + d7*cosd(the1)*cosd(the2)*cosd(the3)*cosd(the5) - d7*cosd(the1)*cosd(the5)*sind(the2)*sind(the3) - d7*cosd(the1)*cosd(the2)*cosd(the4)*sind(the3)*sind(the5) - d7*cosd(the1)*cosd(the3)*cosd(the4)*sind(the2)*sind(the5);
                            Py = a1*sind(the1) + a2*sind(the1)*sind(the2) + d4*cosd(the2)*cosd(the3)*sind(the1) + a3*cosd(the2)*sind(the1)*sind(the3) + a3*cosd(the3)*sind(the1)*sind(the2) + d7*cosd(the1)*sind(the4)*sind(the5) - d4*sind(the1)*sind(the2)*sind(the3) + d7*cosd(the2)*cosd(the3)*cosd(the5)*sind(the1) - d7*cosd(the5)*sind(the1)*sind(the2)*sind(the3) - d7*cosd(the2)*cosd(the4)*sind(the1)*sind(the3)*sind(the5) - d7*cosd(the3)*cosd(the4)*sind(the1)*sind(the2)*sind(the5);
                            Pz = d1 + a2*cosd(the2) + a3*cosd(the2)*cosd(the3) - d4*cosd(the2)*sind(the3) - d4*cosd(the3)*sind(the2) - a3*sind(the2)*sind(the3) - d7*cosd(the2)*cosd(the5)*sind(the3) - d7*cosd(the3)*cosd(the5)*sind(the2) - d7*cosd(the2)*cosd(the3)*cosd(the4)*sind(the5) + d7*cosd(the4)*sind(the2)*sind(the3)*sind(the5);
                            empty(:,i)=[Px;Py;Pz];
                        end
%                         plot3(Px,Py,Pz,'b.');
%                         hold on;
%                     end
                end
            end
        end
    end
end
figure(1);
plot3(empty(1,:),empty(2,:),empty(3,:),'b.','MarkerSize',0.1);
title("WORKSPACE 6DOF MANIPULATOR");
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
whitebg('white')