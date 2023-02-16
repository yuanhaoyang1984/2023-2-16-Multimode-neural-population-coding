h1=cdfplot(wt);
hold on;
h2=cdfplot(ko);
set(h1,'LineStyle', '-', 'Color', 'k','LineWidth',1);
set(h2,'LineStyle', '-', 'Color', 'r','LineWidth',1);
legend('pAAV-CaMKIIa-EGFP','pAAV-CaMKIIa-Cre','Location','best')
xlabel('Onset latency (s)');
% xlabel('Response duration (s)');
ylabel('Cumulative fraction units');
grid off;
box off;
hold off
