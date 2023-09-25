%% Fig2_performance  
%
% Generates Fig 2 from
%   'CP Decomposition for Tensors via Alternating 
%    Least Squares with QR Decomposition'
%       - Minster, Viviano, Liu, Ballard
%
% tests performance of CP-ALS, CP-ALS-PINV, CP-ALS-QR, & CP-ALS-QR-SVD
% on 3,4,5-way random tensors

clear
maxNumCompThreads(1);

% initialize
tals = struct; tpinv = struct; tqr = struct; tpw = struct;

%% 7-way
% generate tensor
d = 7;


r = 7;
n = [500,1000,2500];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r7 = zeros(length(n),5);
tpinv.r7 = zeros(length(n),5);
tqr.r7 = zeros(length(n),7);
tsvd.r7 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Mqr7,~,outqr7] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd7,~,outpw7] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals7,~,outals7] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r7(i,:) = mean(outqr7.times(2:end,:),1);
    tpw.r7(i,:) = mean(outpw7.times(2:end,:),1);
    tals.r7(i,:) = mean(outals7.times(2:end,:),1);
end
%% data prep
nals7 = zeros(3,5);
nqr7 = zeros(3,5);
npw7 = zeros(3,5);
for i = 1:3
    nals7(i,:) = [tals.r7(i,1), tals.r7(i,2),0,0,(tals.r7(i,3)+tals.r7(i,4)+tals.r7(i,5))];
    nqr7(i,:) = [tqr.r7(i,1),tqr.r7(i,2),tqr.r7(i,3),tqr.r7(i,4),(tqr.r7(i,5)+tqr.r7(i,6)+tqr.r7(i,7))];
    npw7(i,:) = [tpw.r7(i,1),tpw.r7(i,2),tpw.r7(i,3),tpw.r7(i,4),(tpw.r7(i,5)+tpw.r7(i,6)+tpw.r7(i,7))];

end



%% 3 Way


d = 3;


r = 3;
n = [500,1000,2500];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r3 = zeros(length(n),5);
tpinv.r3 = zeros(length(n),5);
tqr.r3 = zeros(length(n),7);
tsvd.r3 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Mqr3,~,outqr3] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd3,~,outpw3] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals3,~,outals3] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r3(i,:) = mean(outqr3.times(2:end,:),1);
    tpw.r3(i,:) = mean(outpw3.times(2:end,:),1);
    tals.r3(i,:) = mean(outals3.times(2:end,:),1);
end
%% data prep
nals3 = zeros(3,5);
nqr3 = zeros(3,5);
npw3 = zeros(3,5);
for i = 1:3
    nals3(i,:) = [tals.r3(i,1), tals.r3(i,2),0,0,(tals.r3(i,3)+tals.r3(i,4)+tals.r3(i,5))];
    nqr3(i,:) = [tqr.r3(i,1),tqr.r3(i,2),tqr.r3(i,3),tqr.r3(i,4),(tqr.r3(i,5)+tqr.r3(i,6)+tqr.r3(i,7))];
    npw3(i,:) = [tpw.r3(i,1),tpw.r3(i,2),tpw.r3(i,3),tpw.r3(i,4),(tpw.r3(i,5)+tpw.r3(i,6)+tpw.r3(i,7))];

end


%% 5 way
d = 5;


r = 5;
n = [500,1000,2500];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r5 = zeros(length(n),5);
tpinv.r5 = zeros(length(n),5);
tqr.r5 = zeros(length(n),7);
tsvd.r5 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Mqr5,~,outqr5] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd5,~,outpw5] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals5,~,outals5] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r5(i,:) = mean(outqr5.times(2:end,:),1);
    tpw.r5(i,:) = mean(outpw5.times(2:end,:),1);
    tals.r5(i,:) = mean(outals5.times(2:end,:),1);
end
%% data prep
nals5 = zeros(3,5);
nqr5 = zeros(3,5);
npw5 = zeros(3,5);
for i = 1:3
    nals5(i,:) = [tals.r5(i,1), tals.r5(i,2),0,0,(tals.r5(i,3)+tals.r5(i,4)+tals.r5(i,5))];
    nqr5(i,:) = [tqr.r5(i,1),tqr.r5(i,2),tqr.r5(i,3),tqr.r5(i,4),(tqr.r5(i,5)+tqr.r5(i,6)+tqr.r5(i,7))];
    npw5(i,:) = [tpw.r5(i,1),tpw.r5(i,2),tpw.r5(i,3),tpw.r5(i,4),(tpw.r5(i,5)+tpw.r5(i,6)+tpw.r5(i,7))];

end








%% prep data
sdata7 = [];
for i = 1:3
    sdata7 = [sdata7; npw7(i,:);nals7(i,:);nqr7(i,:); zeros(1,5)];
end

sdata3 = [];
for i = 1:3
    sdata3 = [sdata3; npw3(i,:);nals3(i,:);nqr3(i,:); zeros(1,5)];
end

sdata5 = [];
for i = 1:3
    sdata5 = [sdata5; npw5(i,:);nals5(i,:);nqr5(i,:); zeros(1,5)];
end


%% plot data
       
      
figure,
subplot(2,2,3)


bar(sdata7,'stacked')
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
text(1,v,'500','fontsize',16)
text(5,v,'1000','fontsize',16)
text(10,v,'2000','fontsize',16)



subplot(2,2,1)




bar(sdata3,'stacked')
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
text(1,v,'500','fontsize',16)
text(5,v,'1000','fontsize',16)
text(10,v,'2000','fontsize',16)

subplot(2,2,2)




bar(sdata5,'stacked')
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
text(1,v,'500','fontsize',16)
text(5,v,'1000','fontsize',16)
text(10,v,'2000','fontsize',16)
legend('MTTKRP/TTM','Gram/QR','Compute QR on R','Apply QR on R','Other','fontsize',16);

%%

eMat = zeros(9,5);
j = 1;
for i = 1:12
    if(i ~= 3)
        if(i~=7)
            if(i~=11)
                eMat(j,:) = sdata7(i,:);
                j = j+1;
            end
        end
    end 
end

figure,
bar(eMat,'stacked')
a = gca;

xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])

xticks([0:9])
xticklabels({'','QR Imp','NE','','QR Imp','NE','','QR Imp','NE'})
a.XRuler.TickLabelGapOffset = 15;   
a.YRuler.TickLabelGapOffset = 15;
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
v = -0.0002;
text(1,v,'500','fontsize',16)
text(4,v,'1000','fontsize',16)
text(7,v,'2000','fontsize',16)
legend('MTTKRP/TTM','Gram/QR','Compute QR on R','Apply QR on R','Other','fontsize',16);

