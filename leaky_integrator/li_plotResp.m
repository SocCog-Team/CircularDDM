function li_plotResp(t,s,s_n,y,lambda,col)

if ~exist('col','var')
    col = {'r','k','b'};
end

subplot(2,1,1)
plot(t,s_n,'-','LineWidth',1,'Color',col{1}); hold on;
plot(t,s,'-','LineWidth',2,'Color',col{2});
title('Input');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);
legend({'stim+noise','veridical stim'});

subplot(2,1,2)
plot(t,y,'-','LineWidth',2,'Color',col{3}); hold on
plot(t,s,'-','LineWidth',2,'Color',col{2});
xlabel('Time (s)')
title(sprintf('Integrator output (lambda = %.1f)',lambda));
set(gca,'XLim',[min(t)-.05,max(t)+.05]);

