clear
load('per_data.mat')
sum_mat = zeros(1,24);

for i = 1:24
    sum_mat(i) = sum(per_data.res(i,:));
end

sum_mat(1:3) = sum_mat(1:3)/ sum_mat(1);
sum_mat(5:7) = sum_mat(5:7)/ sum_mat(5);
sum_mat(9:11) = sum_mat(9:11)/ sum_mat(9);
sum_mat(13:15) = sum_mat(13:15)/ sum_mat(13);
sum_mat(17:19) = sum_mat(17:19)/ sum_mat(17);
sum_mat(21:23) = sum_mat(21:23)/ sum_mat(21);

sum_mat'
%normalize and take log
log_sum_mat = log(sum_mat +1);
log_sum_mat'
speed_mat = zeros(1,24);


speed_mat(1:3) = log_sum_mat(1:3)/ log_sum_mat(1);
speed_mat(5:7) = log_sum_mat(5:7)/ log_sum_mat(5);
speed_mat(9:11) = log_sum_mat(9:11)/ log_sum_mat(9);
speed_mat(13:15) = log_sum_mat(13:15)/ log_sum_mat(13);
speed_mat(17:19) = log_sum_mat(17:19)/ log_sum_mat(17);
speed_mat(21:23) = log_sum_mat(21:23)/ log_sum_mat(21);
%%

figure,
a = gca;
% bar([per_data.res(1:4,:); per_data.res(5:8,:); per_data.res(9:12,:); per_data.res(13:16,:); per_data.res(17:20,:);per_data.res(21:24,:)]);
bar(log_sum_mat)
ylabel('log runtime respect to NE')

xlabel('Size')
xticks([0:24]);
xticklabels({'','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp','','QR Imp','NE','QR Exp'});
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
text(1:length(log_sum_mat),log_sum_mat,num2str(speed_mat'),'vert','bottom','horiz','center')

v = -0.1;
text(1.5,v,'d=3,n=3000','fontsize',10)
text(5.5,v,'d=4,n=600','fontsize',10)
text(9.5,v,'d=5,n=200','fontsize',10)
text(13.5,v,'d=6,n=70','fontsize',10)
text(17.5,v,'d=7,n=30','fontsize',10)
text(21.5,v,'d=8,n=10','fontsize',10)

%legend('Gram/QR','QR on R','Qtb','apply QR on R','Atb','Back','fontsize',16)