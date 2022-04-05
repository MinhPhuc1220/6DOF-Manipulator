clc;
% clear all;
close all;
i=0;
step = 0.1;
circle = zeros(10/step+1,7);
for t = 0:step:10
i = i+1;
f=0.1; %hz
Px_r = 450;
Py_r = 0+150*cos(2*pi*f*t+pi/2);
Pz_r = 500+150*sin(2*pi*f*t+pi/2);
circle(i,:)=[t,Px_r,Py_r,Pz_r,0,0,0];
end
spline = circle(:,2:4)