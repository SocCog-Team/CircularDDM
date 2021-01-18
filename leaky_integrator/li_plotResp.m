function li_plotResp(t,s,y,col)

if ~exist('col','var')
    col = {'r','b','m'};
end

subplot(3,1,1)
plot(t,s,'-','LineWidth',2,'Color',col{1});
xlabel('Time (s)');
title('Input');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);

subplot(3,1,2)
plot(t,y,'-','LineWidth',2,'Color',col{2});
xlabel('Time (s)')
title('Output');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);

subplot(3,1,3)
plot(t,cumsum(y),'-','LineWidth',2,'Color',col{3});
xlabel('Time (s)')
title('cumsum(output)');
set(gca,'XLim',[min(t)-.05,max(t)+.05]);