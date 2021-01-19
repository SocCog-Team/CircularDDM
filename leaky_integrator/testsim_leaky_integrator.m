function testsim_leaky_integrator
% https://courses.washington.edu/matlab1/matlab/Lesson_12.m

%% Lesson_12 Linear filters for 1-D time-series
%
% A 1-D 'filter' is a function that takes in a 1-D vector, like a
% time-series and returns another vector of the same size.  Filtering shows
% up all over the behavioral sciences, from models of physiology including
% neuronal responses and hemodynamic responses, to methods for analyzing
% and viewing time-series data.  
%
% Typical filters are low-pass and band-pass filters that attenuate
% specific ranges of the frequency spectrum.  We built our first filter in
% the last lesson by specifying which frequencies we wanted to modify using
% the fft and the ifft.  In this lesson we'll focus on the time-domain by
% developing a simple leaky integrator filter and show that it satisfies
% the properties of superposition and scaling that make it a linear
% filter.  

%% The Leaky Integrator
%
% A 'leaky integrator' possibly the simplest filter we can build, but it
% forms the basis of a wide range of physiologically plausible models of
% neuronal membrane potentials (such as the Hodgkin-Huxley model),
% hemodynamic responses (as measured with fMRI), and both neuronal and
% behavioral models of adaptation, such as light and contrast adaptation.  
%
% A physical example of a 'leaky integrator' is a bucket of water with a
% hole in the bottom.  The rate that the water flows out is proportional to
% the depth of water in the bucket (because the pressure at the hole is
% proportional to the volume of water).  If we let 'y(t)' be the volume of
% water at any time t, then our bucket can be described by a simple
% differential equation:
% 
% $$\frac{dy}{dt} = -\frac{y}{k}$$
% 
% Where 'k' is the constant of proportionality.  A large 'k' corresponds to
% a small hole where the water flows out slowly.  You might know the
% closed-form solution to this differential equation, but hold on - we'll get
% to that later.
%
% We need to add water to the bucket.  Let s(t) be the flow of water into
% the bucket, so s(t) adds directly to the rate of change of y:
%
% $$\frac{dy}{dt} = s-\frac{y}{k}$$
%
% A physiological example of a leaky integrator is if 'y' is the membrane
% potential of a neuron where the voltage leaks out at a rate in proportion
% to the voltage difference (potential) and 's' is the current flowing
% into the neuron. This is the basis of a whole class of models for membrane
% potentials, including the famous Hodgkin-Huxley model.
%
% We can easily simulate this leaky integrator in discrete steps of time by
% changing the value of 'y' on each step according to the equation above:

% Generate a time-vector
dt = .001;  %step size (seconds)
maxt = 10;  %ending time (seconds)
t = 0:dt:(maxt-dt);
nt = length(t);  %length of t
lambda = 5;  % Lambda represents the memory leak rate (the inverse of the integration time constant k). Large integration time constant k (small lambda) - slow leak
k = 1/lambda;



% Define 's' 
s  = zeros(size(t));
s(t<=1) =1 ;   
s(t>1 & t<2) =-0.5;  


 
y = leakyIntegrator(s,k,t);
li_plotResp(t,s,y);


