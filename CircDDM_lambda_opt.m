% Use fminsearch to find lambda 
% Optimize recursive functions

clear all; close all;

iif     = @(varargin) varargin{2*find([varargin{1:2:end}], 1, 'first')}();
recur   = @(f, varargin) f(f, varargin{:});
curly   = @(x, varargin) x{varargin{:}};       

loop = @(x0, cont, fcn, cleanup) ...                            % Header
       recur(@(f, x) iif(~cont(x{:}), cleanup(x{:}), ...        % Continue?
                         true,        @() f(f, fcn(x{:}))), ... %   Iterate
             x0);     


ndots = 100; % no. of dots 
coh = 0.17; % coherence
dt = 0.010; % time per frame
n_switch = 100; % no. of switch
T_switch = 1; % switch rate
T = n_switch*T_switch; % total time
nsim = 10; % no. of runs

a = rand(1,n_switch); % angles/directions

ti = 0:dt:T; 
ts = 0:dt:T_switch;

VX = 0.5*(1-coh)/ndots; 
S = [VX 0; 0 VX]; % covariance matrix

mu(:,1) = [coh*cos(a(1));coh*sin(a(1))]; % mean of the first direction

for j = 1:n_switch
    for i = (length(ts)-1)*(j-1)+2:(length(ts)-1)*(j)+1 
        mu(:,i) = [coh*cos(a(j));coh*sin(a(j))];
    end
end

% Compute leaky integrator output per step
X_leak = @(lambda) loop({[0;0],1}, ... % Initial state, x = [0;0]
            @(X_leak,k) k<=(length(ti)-1), ... % while k is in this range
            @(X_leak,k) {[X_leak,(1-lambda*dt)*X_leak(:,end)+mvnrnd(mu(:,k),S)'*dt],... %update X_leak
                k+1},...
            @(X_leak,k) X_leak);  
% compute mean squared error "err"
err = @(lambda) sum(([1 0]*(lambda*X_leak(lambda) - mu)).^2 ...
            +([0 1]*(lambda*X_leak(lambda) - mu)).^2)/(2*length(ti));
                % sum(x.coord^2+y.coord^2)/(2*no. of points) 
        
parfor i = 1:nsim
    [l_opt(i),MSE(i)] = fminsearch(err,rand); % find minimum of err(lambda)
end

figure(1)
hist(l_opt)
title(['coh = ' num2str(coh)])
set(gca,'FontSize',20)

%{
I = find(MSE == min(MSE));
min_lopt = l_opt(I);


alpha = 2*pi*rand(1,5);
[X_stim,X_leak] = leak_func(0.8,100,5,1,dt,40,alpha);

t = 0:dt:T_switch*5;

figure(2)
subplot(2,1,1)
plot(t,X_stim(1,:),'Color','k','LineWidth',3)
hold on
plot(t,X_leak(1,:),'Color','b','LineWidth',3)
title(['Coh = ' num2str(coh) ', T_{switch} = ' num2str(T_switch) ', \lambda_{opt} = ' num2str(min_lopt)])
xlabel('Time')
ylabel('X')
set(gca,'FontSize',20)

subplot(2,1,2)
plot(t,X_stim(2,:),'Color','k','LineWidth',3)
hold on
plot(t,X_leak(2,:),'Color','b','LineWidth',3)
xlabel('Time')
ylabel('Y')
set(gca,'FontSize',20)

figure(3)
subplot(2,1,1)
plot(t,X_stim(1,:),'Color','k','LineWidth',3)
xlabel('Time')
ylabel('X')
title(['Coh = ' num2str(coh) ', T_{switch} = ' num2str(T_switch) ', \lambda_{opt} = ' num2str(min_lopt)])
set(gca,'FontSize',20)

subplot(2,1,2)
plot(t,X_leak(1,:),'Color','b','LineWidth',3)
xlabel('Time')
ylabel('X')
set(gca,'FontSize',20)

figure(4)
subplot(2,1,1)
plot(t,X_stim(2,:),'Color','k','LineWidth',3)
xlabel('Time')
ylabel('Y')
title(['Coh = ' num2str(coh) ', T_{switch} = ' num2str(T_switch) ', \lambda_{opt} = ' num2str(min_lopt)])
set(gca,'FontSize',20)

subplot(2,1,2)
plot(t,X_leak(2,:),'Color','b','LineWidth',3)
xlabel('Time')
ylabel('Y')
set(gca,'FontSize',20)
%}
