

clear 
load('kt_data.mat','kt_data')
%% plot data
%% 9-way 
figure,
subplot(2,2,4)


bar(kt_data.sdata9,'stacked')
title('7-way', 'fontsize',18)
a = gca;

xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])
xticks([0:12])
xticklabels({'','QR Imp','NE','','','QR Imp','NE','','','QR Imp','NE',''})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
v = -0.005;
text(1,v,'10000','fontsize',16)
text(5,v,'15000','fontsize',16)
text(9,v,'30000','fontsize',16)






       
%% 7-way      

subplot(2,2,3)


bar(kt_data.sdata7,'stacked')
title('7-way', 'fontsize',18)
a = gca;

xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])
xticks([0:12])
xticklabels({'','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp'})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
v = -0.005;
text(1,v,'10000','fontsize',16)
text(5,v,'15000','fontsize',16)
text(9,v,'30000','fontsize',16)


%% 3-way
subplot(2,2,1)




bar(kt_data.sdata3,'stacked')
title('3-way', 'fontsize',18)
a = gca;

xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])
xticks([0:12])
xticklabels({'','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp'})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
v = -0.00005;
text(1,v,'10000','fontsize',16)
text(5,v,'15000','fontsize',16)
text(9,v,'30000','fontsize',16)
l = legend('MTTKRP/TTM','Gram/QR','Pairwise QR','Apply Pairwise QR','Other','fontsize',8);
l.Location = 'northwest'



%% 5-way
subplot(2,2,2)




bar(kt_data.sdata5,'stacked')
title('5-way', 'fontsize',18)
a = gca;

xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])
xticks([0:12])
xticklabels({'','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp'})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
v = -0.00005;
text(1,v,'10000','fontsize',16)
text(5,v,'15000','fontsize',16)
text(9,v,'30000','fontsize',16)
set(gcf,'Units','inches');

saveas(gcf,'perform.pdf')
%%


