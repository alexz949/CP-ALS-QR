clear

load('als_data.mat','als_data')
load('als_data_e.mat', 'als_data_e')

%% plot iterations vs relative error
%als8 is actually 5

figure,


subplot(1,2,1)
semilogy(1:40,als_data.als8,'-.','Color','#EDD80B','linewidth',1), hold on
semilogy(1:40,als_data.imp8,':','Color','#EDD80B','linewidth',1)

semilogy(1:40,als_data.als7,'-.','Color','#0A71ED','linewidth',1)
semilogy(1:40,als_data.imp7,':','Color','#0A71ED','linewidth',1)
semilogy(1:40,als_data.als6,'-.','Color','#F33E09','linewidth',1)
semilogy(1:40,als_data.imp6,':','Color','#F33E09','linewidth',1)
ylim([1e-15 10])
set(gca,'fontsize',10)
legend('5-way NE','5-way QR Imp','7-way NE','7-way QR Imp','10-way NE','10-way QR Imp','fontsize',6)
%title('Relative Error for Different d (1st trial)') 
xlabel('iteration number')
ylabel('relative error')
title('1st trial')


subplot(1,2,2)
semilogy(1:40,als_data_e.als8,'-.','Color','#EDD80B','linewidth',1), hold on
semilogy(1:40,als_data_e.imp8,':','Color','#EDD80B','linewidth',1)

semilogy(1:40,als_data_e.als7,'-.','Color','#0A71ED','linewidth',1)
semilogy(1:40,als_data_e.imp7,':','Color','#0A71ED','linewidth',1)
semilogy(1:40,als_data_e.als6,'-.','Color','#F33E09','linewidth',1)
semilogy(1:40,als_data_e.imp6,':','Color','#F33E09','linewidth',1)
ylim([1e-15 10])

title('2nd trial')


xlabel('iteration number')
ylabel('relative error')
set(gca,'fontsize',10)
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,'sinsums_acc2.pdf')
%change d & n