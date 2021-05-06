function [] = plotGenFig(yf,yf0)
plot(yf,'linewidth',2,'color','k')
hold on
plot(yf0+max(abs(yf))/3,'linewidth',2,'color','[.5 0 .5]')
legend('Noisy Signal','Clean Signal','Location','Northwest')
xlabel('Samples')
end

