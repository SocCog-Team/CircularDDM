function y = leakyIntegrator(s,k,t,d)

dt = t(2) - t(1);
nt = length(t);
nd = round(d / dt);  % number of time steps for the delay

% Pad the signal with zeros at the beginning to simulate delay
s_delayed = [zeros(1, nd), s];
s_delayed = s_delayed(1:nt);  % ensure same length as t

y = zeros(1, nt);
for i = 1:(nt - 1)
    dy = s_delayed(i) - y(i)/k;
    y(i+1) = y(i) + dy * dt;
end