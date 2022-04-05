%% AUTHORS:
% Made by Tran Minh Phuc
% Date: 2022/03/27
% Topic: Test tính động học nghịch bằng Jacobian và plot đáp ứng từng khớp
% NOTE: 80%
clc; clear all; close all;
n=0.06;
tthe1 = zeros(1000,1);
tthe2 = zeros(1000,1);
tthe3 = zeros(1000,1);
f = zeros(1000,1);
% VI TRI EE MONG MUON
x_0_d = 400;
y_0_d = 200;
z_0_d = 100;
roll_d = pi/3;
pitch_d = pi/4;
yaw_d = 0;
% P_EE_d = [x_0_d;y_0_d;z_0_d;roll_d;pitch_d;yaw_d]; %thay doi diem mong muon
P_EE_d = FK_6DOF([0;0;0;0;pi;0])
% GIA TRI KHOI TAO CAC KHOP ROBOT
the1 = [1;1;1;1;1;1]; %thay doi goc dat ban dau the1 = [the(1);the(2);the(3);the(4);the(5);the(6)]
for i = 1:1000,
    the0 = the1;
    fx = FK_6DOF(the0) - P_EE_d; % -> 0
%     the1 = the0 - n*inv(JACOBIAN(the0))*fx;
    the1 = the0 - n*transpose(J_6DOF(the0))*inv(J_6DOF(the0)*transpose(J_6DOF(the0)))*fx;
    tthe1(i) = the0(1);
    tthe2(i) = the0(2);
    tthe3(i) = the0(3);
    f(i) = fx(3);
    P = FK_6DOF(the0)
    fx
end
%%
figure(1)
plot(tthe1,'linewidth',2)
figure(2)
plot(tthe2,'linewidth',2)
figure(3)
plot(tthe3,'linewidth',2)
figure(4)
plot(f,'linewidth',2)