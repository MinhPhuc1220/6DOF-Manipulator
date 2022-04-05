function C = TP_JS(P0,Pf)
% 01: điểm đầu khớp 1, f1: điểm cuối khớp 1
% 02: điểm đầu khớp 2, f2: điểm cuối khớp 2
% 03: điểm đầu khớp 3, f3: điểm cuối khớp 3
% 04: điểm đầu khớp 4, f4: điểm cuối khớp 4
% 05: điểm đầu khớp 5, f5: điểm cuối khớp 5
% 06: điểm đầu khớp 6, f6: điểm cuối khớp 6
% the0 = [ti; q01; q02; q03; q04; q05; q06; v01; v02; v03; v04; v05; v06]
% thef = [tf; qf1; qf2; qf3; q04; q05; q06; vf1; v02; v03; v04; v05; v06]
% Phương trình quy hoạch quỹ đạo bậc 3: q = a0 + a1*t + a2*t^2 + a3*t^3
t0 = P0(1);
tf = Pf(1);
A = [1   t0   t0^2   t0^3;     % q0
     0   1    2*t0   3*t0^2;   % v0
     1   tf   tf^2   tf^3;     % qf
     0   1    2*tf   3*tf^2];  % vf
  
B1 = [P0(2);   P0(8);  Pf(2);  Pf(8)];  % [q01 v01 qf1 vf1]
B2 = [P0(3);   P0(9);  Pf(3);  Pf(9)];  % [q02 v02 qf2 vf2]
B3 = [P0(4);  P0(10);  Pf(4); Pf(10)];  % [q03 v03 qf3 vf3]
B4 = [P0(5);  P0(11);  Pf(5); Pf(11)];  % [q04 v04 qf4 vf4]
B5 = [P0(6);  P0(12);  Pf(6); Pf(12)];  % [q05 v05 qf5 vf5]
B6 = [P0(7);  P0(13);  Pf(7); Pf(13)];  % [q06 v06 qf6 vf6]

C1 = A\B1;
C2 = A\B2;
C3 = A\B3;
C4 = A\B4;
C5 = A\B5;
C6 = A\B6;

C = [C1(1), C1(2),  C1(3),  C1(4),...   % [a01 a11 a21 a31]
     C2(1), C2(2),  C2(3),  C2(4),...   % [a02 a12 a22 a32]
     C3(1), C3(2),  C3(3),  C3(4),...   % [a03 a13 a23 a33]
     C4(1), C4(2),  C4(3),  C4(4),...   % [a04 a14 a24 a34]
     C5(1), C5(2),  C5(3),  C5(4),...   % [a05 a15 a25 a35]
     C6(1), C6(2),  C6(3),  C6(4)];     % [a06 a16 a26 a36]
end