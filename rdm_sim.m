% Simulate RDM
%                                                                                                                                                                                                     
% test nrand
% given coherence and no. of dots
% ndots: no. of dots
% coh: coherence
% d: norm of vector 
% a: angle
% nsim: no. of simulation

%function [R_m,R_v,T_m,T_v] = rdm_func1(ndots,coh,d,a,nsim)

clear all; close all;

ndots = 100;
d = 0.5; % total displacement for each dot
a = 200;
alpha = a*pi/180; % "true" direction
coh = 0.25; % coherence
%nsim = 1e6;
T = 0.2;
%dt = 1e-3;
R = d; %s_R = 0.00248999; % mean and standard deviation of radial distance
s_R = 0.1;
theta = 200*pi/180; %s_t = 0.0100897;
s_t = 0.5*pi/180;
sigma = 0;
dt = 1e-3;
Y0 = [0;0];

nsig = coh*ndots; % no. of signal dots
nran = ndots - nsig; % no. of random dots

X(:,1) = [0;0];

figure(1)
plot(0,0,'k.','MarkerSize',30)
%xlim([-0.5 0.5])
%ylim([-0.5 0.5])
set(gca,'FontSize',30)

for i = 2:T/dt
    alpha_r = 2*pi*rand(nran,1);
    x_s = (d*dt)*cos(alpha); %signal
    y_s = (d*dt)*sin(alpha);
    x_r = (d*dt)*cos(alpha_r); %random
    y_r = (d*dt)*sin(alpha_r);
    sum_x = (x_s*nsig + sum(x_r))/ndots; % x-component of sum of vectors
    sum_y = (y_s*nsig + sum(y_r))/ndots; % y-component of sum of vectors
    X(:,i) = X(:,i-1) + [sum_x; sum_y];
end

Y(:,1) = Y0;
nos = sqrt(dt)*sigma;

for i = 2:T/dt
    R_temp = R + s_R*randn;
    t_temp = theta + s_t*randn;
    Y(1,i) = Y(1,i-1) + (R_temp)*cos(t_temp)*dt + nos*randn;
    Y(2,i) = Y(2,i-1) + (R_temp)*sin(t_temp)*dt + nos*randn;
end

y = animatedline('Color','b','LineWidth',2);
z = animatedline('Color','r','LineWidth',2);
figure(1)
%polarplot(T,r)
for k = 1:T/dt
    addpoints(y,X(1,k),X(2,k));
    %addpoints(z,Y(1,k),Y(2,k));
    drawnow
    %F(k) = getframe(gcf);
end