function out = inertia(Ixx, Iyy, Izz, Px, Py, Pz)
% Px = Ixy
% Py = Iyz
% Pz = Ixz
out = ...
[Ixx -Px -Pz;
 -Px Iyy -Py;
 -Pz -Py Izz];