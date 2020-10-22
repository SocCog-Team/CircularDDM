%Create trajectories

clear all; close all;

R = 1; s_R = 0.5; % mean and standard deviation of radial distance
theta = 200; s_t = 10*pi/180; 
dt = 1e-3;
T1 = 0.1; % stationary interval
X0 = [0;0];
T2 = 0.2; % switch interval
lambda = 1; % decay rate
theta = 200;

figure(1)
plot(0,0,'k.','MarkerSize',30)
xlim([-0.5 0.5])
ylim([-0.5 0.5])
set(gca,'FontSize',30)

X(:,1) = X0;
nos = sqrt(dt)*[s_R 0; 0 s_t];

m1 = R*cos(theta*pi/180);
m2 = R*sin(theta*pi/180);
mu = [m1;m2];

for i = 2:T1/dt
    X(:,i) = X(:,i-1) + (mu-lambda*X(:,i-1))*dt + nos*randn(2,1);
    h_temp = atan(abs(X(2,i))/abs(X(1,i)))*180/pi;
    if X(1,i) < 0
        if X(2,i) > 0
            h(i) = 180 - h_temp;
        else
            h(i) = 180 + h_temp;
        end
    else
        if X(2,i) > 0
            h(i) = h_temp;
        else
            h(i) = 360 - h_temp;
        end
    end
end

Y(:,1) = X(:,end);

%theta2 = 360*rand; % direction switches randomly
theta2 = 30;
m1b = R*cos(theta2*pi/180);
m2b = R*sin(theta2*pi/180);
mub = [m1b;m2b];

for i = 2:T2/dt
    Y(:,i) = Y(:,i-1) + (mub-lambda*Y(:,i-1))*dt + nos*randn(2,1);
    h_temp = atan(abs(Y(2,i))/abs(Y(1,i)))*180/pi;
    if Y(1,i) < 0
        if Y(2,i) > 0
            h2(i) = 180 - h_temp;
        else
            h2(i) = 180 + h_temp;
        end
    else
        if Y(2,i) > 0
            h2(i) = h_temp;
        else
            h2(i) = 360 - h_temp;
        end
    end
end

y = animatedline('Color','b','LineWidth',2);
figure(1)
for k = 1:T1/dt
    addpoints(y,X(1,k),X(2,k));
    drawnow
    F1(k) = getframe(gcf);
end

z = animatedline('Color','r','LineWidth',2);

figure(1)
for k = 1:T2/dt
    addpoints(z,Y(1,k),Y(2,k));
    drawnow
    F2(k) = getframe(gcf);
end

F = MergeStructs(F1,F2);

figure(1)
video = VideoWriter('decay','MPEG-4');
open(video)
writeVideo(video,F)
close(video)