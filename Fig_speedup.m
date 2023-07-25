
clear
maxNumCompThreads(1);
%% 7-way
% initialize
tals = struct; tpinv = struct; tqr = struct; tsvd = struct;
d = 7;
r = 7;
maxdim = 2000;
n = [8:20:maxdim];

maxiter = 10;
tol = 1e-10;
qr_new_time = [8:20:maxdim];
als_time = [8:20:maxdim];

Uinit = cell(d,1);

tals.r7 = zeros(length(n),5);

tqr.r7 = zeros(length(n),7);



for i = 1:length(n)
    nk = n(i)
    %generate tensor
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Msvd7,~,outqr7] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',0,'errmethod','fast');
    [Mals7,~,outals7] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',0,'errmethod','fast');

    % compute average iteration time
    
    tqr.r7(i,:) = mean(outqr7.times(2:end,:),1);
    tals.r7(i,:) = mean(outals7.times(2:end,:),1);
    qr_new_time(i) = sum(tqr.r7(i,:));
    als_time(i) = sum(tals.r7(i,:)); 
end
%%

%True error generation
T = sinsum_full(7,16); % rank d representation
X = sinsums(7,16);
true_err = norm(full(T) - full(X)) / norm(X);
test = [1:maxiter];
for i = 1:maxiter
    test(i) = true_err;
end


figure,
plot(n(1:10:end),qr_new_time(1:10:end),n(1:10:end),als_time(1:10:end))
title("Execution Time, d = 7")
xlabel("dimensions (n)")
ylabel("runtime (sec)")
legend("CP-ALS-QR", "CP-ALS")








