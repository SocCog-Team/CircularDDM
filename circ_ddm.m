% Circular DDM with 2D drift

%clear all; close all; 

function [X_end,h_end] = circ_ddm(A,sigma,theta,dt,T,X0)

%X(:,1) = [0;0]; % initial point is at the center
%A: drift term, strength of the evidence
%sigma: diffusion term, noise
%theta = 200; % angle of the drift, in degrees
%dt = 0.001; % time step

%T_stat = 1; % stationary interval
%T_switch = 3; % switch interval

%X(:,1) = X0, for example X0 = [0;0]; % initial point is at the center

X(:,1) = X0; % initial point is at the center

nos = sqrt(dt)*sigma;

m1 = A*cos(theta*pi/180);
m2 = A*sin(theta*pi/180);
mu = [m1;m2];


%% cycle 1
% Stationary state
for i = 2:T/dt
    X(:,i) = X(:,i-1) + mu*dt + nos*eye(2)*randn(2,1);
    h_temp = atan(X(2,i)/X(1,i))*180/pi;
    %if h(i) < 0
    %    h(i) = h(i) + 360;
    %end
    if X(1,i) < 0
        h(i) = h_temp + 180;
    else
        if X(2,i) > 0
            h(i) = h_temp;
        else
            h(i) = h_temp + 360;
        end
    end
end

X_end = X(:,end);
h_end = h(end);

