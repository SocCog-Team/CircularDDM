% Function that yields mean and covariance
% given coherence and no. of dots
% ndots: no. of dots
% coh: coherence
% d: norm of vector 
% a: angle
% nsim: no. of simulation

function [R_m,R_v,T_m,T_v] = rdm_func(ndots,coh,d,a,nsim)
%ndots = 4;
%d = 1; % total displacement for each dot
%a = 200;
alpha = a*pi/180; % "true" direction
%coh = 0.25; % coherence
%nsim = 1;

nsig = coh*ndots; % no. of signal dots
nran = ndots - nsig; % no. of random dots

for i = 1:nsim
    alpha_r = 2*pi*rand(nran,1);
    % To add vectors, first convert Polar to Cartesian
    x_s = d*cos(alpha); %signal
    y_s = d*sin(alpha);
    x_r = d*cos(alpha_r); %random
    y_r = d*sin(alpha_r);
    %[x,y] = pol2cart(alpha,d); %signal dots, convert polar to cartesian
    %[x_r,y_r] = pol2cart(alpha_r,d); %random dots, convert polar to cartesian

%     % vector sum
%     sum_x = x_s*nsig + sum(x_r); % x-component of sum of vectors
%     sum_y = y_s*nsig + sum(y_r); % y-component of sum of vectors

    % vector mean
    sum_x = (x_s + x_r)/ndots; % x-component of sum of vectors
    sum_y = (y_s + y_r)/ndots; % y-component of sum of vectors

    % convert to polar coordinates (with positive radial distance)
    S_rpol(i) = sqrt(sum_x^2 + sum_y^2); %radial
    
    % Note: atan ranges from -pi/2 to pi/2
    if sum_x < 0
        if sum_y > 0
            S_tpol(i) = pi - atan(abs(sum_y)/abs(sum_x));
        else
            S_tpol(i) = pi + atan(abs(sum_y)/abs(sum_x));
        end
    else
        if sum_y > 0 
            S_tpol(i) = atan(abs(sum_y)/abs(sum_x));
        else
            S_tpol(i) = 2*pi - atan(abs(sum_y)/abs(sum_x));
        end
    end    
    %norm_m = norm_m + S_rpol/nsim;
    %angle_m = angle_m + S_tpol/nsim;
end

R_m = mean(S_rpol);
R_v = var(S_rpol);
T_m = mean(S_tpol);
T_v = var(S_tpol);
