clear all;
clc;

rand('state',sum(100*clock));
%%
% Dieu kien dung: GA dung khi da chay duoc 200 the he hoac
% trong 50 the he lien tiep ham thich nghi thay doi khong qua 10^-4
max_generation=100;
max_stall_generation=50;
epsilon= 0.01;
% Kich thuoc quan the la 50
pop_size=20;
% Co 12 thong so can chinh dinh
npar = 12;
% Tam khoi dong gia tri thong sos ban dau
range=[  0   0   0   0   0   0   0   0   0   0   0   0;...
       100 100 100 100 100 100 100 100 100 100 100 100];
% Moi thong so duoc ma hoa thanh doan gen
dec=[2 2 2 2 2 2 2 2 2 2 2 2];
% co 5 chu so co nghia, vi tri dau cham thap phan la 2
sig=[4 4 4 4 4 4 4 4 4 4 4 4];
% Xac suat lai ghep la 0.9
cross_prob = 0.9;
% Xac suat dot bien la 0.1
mutate_prob = 0.1;
% Luu giu ca the tot nhat trong qua trinh tien hoa
elitism = 1;
% Trong so cua ham thich nghi
rho=0.02;
% Khoi dong ngau nhien the he dau tien
par=Init(pop_size,npar,range);
Terminal=0;
generation=0;
stall_generation=0;
% Tinh do thgich nghi cua quan the ban dau
for pop_index=1:pop_size,
    k11=par(pop_index,1);
    k12=par(pop_index,2);
    k13=par(pop_index,3);
    k14=par(pop_index,4);
    k15=par(pop_index,5);
    k16=par(pop_index,6);
    k21=par(pop_index,7);
    k22=par(pop_index,8);
    k23=par(pop_index,9);
    k24=par(pop_index,10);
    k25=par(pop_index,11);
    k26=par(pop_index,12);
    k1  = [k11 k12 k13 k14 k15 k16];
    k2  = [k21 k22 k23 k24 k25 k26];
    % Mo phong he thong
    sim('CONTROL_01.slx');
        J1 = (e(:,1)'*e(:,1))+rho*(u(:,1)'*u(:,1)); 
        J2 = (e(:,2)'*e(:,2))+rho*(u(:,2)'*u(:,2)); 
        J3 = (e(:,3)'*e(:,3))+rho*(u(:,3)'*u(:,3)); 
        J4 = (e(:,4)'*e(:,4))+rho*(u(:,4)'*u(:,4)); 
        J5 = (e(:,5)'*e(:,5))+rho*(u(:,5)'*u(:,5)); 
        J6 = (e(:,6)'*e(:,6))+rho*(u(:,6)'*u(:,6));
        J = J1 + J2 + J3 + J4 + J5 + J6; 
    % GA tim cuc dai ham thich nghi
    fitness(pop_index)=1/(J+eps);
end;

[bestfit0,bestchrom]=max(fitness);
J0=1/bestfit0-0.001;

k11=par(bestchrom,1);
k12=par(bestchrom,2);
k13=par(bestchrom,3);
k14=par(bestchrom,4);
k15=par(bestchrom,5);
k16=par(bestchrom,6);
k21=par(bestchrom,7);
k22=par(bestchrom,8);
k23=par(bestchrom,9);
k24=par(bestchrom,10);
k25=par(bestchrom,11);
k26=par(bestchrom,12);
k1  = [k11 k12 k13 k14 k15 k16];
k2  = [k21 k22 k23 k24 k25 k26];
J0=1/bestfit0-0.001;

% Chay den khi dieu kien dung thoa man
while ~Terminal,        
    generation = generation+1;
    disp(['generation #' num2str(generation) ' of maximum ' num2str(max_generation)]);
    % Ma hoa thap phan
    pop=Encode_Decimal_Unsigned(par,sig,dec); 
    % Chon loc sap hang tuyen tinh
    parent=Select_Linear_Ranking(pop,fitness,0.2,elitism,bestchrom); 
    % Lai ghep hai diem
    child=Cross_Twopoint(parent,cross_prob,elitism,bestchrom);
    % Dot bien deu
    pop=Mutate_Uniform(child,mutate_prob,elitism,bestchrom);
    % Giai ma thap phan
    par=Decode_Decimal_Unsigned(pop,sig,dec);
    % Danh gia lai do thich nghi cua quan the sau moi the he tien hoa
    for pop_index=1:pop_size,
        k11=par(bestchrom,1);
        k12=par(bestchrom,2);
        k13=par(bestchrom,3);
        k14=par(bestchrom,4);
        k15=par(bestchrom,5);
        k16=par(bestchrom,6);
        k21=par(bestchrom,7);
        k22=par(bestchrom,8);
        k23=par(bestchrom,9);
        k24=par(bestchrom,10);
        k25=par(bestchrom,11);
        k26=par(bestchrom,12);
        k1  = [k11 k12 k13 k14 k15 k16];
        k2  = [k21 k22 k23 k24 k25 k26];
        sim('CONTROL_01.slx');
        J1 = (e(:,1)'*e(:,1))+rho*(u(:,1)'*u(:,1)); 
        J2 = (e(:,2)'*e(:,2))+rho*(u(:,2)'*u(:,2)); 
        J3 = (e(:,3)'*e(:,3))+rho*(u(:,3)'*u(:,3)); 
        J4 = (e(:,4)'*e(:,4))+rho*(u(:,4)'*u(:,4)); 
        J5 = (e(:,5)'*e(:,5))+rho*(u(:,5)'*u(:,5)); 
        J6 = (e(:,6)'*e(:,6))+rho*(u(:,6)'*u(:,6));
        J = J1 + J2 + J3 + J4 + J5 + J6;
        fitness(pop_index)=1/(J+eps);
    end;
    [bestfit(generation),bestchrom]=max(fitness);
    
    % Kiem tra dieu kien dung
    if generation == max_generation
        Terminal = 1;
    elseif generation>1,
        if abs(bestfit(generation)-bestfit(generation-1))<epsilon,
            stall_generation=stall_generation+1;
            if stall_generation == max_stall_generation, Terminal = 1; end
        else
            stall_generation=0;
        end;
    end;    
end; 

plot(1./bestfit)
k11=par(bestchrom,1);
k12=par(bestchrom,2);
k13=par(bestchrom,3);
k14=par(bestchrom,4);
k15=par(bestchrom,5);
k16=par(bestchrom,6);
k21=par(bestchrom,7);
k22=par(bestchrom,8);
k23=par(bestchrom,9);
k24=par(bestchrom,10);
k25=par(bestchrom,11);
k26=par(bestchrom,12);
k1  = [k11 k12 k13 k14 k15 k16];
k2  = [k21 k22 k23 k24 k25 k26];
J=1/bestfit(end);
sim('CONTROL_01.slx');
out=[k1 k2]