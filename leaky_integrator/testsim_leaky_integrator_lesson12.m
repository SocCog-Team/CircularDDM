function testsim_leaky_integrator_lesson12
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
maxt = 5;  %ending time (seconds)
t = 0:dt:(maxt-dt);
nt = length(t);  %length of t

%%
% As our first example, we'll let k=inf, so there's no hole in the bucket
% (or the hole is infinitely small).
k = inf;   

% Define 's' to be one for the first second.
s  = zeros(size(t));
s(t<=1) =1 ;   

%%
% Here's the loop.  
y =zeros(size(t));
for i=1:(nt-1)
    dy = s(i)-y(i)/k;
    y(i+1)=y(i)+dy*dt;
end

figure(1)
clf
plotResp(t,s,y);


%% 
% Next we'll add the hole in the bucket by setting 'k' to 1.  I've written
% a function 'leakyIntegrator' that does the loop above since we'll be
% using this a bunch of times in this lesson. 

k=1;  
y = leakyIntegrator(s,k,t);
plotResp(t,s,y);


%% 
% See how the bucket starts filling up more slowly, and how the water
% drains out when the flow stops.  Try this again with a bigger hole by
% letting k = 1/5 = .2, for example:

k=.2;  
y = leakyIntegrator(s,k,t);
plotResp(t,s,y);

%% 
% This time the water reached an asymptotic level. This is because the flow
% rate out the bottom eventually reached the rate of flow into the bucket.
% With k=.2, can you figure out why the asymptotic level is 0.2?  Notice
% also how the water drains out more quickly.  The size of the hole, 'k',
% is called the 'time-constant' of this leaky integrator.

%% Responses to short impulses
%
% Our previous example had water flowing into the bucket at 1 gallon/second
% for one second.  What happens when we splash in that gallon of water in a
% much shorter period of time, say within 1/10 of a second.

figure(1)
clf
k = 1/5;
s = zeros(size(t));
dur = .01;
s(t<dur) = 1/dur;
y = leakyIntegrator(s,k,t);
plotResp(t,s,y);
subplot(2,1,1)


set(gca,'YLim',[0,1]);


%%
% Here's the same amount of water splashed in 1/100 of a second.

figure(2)
clf

k = 1/5;
s = zeros(size(t));
dur = .001;
s(t<dur) = 1/dur;
y = leakyIntegrator(s,k,t);
plotResp(t,s,y);

set(gca,'YLim',[0,1]);

%% 
% Compare these two responses - they're nearly identical.  This is because
% for short durations compared to the time-constant, the leaky integrator
% doesn't leak significantly during the input, so the inputs are
% effectively the same. 
%
% How long can you let the stimulus get before it starts significantly
% affecting the shape of the response?  How does this depend on the
% time-constant of the leaky integrator?
%
% This behavior is an explanation for "Bloch's Law", the phenomenon that
% brief flashes of light are equally detectable as long as they are very
% brief, and contain the same amount of light.  Indeed, the temporal
% properties of the early stages of the visual system are typically modeled
% as a leaky integrator.  
%
% This response to a brief '1-gallon' (or 1 unit) stimulus is called the
% 'impulse response' and has a special meaning which we'll get to soon.

%% Scaling
%
% It should be clear by the way the stimulus feeds into the response that
% doubling the response doubles the peak of the response.  Since the
% recovery falls of in proportion to the current value, you can convince
% yourself that the whole impulse-response scales with the size of the
% input. Here's an example of the response to two brief pulses of different
% sizes separated in time. You'll see that the shape of the two responses
% are identical - they only vary by a scale-factor.  This is naturally
% called 'scaling'.  Mathematically, if L(s(t)) is the response of the
% system to a stimulus s(t), then L(ks(t)) = kL(s(t)).


dt = .001;  %step size (seconds)
maxt = 5;  %ending time (secons)
t = 0:dt:(maxt-dt);

dur = .01;
amp = 3/dur;
s = zeros(size(t));
s(t<dur) = amp;

s(t>=3 & t<3+dur) = 1/dur;

y = leakyIntegrator(s,k,t);
figure(1)
clf
plotResp(t,s,y);



%% Superposition
%
% In the last example, the second stimulus (splash of water) occurred long
% after the response to the first stimulus was over.  What happens when the 
% second stimulus happens sooner?


dt = .001;  %step size (seconds)
maxt = 2;  %ending time (seconds)
t = 0:dt:(maxt-dt);

dur = .01;
t1 = 0;  %time of first stimulus onset
s1 = zeros(size(t));
s1(t>=t1 & t<t1+dur) = 1/dur;

y1 = leakyIntegrator(s1,k,t);  %response to first stimulus


t2 = .1;  %time of second stimlus onset
s2 = zeros(size(t));
s2(t>=t2 & t<t2+dur) = 1/dur;

y2 = leakyIntegrator(s2,k,t);

%Response to the sum of the stimuli:
y12 = leakyIntegrator(s1+s2,k,t);

%Plot the response to the sum of the two stimuli:
figure(1)
clf
plotResp(t,s1+s2,y12);

% Plot the response to each of the stimuli alone:

hold on
plot(t,y1,'g-');
plot(t,y2,'g-');

%% 
% You can see that the response to the sum (y12) is equal to the sum of the
% response to the individual stimuli (y1 + y2).  That is:
%
% L(s1+s2) = L(s1)+L(s2)
%
% This property is called 'superposition'.  By the way, we're also assuming
% that the time-constant is fixed so that the shape of the response to a
% stimulus doesn't vary with when it occurs.  This property is called
% 'shift' invariance.
%
% A system that has both the properties of scaling and superposition is
% called a 'linear system', and one with shift invariance is (naturally)
% called a 'shift-invariant linear system'.  

%% Analytical solution for the leaky integrator
%
% The differential equation that describes the leaky integrator is very easy
% to solve analytically.  If 
%
% $$ \frac{dy}{dt} = -\frac{y}{k}$$ 
%
% Then 
% 
% $$ \frac{1}{y} dy = -\frac{1}{k} dt $$ 
% 
% Integrating both sides: 
% 
% $$ log(y) = -\frac{t}{k} + C $$ 
% 
% Exponentiating: 
% 
% $$ y = e^{-\frac{t}{k}+C} = e^Ce^{-\frac{t}{k}} $$ 
% 
% To calculate the impulse response, we let y(0) = 1, which makes C=0
% 
% $$ y = e^{-\frac{t}{k}} $$
%
% Let's compare the simulated to the analytical impulse response:

dt = .01;  %step size (seconds)
maxt = 1;  %ending time (seconds)
t = 0:dt:(maxt-dt);
nt = length(t);  %length of t

% Calculate the impulse response
s = zeros(size(t));
s(1) = 1/dt;

h = leakyIntegrator(s,k,t);
nht = nt;

hh = exp(-t(1:nht)/k);

clf
hold on
plot(t(1:nht),h,'b-');
plot(t(1:nht),hh,'b.');
legend({'Simulated','Analytical'});
xlabel('Time (s)');


function plotResp(t,s,y,col)

if ~exist('col','var')
    col = {'r','b'};
end

subplot(2,1,1)
plot(t,s,'-','LineWidth',2,'Color',col{1});
xlabel('Time (s)');
title('Input');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);

subplot(2,1,2)
plot(t,y,'-','LineWidth',2,'Color',col{2});
xlabel('Time (s)')
title('Output');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);




