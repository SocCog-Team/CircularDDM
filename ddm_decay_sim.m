% Use function [X_end,h_end] = circ_ddm(A,sigma,theta,dt,T,X0)
% A is strength of evidence
% sigma is noise constant
% dt: time step
% T: total accumulating time
% X0 = [0;0]: initial point

%A = 0.1; 
clear all; close all;

A = 0.5;
sigma = 1; dt = 1e-3;
T = 1; X0 = [0;0];
k = 0.5;
theta = 200;
Nsim = 1e6;

for j = 1:length(A)
    for i = 1:Nsim
        [X_end,h_end] = circ_decay_ddm(A(j),sigma,k,theta,dt,T,X0);
        X(:,i) = X_end;
        t(i) = h_end;
        l(i) = sqrt((X(1,i)^2+(X(2,i))^2));
    end
    r(j) = mean(l);
    h(j) = mean(t);
end

%figure(1)
%plot(A,r,'LineWidth',3)
%xlabel('SNR')
%ylabel('Radial distance')
%set(gca,'FontSize',30)

%figure(2)
%plot(A,h,'LineWidth',3)
%xlabel('SNR')
%ylabel('Angle')
%set(gca,'FontSize',30)

%sim = linspace(1,1e6,1e6);
%figure(1)
%plot(X(1,:),X(2,:),'LineWidth',3,'Color','b')
%hold on
%plot(X(1,end),X(2,end),'r.','MarkerSize',30)
%hold on
%plot(X(1,1),X(2,1),'g.','MarkerSize',30)
%xlabel('x')
%ylabel('y')
%set(gca,'FontSize',30)

%figure(2)
%plot(sim,h,'LineWidth',3)
%xlabel('No. of simulations')
%ylabel('Final angle')
%set(gca,'FontSize',30)

%hist2d(X(1,:),X(2,:))
figure(1)
histogram(t)
title('SNR = 0.5')
set(gca,'FontSize',30)

% r: distance from center
for i = 1:Nsim
    r(i) = sqrt((X(1,i)^2+(X(2,i))^2));
end

figure(2)
histogram(l)
title('SNR = 0.5')
set(gca,'FontSize',30)


%figure(1)
%plot(X(1,:),X(2,:),'LineWidth',3,'Color','b')
%hold on
%plot(X(1,end),X(2,end),'r.','MarkerSize',30)
%hold on
%plot(X(1,1),X(2,1),'g.','MarkerSize',30)
%set(gca,'FontSize',30)