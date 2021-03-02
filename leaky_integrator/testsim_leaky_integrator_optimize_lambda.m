function testsim_leaky_integrator_optimize_lambda

dt = .01;  % step size (seconds)
n_switches = 100;
T_switch = 1; % time of one steady state (s)
T = n_switches*T_switch; % total time (s)
n_runs = 100;
t = 0:dt:(T-dt);
PLOT = 0;

% Lambda represents the memory leak rate (the inverse of the integration time constant k). Large integration time constant k (small lambda) - slow leak

noise_amp = [0:0.2:3];

for n = 1:length(noise_amp),
    noise = noise_amp(n);
    
    for r = 1:n_runs,
    
    % Define 's' - veridical stimulus
    stim =  -1 + 2*rand(n_switches,1); % random stimulus direction from [-1 to 1]
    s = reshape(repmat(stim',T_switch/dt,1),1,[]);
    
    s_n = s + noise*randn(size(s)); % stimulus plus noise
    
    % find optimal lambda in this run
    [lambda(r,n), MSE(r,n)] = fminbnd(@(lDummy) mse_leakyIntegrator(lDummy, s_n, t, s), 0.1,100);
    end
    
    if PLOT,
        
        figure
        hist(lambda(:,n),100);
        
        lambda_opt = mean(lambda,1);
        
        k=1/lambda_opt;
        y = leakyIntegrator(s_n,k,t);
        
        % scale integrator output to match the stimulus
        y = y*lambda_opt;
        
        figure
        li_plotResp(t,s,s_n,y,lambda_opt);

    end

end

figure
subplot(2,1,1)
errorbar(noise_amp,mean(lambda,1),std(lambda,0,1));
title(sprintf('%d switches %d runs',n_switches, n_runs));
xlabel('noise ampl.');
ylabel('optimal lambda');
set(gca,'Xlim',[noise_amp(1) noise_amp(end)]);

subplot(2,1,2)
plot(noise_amp,std(lambda,0,1));
xlabel('noise ampl.');
ylabel('SD of lambda');




function mse = mse_leakyIntegrator(lambda,s_n,t,s) 

k = 1/lambda;
y = lambda*leakyIntegrator(s_n,k,t);
mse = mean((y-s).^2);



