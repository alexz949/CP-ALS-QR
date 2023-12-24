clear
load('per_data.mat')
n = [3000,600,200,70,30,10];
bd_mat = zeros(18,5);
j = 1;
for i = 1:24
    if i ~= 3
        if i  ~= 7
            if i ~= 11
                if i ~= 15
                    if i~= 19
                        if i~= 23
                            bd_mat(j,:) = per_data.res(i,:);
                            j = j +  1;
                        end
                    end
                end
            end
        end
    end                 
end
%%

figure,
a=gca;
bar([bd_mat(1:3,:); bd_mat(4:6,:); bd_mat(7:9,:);bd_mat(10:12,:);bd_mat(13:15,:);bd_mat(16:18,:)],'stacked');
ylabel('Time (secs)')

xlabel('d')
xticks([0:18]);
xticklabels({'','QR Imp','NE','','QR Imp','NE','','QR Imp','NE','','QR Imp','NE','','QR Imp','NE','','QR Imp','NE'});
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
v = -0.0003;
text(1,v,'d=3','fontsize',12)
text(4,v,'d=4','fontsize',12)
text(7,v,'d=5','fontsize',12)
text(10,v,'d=6','fontsize',12)
text(13,v,'d=7','fontsize',12)
text(16,v,'d=8','fontsize',12)



l = legend('$Q^\top$B/$A^\top$B','QR/Gram','Pairwise Apply QR','Pairwise QR','Back solve/NE solve','Interpreter','latex');
l.Direction = 'reverse';
l.Location = 'northwest'
set(gca,'fontsize',14);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,'breakdown_p.pdf')


