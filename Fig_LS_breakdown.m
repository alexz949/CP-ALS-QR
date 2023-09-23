clear
load('per_data.mat')
n = [3000,600,200,70,30,10];
bd_mat = zeros(18,6);
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

ylabel('runtime (sec)')

xlabel('size')
xticks([0:18]);
xticklabels({'','QR Imp','NE','','QR Imp','NE','','QR Imp','NE','','QR Imp','NE','','QR Imp','NE','','QR Imp','NE'});
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
v = -0.00005;
text(1,v,'d=3,n=3000','fontsize',10)
text(4,v,'d=4,n=600','fontsize',10)
text(7,v,'d=5,n=200','fontsize',10)
text(10,v,'d=6,n=70','fontsize',10)
text(13,v,'d=7,n=30','fontsize',10)
text(16,v,'d=8,n=10','fontsize',10)

legend('Gram/QR','QR on R','Qtb','apply QR on R','Atb','Back solve','fontsize',16)



