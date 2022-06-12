clear all; close all; clc;

load('mat_01.mat');
%% Time
tout = eS.time;
%% Joint
ref = the_r.signals.values;
the_PD = thePID.signals.values;
the_CTC = theC.signals.values;
the_S = theS.signals.values;
the_SE = theSE.signals.values;
%% Error
e_PD = ePID.signals.values;
e_CTC = eC.signals.values;
e_S = eS.signals.values;
e_SE = eSE.signals.values;
%% Torque Signals
t_PD = uPID.signals.values;
t_CTC = uC.signals.values;
t_S = uS.signals.values;
t_SE = uSE.signals.values;
%% Delta Torque
dt = dtESE.signals.values;
dtESO = dtSE.signals.values;

%% Plot Theta 1...6
for i = 1:6
    plotdata(1,tout,[ref(:,i),the_PD(:,i),the_CTC(:,i),the_S(:,i),the_SE(:,i)],{'Ref','PD','CTC','SMC','SMC + ESO'},sprintf('Response at Joint %d',i),5);
end
%% Plot Error 1...6
for i = 1:6
    plotdata(1,tout,[e_PD(:,i),e_CTC(:,i),e_S(:,i),e_SE(:,i)],{'PD','CTC','SMC','SMC + ESO'},sprintf('Error at Joint %d',i),4);
end
%% Plot Torque 1...6
for i = 1:6
    plotdata1(1,tout,[t_PD(:,i),t_CTC(:,i),t_S(:,i),t_SE(:,i)],{'PD','CTC','SMC','SMC + ESO'},sprintf('Torque at Joint %d',i),4);
end
%% Plot Delta 1...6
for i = 1:6
    plotdata1(1,tout,[dt(:,i),dtESO(:,i)],{'Disturbance System','Estimated Disturbance'},sprintf('Disturbance at Joint %d',i),2);
end