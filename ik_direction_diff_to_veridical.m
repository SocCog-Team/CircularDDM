
clear all
close all

 
v_deg = [ones(1,20)*0 ones(1,20)*90 ones(1,20)*270 ones(1,20)*180 ones(1,20)*360 ones(1,20)*0]; % deg
vn_deg = v_deg + 5*randn(size(v_deg));
vn_rad = deg2rad(vn_deg);
subplot(2,1,1)
plot(vn_rad)

vn_rad_ang_diff = circ_dist2(vn_rad,vn_rad(1));
subplot(2,1,2)
plot((vn_rad_ang_diff))

% b = deg2rad(a); % rad
% 
%  
% for i = 1:length(a)-1
%     dff(i) = rad2deg(circ_dist(b(i),b(i+1))); % Difference [deg]
% end
% 
%  
% figure
% ax1 = subplot(2,1,1);
% stairs(a)
% ax1.XLim = [1 length(a)];
% ax1.YLabel.String = 'Direction [deg]';
% ax1.FontSize = 16;
% 
%  
% ax2 = subplot(2,1,2);
% stairs(cumsum(-dff))
% ax2.XLim = [1 length(a)];
% ax2.YLabel.String = 'Difference [deg]';
% ax2.FontSize = 16;
% 
 
