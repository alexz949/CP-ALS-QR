clear
load('per_data.mat', 'per_data')
sum_mat = zeros(1,24);

% for i = 1:24
%     sum_mat(i) = sum(per_data.res(i,:));
% end
% 
% sum_mat(1:3) = sum_mat(1:3)/ sum_mat(1);
% sum_mat(5:7) = sum_mat(5:7)/ sum_mat(5);
% sum_mat(9:11) = sum_mat(9:11)/ sum_mat(9);
% sum_mat(13:15) = sum_mat(13:15)/ sum_mat(13);
% sum_mat(17:19) = sum_mat(17:19)/ sum_mat(17);
% sum_mat(21:23) = sum_mat(21:23)/ sum_mat(21);
% 
% sum_mat'
% %normalize and take log
% log_sum_mat = log(sum_mat +1);
% log_sum_mat'
% speed_mat = zeros(1,24);
% 
% 
% speed_mat(1:3) = log_sum_mat(1:3)/ log_sum_mat(1);
% speed_mat(5:7) = log_sum_mat(5:7)/ log_sum_mat(5);
% speed_mat(9:11) = log_sum_mat(9:11)/ log_sum_mat(9);
% speed_mat(13:15) = log_sum_mat(13:15)/ log_sum_mat(13);
% speed_mat(17:19) = log_sum_mat(17:19)/ log_sum_mat(17);
% speed_mat(21:23) = log_sum_mat(21:23)/ log_sum_mat(21);
% %%
% % remove the last bar column to see max d = 7
% figure,
% a = gca;
% bar([per_data.res(1:4,:); per_data.res(5:8,:); per_data.res(9:12,:); per_data.res(13:16,:); per_data.res(17:20,:); per_data.res(21:24,:)],'stacked');
% %bar(log_sum_mat)
% title('Runtime in each d-way tensor with n=2000')
% ylabel('Raw Runtime')
% 
% xlabel('Size')
% xticks([0:24]);
% xticklabels({'','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp'});
% a.XRuler.TickLabelGapOffset = 15;   
% a.YRuler.TickLabelGapOffset = 15;
% %text(1:length(log_sum_mat),log_sum_mat,num2str(speed_mat'),'vert','bottom','horiz','center')
% 
% v = -0.1;
% text(1.5,v,'d=3','fontsize',10)
% text(5.5,v,'d=4','fontsize',10)
% text(9.5,v,'d=5','fontsize',10)
% text(13.5,v,'d=6','fontsize',10)
% text(17.5,v,'d=7','fontsize',10)
% text(21.5,v,'d=8','fontsize',10)
% 
% l = legend('Gram/QR','QR on R','Qtb','apply QR on R','Atb','Back','fontsize',16);

%%



for i = 1:24
    sum_mat(i) = sum(per_data.res(i,:));
end



x = [3,4,5,6,7,8];
y1 = zeros(1,6);
y2 = zeros(1,6);
y3 = zeros(1,6);
yy1 = 1;
for i = 1:6
    y1(yy1) = sum_mat(4*(i-1)+1);
    y2(yy1) = sum_mat(4*(i-1)+2);
    y3(yy1) = sum_mat(4*(i-1)+3);
    
    yy1 = yy1+ 1;
end

figure,
ax = gca;

o = semilogy(x,y1,':','linewidth',2), hold on
p = semilogy(x,y2,'--','linewidth',2)
q = semilogy(x,y3,'-.','linewidth',2)
p.Marker = "o"
o.Marker = "o"
q.Marker = "o"


ylabel("Time (secs)")
xlabel("d")
set(gca, 'XTick', 3:8)
l = legend("QR Imp", "NE","QR Exp")
l.Location = 'northwest'
set(gca,'fontsize',16);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,'lineplot_p.pdf')
















