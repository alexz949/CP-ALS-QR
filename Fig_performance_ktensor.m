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
n = [500,1000,2000];
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




%% prep data
sdata7 = [];
for i = 1:3
    sdata7 = [sdata7; nals7(i,:);nqr7(i,:); npw7(i,:); zeros(1,5)];
end


%% plot data

eMat = zeros(9,5);
j = 1;
for i = 1:12
    if(i ~= 2)
        if(i~=6)
            if(i~=10)
                eMat(j,:) = sdata7(i,:);
                j = j+1;
            end
        end
    end 
end

       
       

figure,
sgtitle('Average runtime for 7-way tensor with different QR-ALS methods')
subplot(1,2,1)

bar(sdata7,'stacked')
ax = gca;
ax.FontSize = 16;
xlabel('dimensions','FontSize',18)
ylabel('runtime (secs)','FontSize',18)
%ylim([0 430])
xticks([0:12])
xticklabels({'','NE','Exp QR','Pairwise QR','','NE','EXP QR','Pairwise QR','','NE','EXP QR','Pairwise QR'})
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
xticklabels({'','NE','Pairwise QR','','NE','Pairwise QR','','NE','Pairwise QR'})
% text(2.5,55,num2str(round(ratios.N5(1),1)),'fontsize',14)
% text(7.5,80,num2str(round(ratios.N5(2),1)),'fontsize',14)
% text(12.5,305,num2str(round(ratios.N5(3),1)),'fontsize',14)
v = -0.0005;
text(1,v,'500','fontsize',18)
text(4,v,'1000','fontsize',18)
text(7,v,'2000','fontsize',18)
lgd = legend('MTTKRP/TTM','Gram/QR','Compute QR on R','Apply QR on R','Other','fontsize',16)
fontsize(lgd,10,'points');
