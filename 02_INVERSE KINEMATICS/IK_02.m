%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2021/09/26
% Topic: Inverse Kinematics Solution and Optimization of 6DOF Manipulator
% NOTE: Final
clc;
clear all;
close all;
%% INTIAL VALUE
% a1=35; a2=125; a3=-5.4; d1=75; d4=150; d7=30.3;
a1=75; a2=270; a3=90; d1=335; d4=295; d7=80;
k1=0.3; k2=0.2; k3=0.2; k4=0.1; k5=0.1; k6=0.1;
K = [k1 k2 k3 k4 k5 k6];
E=[]; %mang dong
the = zeros(8,6);
m=0;

%% EXAMPLE:

% From random value
%y = roll, b = pitch, a = yaw;
px = 450; py = 0 ; pz = 695;
yaw = 0; pitch = -pi/2; roll = 0;
r11 = cos(yaw)*cos(pitch);
r21 = sin(yaw)*cos(pitch);
r31 = -sin(pitch);
r12 = cos(yaw)*sin(pitch)*sin(roll) - sin(yaw)*cos(roll);
r22 = sin(yaw)*sin(pitch)*sin(roll) + cos(yaw)*cos(roll);
r32 = cos(pitch)*sin(roll);
r13 = cos(yaw)*sin(pitch)*cos(roll) + sin(yaw)*sin(roll);
r23 = sin(yaw)*sin(pitch)*cos(roll) - cos(yaw)*sin(roll);
r33 = cos(pitch)*cos(roll);

% % From Forward Kinematics
% Tested 03:
% the1_d = 0.0000; the2_d = -0.1728; the3_d = 0.8025; the4_d = -3.1416; the5_d = 0; the6_d = 0.5236; 
% [r11,r21,r31,r12,r22,r32,r13,r23,r33,px,py,pz] = FK_6DOF(the1_d,the2_d,the3_d,the4_d,the5_d,the6_d);
% O_intial = [r11 r12 r13;
%             r21 r22 r23;
%             r31 r32 r33];
% pitch = atan2(-r31,sqrt(r11^2+r21^2));
% yaw = atan2(r21/cos(pitch),r11/cos(pitch));
% roll = atan2(r32/cos(pitch),r33/cos(pitch));

% Show in Command Window
fprintf("Intial Value:\n\n");
fprintf("Px = %.1f, Py = %.1f, Pz = %.1f, Yaw = %.4f, Pitch = %.4f, Roll = %.4f\n",px,py,pz,yaw,pitch,roll);
disp('----------------------------------------------------------------------------')
%% INVERSE KINEMATICS

% basic_01: a*cos(x) + b*sin(x) = d
% basic_02: a*cos(x) - b*sin(x) = c ; b*cos(x) + a*sin(x) = d

a_1 = py - r23*d7;
b_1 = - px + r13*d7;
d_1 = 0;
the1 = basic_01(a_1,b_1,d_1);

for i = 1:2
    u = cos(the1(i))*(px-d7*r13) + sin(the1(i))*(py-r23*d7) - a1;
    v = pz - d1 - r33*d7;
    a_2 = v;
    b_2 = u;
    d_2 = (a3^2+d4^2-u^2-v^2-a2^2)/(-2*a2);
    the2 = basic_01(a_2,b_2,d_2);
    
    for j = 1:2
        a_3 = a3;
        b_3 = d4;
        c_3 = u*sin(the2(j)) + v*cos(the2(j)) - a2;
        d_3 = u*cos(the2(j)) - v*sin(the2(j));
        the3 = basic_02(a_3,b_3,c_3,d_3);
        
        c5 = (r13*cos(the1(i))*cos(the2(j)) - r33*sin(the2(j)) + r23*cos(the2(j))*sin(the1(i)))*cos(the3) - (r33*cos(the2(j)) + r13*cos(the1(i))*sin(the2(j)) + r23*sin(the1(i))*sin(the2(j)))*sin(the3);
        the5 = basic_01(1,0,c5);
        
        for k = 1:2
            m=m+1;
            
            s4 = (r23*cos(the1(i)) - r13*sin(the1(i)))/(sin(the5(k)));
            c4 = (r33*cos(the2(j)) + r13*cos(the1(i))*sin(the2(j)) + r23*sin(the1(i))*sin(the2(j)) + sin(the3)*cos(the5(k))) / (-cos(the3)*sin(the5(k)));
            the4 = atan2(s4,c4);
            
            a_6 = r21*cos(the1(i)) - r11*sin(the1(i));
            b_6 = r22*cos(the1(i)) - r12*sin(the1(i));
            c_6 = -sin(the4)*cos(the5(k));
            d_6 = cos(the4);
            the6 = basic_02(a_6,b_6,c_6,-d_6);
            
            fprintf("Tested %02d:\n\n", m);
            fprintf("The1 = %.4f, The2 = %.4f, The3 = %.4f, The4 = %.4f, The5 = %.4f, The6 = %.4f\n\n", the1(i),the2(j),the3,the4,the5(k),the6);
            
            % Find End-Effector Position and Orientation from angles
            [r11_,r21_,r31_,r12_,r22_,r32_,r13_,r23_,r33_,px_,py_,pz_] = FK_6DOF(the1(i),the2(j),the3,the4,the5(k),the6);
            O_test = [r11_ r12_ r13_;
                      r21_ r22_ r23_;
                      r31_ r32_ r33_];
            pitch_ = atan2(-r31_,sqrt(r11_^2+r21_^2));
            if pitch_== pi/2
                yaw_ = 0;
                roll_ = atan2(r12_,r22_);
            elseif pitch_== -pi/2
                yaw_ = 0;
                roll_ = -atan2(r12_,r22_) ;     
            else
                yaw_ = atan2(r21_/cos(pitch_),r11_/cos(pitch_));
                roll_ = atan2(r32_/cos(pitch_),r33_/cos(pitch_));
            end
            fprintf("Px = %.1f, Py = %.1f, Pz = %.1f, Yaw = %.4f, Pitch = %.4f, Roll = %.4f\n",px_,py_,pz_,yaw_,pitch_,roll_);
%             thet = [the1(i)^2;the2(j)^2;the3^2;the4^2;the5(k)^2;the6^2];
%             err = K*thet;
%             E(m) = err;
%             the(m,:)=[the1(i),the2(j),the3,the4,the5(k),the6];
%             fprintf("err%1d = %.4f\n",m,err)
            disp('--------------------------------------------------------------------');
        end
    end
end

%% OPTIMIZATION OF IKs SOLUTION
% for i=1:8
%     if E(i)==min(E)
%         fprintf("Optimization of IKs Solution:\n\n");
%         fprintf("Minimum error is err%1d = %.4f\n\n",i,min(E));
%         fprintf("The1 = %.4f, The2 = %.4f, The3 = %.4f, The4 = %.4f, The5 = %.4f, The6 = %.4f\n", the(i,1),the(i,2),the(i,3),the(i,4),the(i,5),the(i,6));
% %         the(i,:);
% %         min(E);
%     end
% end

