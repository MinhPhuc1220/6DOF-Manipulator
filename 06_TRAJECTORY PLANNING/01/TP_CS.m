function C = TP_CS(P0,Pf)
% 0x: điểm đầu phương X, fx: điểm cuối phương X
% 0y: điểm đầu phương Y, fy: điểm cuối phương Y
% 0z: điểm đầu phương Y, fz: điểm cuối phương Y
% P0 = [ti; q0x; q0y; q0z; v0x; v0y; v0z]
% Pf = [tf; qfx; qfy; qfz; vfx; vfy; vfz]
% Phương trình quy hoạch quỹ đạo bậc 3: q = a0 + a1*t + a2*t^2 + a3*t^3
t0 = P0(1);
tf = Pf(1);
A = [1   t0   t0^2   t0^3;     % q0
     0   1    2*t0   3*t0^2;   % v0
     1   tf   tf^2   tf^3;     % qf
     0   1    2*tf   3*tf^2];  % vf
  
Bx = [P0(2);   P0(5);  Pf(2);  Pf(5)];  % [q0x v0x qfx vfx]
By = [P0(3);   P0(6);  Pf(3);  Pf(6)];  % [q0y v0y qfy vfy]
Bz = [P0(4);   P0(7);  Pf(4);  Pf(7)];  % [q0z v0z qfz vfz]
Cx = A\Bx;
Cy = A\By;
Cz = A\Bz;
C = [Cx(1), Cx(2),  Cx(3),  Cx(4),...   % [a0x a1x a2x a3x]
     Cy(1), Cy(2),  Cy(3),  Cy(4),...   % [a0y a1y a2y a3y]
     Cz(1), Cz(2),  Cz(3),  Cz(4)];     % [a0z a1z a2z a3z]
end