%% Fig5_sinsums
%
% Generates Fig 5 from
%   'CP Decomposition for Tensors via Alternating 
%    Least Squares with QR Decomposition'
%       - Minster, Viviano, Liu, Ballard
%
% tests accuracy of CP-ALS, CP-ALS-PINV, CP-ALS-QR, & CP-ALS-QR-SVD
% on 10-way sin of sums tensor

clear


d = 7; %number of modes
r = 7;
n = 16; %dimension of tensor
maxiter = 40;
tol = 0;
rng(3)

% form sin of sums tensor
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err = norm(full(T) - full(X)) / norm(X);


test = [1:maxiter];
for i = 1:maxiter
    test(i) = true_err;
end
% Compute CP decomposition
% CP-ALS

[M_als,U_als,out_als1] = cp_als_time(X,r,'maxiters',maxiter,'tol',tol,'printitn',10,'errmethod','lowmem');


% CP-ALS-QR-new

[M_imp,U_imp,out_imp1] = cp_als_qr_new(X,r,'init',U_als,'maxiters',maxiter,'tol',tol,'printitn',10,'errmethod','lowmem');


% CP-ALS-QR
%[M_qr,U_qr,out_qr1] = cp_als_qr(T,r,'init',U_als,'maxiters',maxiter,'tol',tol,'printitn',10,'errmethod','lowmem');



%% plot iterations vs relative error


figure,

semilogy(1:out_als1.iters,out_als1.relerr,'linewidth',2), hold on
semilogy(1:out_imp1.iters,out_imp1.relerr,':','linewidth',2)
%semilogy(1:maxiter,test,'--','linewidth',2)


legend('NE','QR Imp')
xlabel('iteration number')
ylabel('relative error')
title('Relative Error,d=7') 
set(gca,'fontsize',16)





