function li_plotResp(t,s,s_n,y,col)

if ~exist('col','var')
    col = {'r','k','b'};
end

subplot(2,1,1)
plot(t,s_n,'-','LineWidth',1,'Color',col{1}); hold on;
plot(t,s,'-','LineWidth',2,'Color',col{2});
xlabel('Time (s)');
title('Input');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);
legend({'stim+noise','stim'});

subplot(2,1,2)
plot(t,y,'-','LineWidth',2,'Color',col{3});
xlabel('Time (s)')
title('Output');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);

