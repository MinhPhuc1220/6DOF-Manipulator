clc;
close all; 

%% Extract data
Px_TP = TP.signals(1).values;
Py_TP = TP.signals(2).values;
Pz_TP = TP.signals(3).values;

Px_CTC = CTC.signals(1).values;
Py_CTC = CTC.signals(2).values;
Pz_CTC = CTC.signals(3).values;

Px_SMC = SMC.signals(1).values;
Py_SMC = SMC.signals(2).values;
Pz_SMC = SMC.signals(3).values;

%% Plot 3D
figure(1);
plot3(Px_TP(:),Py_TP(:),Pz_TP(:),'-k',Px_CTC(:),Py_CTC(:),Pz_CTC(:),'--r',Px_SMC(:),Py_SMC(:),Pz_SMC(:),'--b','linewidth',1.5);
grid on;
title('Quỹ đạo hình tròn');
legend('Quỹ đạo đặt','Quỹ đạo CTC','Quỹ đạo SMC');
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
xlim([380 460]);
ylim([-60 60]);
zlim([580 720]);

%% Plot 2D
figure(2);
subplot(1,3,1);
plot(Py_TP(:),Pz_TP(:),'-k','linewidth',2);
title('Quỹ đạo đặt');
xlabel('y(t)');
ylabel('z(t)');
xlim([-50 50]);
ylim([600 700]);
subplot(1,3,2);
plot(Py_CTC(:),Pz_CTC(:),'--r','linewidth',2);
title('Quỹ đạo CTC')
xlabel('y(t)');
ylabel('z(t)');
xlim([-50 50]);
ylim([600 700]);
subplot(1,3,3);
plot(Py_SMC(:),Pz_SMC(:),'--b','linewidth',2);
title('Quỹ đạo SMC');
xlabel('y(t)');
ylabel('z(t)');
xlim([-50 50]);
ylim([600 700]);


