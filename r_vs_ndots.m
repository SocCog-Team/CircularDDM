% Use [R_m,R_v,T_m,T_v] = rdm_func(ndots,coh,d,a,nsim)

clear all; close all;

d = 1;
a = 200;
nsim = 1e6;

for i = 1:25
    [Rm25(i),Rv25(i),Tm25(i),Tv25(i)] = rdm_func(4*i,0.25,d,a,nsim);
end

for i = 1:49
    [Rm50(i),Rv50(i),Tm50(i),Tv50(i)] = rdm_func(2*(i+1),0.5,d,a,nsim);
end

for i = 1:25
    [Rm75(i),Rv75(i),Tm75(i),Tv75(i)] = rdm_func(4*i,0.75,d,a,nsim);
end

for i = 1:97
    [Rm0(i),Rv0(i),Tm0(i),Tv0(i)] = rdm_func(i+3,0,d,a,nsim);
    [Rm100(i),Rv100(i),Tm100(i),Tv100(i)] = rdm_func(i+3,1,d,a,nsim);
end

figure(1)
box off
%plot(linspace(4,100,97),Rm0,'LineWidth',3)
%hold on
plot(linspace(4,100,25),Rm25,'LineWidth',3)
hold on
plot(linspace(4,100,49),Rm50,'LineWidth',3)
hold on
plot(linspace(4,100,25),Rm75,'LineWidth',3)
hold on
plot(linspace(4,100,97),Rm100,'LineWidth',3)
%legend('Coh = 0','Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
legend('Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
xlabel('No. of dots')
ylabel('Mean Radial distance')
set(gca,'FontSize',30)

figure(2)
box off
%plot(linspace(4,100,97),Rv0,'LineWidth',3)
%hold on
plot(linspace(4,100,25),Rv25,'LineWidth',3)
hold on
plot(linspace(4,100,49),Rv50,'LineWidth',3)
hold on
plot(linspace(4,100,25),Rv75,'LineWidth',3)
hold on
plot(linspace(4,100,97),Rv100,'LineWidth',3)
%legend('Coh = 0','Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
legend('Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
xlabel('No. of dots')
ylabel('Variance Radial distance')
set(gca,'FontSize',30)

figure(3)
box off
%plot(linspace(4,100,97),Tm0,'LineWidth',3)
%hold on
plot(linspace(4,100,25),Tm25,'LineWidth',3)
hold on
plot(linspace(4,100,49),Tm50,'LineWidth',3)
hold on
plot(linspace(4,100,25),Tm75,'LineWidth',3)
hold on
plot(linspace(4,100,97),Tm100,'LineWidth',3)
%legend('Coh = 0','Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
legend('Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
xlabel('No. of dots')
ylabel('Mean Phase angle')
set(gca,'FontSize',30)

figure(4)
box off
%plot(linspace(4,100,97),Tv0,'LineWidth',3)
%hold on
plot(linspace(4,100,25),Tv25,'LineWidth',3)
hold on
plot(linspace(4,100,49),Tv50,'LineWidth',3)
hold on
plot(linspace(4,100,25),Tv75,'LineWidth',3)
hold on
plot(linspace(4,100,97),Tv100,'LineWidth',3)
%legend('Coh = 0','Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
legend('Coh = 0.25', 'Coh = 0.5','Coh = 0.75','Coh = 1')
xlabel('No. of dots')
ylabel('Variance Phase angle')
set(gca,'FontSize',30)
