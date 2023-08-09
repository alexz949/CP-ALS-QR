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
tals = struct; tpinv = struct; tqr = struct; tsvd = struct;

%% 3-way

% generate tensor
d=3;
n = 30;
T = sinsums(d,n);

r = [5,10,15,20];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r3 = zeros(length(r),5);
tpinv.r3 = zeros(length(r),5);
tqr.r3 = zeros(length(r),7);
tsvd.r3 = zeros(length(r),7);

for i = 1:length(r)
    rk = r(i);
    
    % initial guess
    for j = 1:d
        Uinit{j} = rand(n,rk);
    end
    
    % compute CP
    [Mqr3,~,outqr3] = cp_als_qr(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd3,~,outsvd3] = cp_als_qr_new(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals3,~,outals3] = cp_als_time(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mpinv3,~,outpinv3] = cp_als_pinv(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r3(i,:) = mean(outqr3.times(2:end,:),1);
    tsvd.r3(i,:) = mean(outsvd3.times(2:end,:),1);
    tals.r3(i,:) = mean(outals3.times(2:end,:),1);
    tpinv.r3(i,:) = mean(outpinv3.times(2:end,:),1);
end


%% 4-way
% generate tensor
n = 20;
d = 4;
T = sinsums(d,n);
r = [3,6,9,12];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r4 = zeros(length(r),5);
tpinv.r4 = zeros(length(r),5);
tqr.r4 = zeros(length(r),7);
tsvd.r4 = zeros(length(r),7);

for i = 1:length(r)
    rk = r(i);
    
    % initial guess
    for j = 1:d
        Uinit{j} = rand(n,rk);
    end
    
    % compute CP
    [Mqr4,~,outqr4] = cp_als_qr(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd4,~,outsvd4] = cp_als_qr_new(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals4,~,outals4] = cp_als_time(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mpinv4,~,outpinv4] = cp_als_pinv(T,rk,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r4(i,:) = mean(outqr4.times(2:end,:),1);
    tsvd.r4(i,:) = mean(outsvd4.times(2:end,:),1);
    tals.r4(i,:) = mean(outals4.times(2:end,:),1);
    tpinv.r4(i,:) = mean(outpinv4.times(2:end,:),1);
end




%% 5-way
% generate tensor
d = 7;


r = 7;
n = [500,1000,2000];
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
    [Msvd5,~,outsvd5] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals5,~,outals5] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mpinv5,~,outpinv5] = cp_als_pinv(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r5(i,:) = mean(outqr5.times(2:end,:),1);
    tsvd.r5(i,:) = mean(outsvd5.times(2:end,:),1);
    tals.r5(i,:) = mean(outals5.times(2:end,:),1);
    tpinv.r5(i,:) = mean(outpinv5.times(2:end,:),1);
end


%% prep data
[sdata,ratios] = bar_prep(tals,tpinv,tqr,tsvd);
% 
% %% plot data
% figure,
% % 3-way
% subplot(2,2,1)
% bar(sdata.N3,'stacked')
% %ylim([0 15])
% ax = gca;
% ax.FontSize = 16;
% xlabel('rank','FontSize',18)
% ylabel('runtime (secs)','FontSize',18)
% title('3-way, n = 700','fontsize',18)
% xticks([0:20])
% xticklabels({'','ALS','PINV','QR','QR-SVD','','ALS','PINV','QR','QR-SVD','','ALS','PINV','QR','QR-SVD','','ALS','PINV','QR','QR-SVD'})
% text(2.5,2.5,num2str(round(ratios.N3(1),1)),'fontsize',14)
% text(7.5,4,num2str(round(ratios.N3(2),1)),'fontsize',14)
% text(12.5,6.5,num2str(round(ratios.N3(3),1)),'fontsize',14)
% text(17.5,11.8,num2str(round(ratios.N3(4),1)),'fontsize',14)
% v3 = -3.5;
% text(2,v3,'10','fontsize',18)
% text(7,v3,'50','fontsize',18)
% text(12,v3,'100','fontsize',18)
% text(17,v3,'200','fontsize',18)
% 
% 
% 
% % 4-way
% 
% subplot(2,2,2)
% bar(sdata.N4,'stacked')
% ax = gca;
% ax.FontSize = 16;
% xlabel('rank','FontSize',18)
% ylabel('runtime (secs)','FontSize',18)
% xticks([0:20])
% xticklabels({'','ALS','PINV','QR','QR-SVD','','ALS','PINV','QR','QR-SVD','','ALS','PINV','QR','QR-SVD','','ALS','PINV','QR','QR-SVD'})
% title('4-way, n = 300','fontsize',18)
% text(2.5,200,num2str(round(ratios.N4(1),1)),'fontsize',14)
% text(7.5,300,num2str(round(ratios.N4(2),1)),'fontsize',14)
% text(12.5,520,num2str(round(ratios.N4(3),1)),'fontsize',14)
% text(17.5,1830,num2str(round(ratios.N4(4),1)),'fontsize',14)
% v = -500;
% text(2,v,'10','fontsize',18)
% text(7,v,'50','fontsize',18)
% text(12,v,'100','fontsize',18)
% text(17,v,'200','fontsize',18)
%%
% 5-way
nMat = zeros(12,5);
j = 1;
for i = 1:15
    if(i ~= 2)
        if(i ~= 7) 
            if( i ~= 12)
                nMat(j,:) = sdata.N5(i,:);
                j = j+1;
            end
        end
    end 
end
eMat = zeros(9,5);
j = 1;
for i = 1:15
    if(i ~= 2)
        if(i ~= 3)
            if(i~=8)
                if(i~=13)
        if(i ~= 7) 
            if( i ~= 12)
                eMat(j,:) = sdata.N5(i,:);
                j = j+1;
            end
        end
                end
            end

        end
    end 
end
figure,
sgtitle('Average runtime for 7-way tensor with different QR-ALS methods')
subplot(1,2,1)

bar(nMat,'stacked')
ax = gca;
ax.FontSize = 16;
xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])
xticks([0:12])
xticklabels({'','ALS','Exp QR','Pairwise QR','','ALS','EXP QR','Pairwise QR','','ALS','EXP QR','Pairwise QR'})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
v = -0.0005;
text(1,v,'500','fontsize',18)
text(5,v,'1000','fontsize',18)
text(10,v,'2000','fontsize',18)


subplot(1,2,2)
bar(eMat,'stacked')
ax = gca;
ax.FontSize = 16;
xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])

xticks([0:9])
xticklabels({'','ALS','Pairwise QR','','ALS','Pairwise QR','','ALS','Pairwise QR'})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
v = -0.0005;
text(1,v,'500','fontsize',18)
text(4,v,'1000','fontsize',18)
text(7,v,'2000','fontsize',18)
lgd = legend('MTTKRP/TTM','Gram/QR','Compute Q_0 (QR only)','Apply Q_0 (QR only)','Other','fontsize',16)
fontsize(lgd,10,'points');
