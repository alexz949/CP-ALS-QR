function time = exp_time(d,n)


t_krp = 0;
t_back_solve = 0;
t_gram = 0;
t_factor_QR = 0;
t_apply_factor_QR = 0;
t_QR_R = 0;
t_apply_QR_R = 0;
t_apply_gram = 0;



T = sinsums(d,n);
X = sinsum_full(d,n);
%true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end

%% test for exp QR
%% KRP

%K = khatrirao(Ty);



%%QR on Factor matrices
tic
QF = cell(d-1,1);
RF = cell(d-1,1);
for i = 1 : d-1
    [QF{i},RF{i}] = qr(Ty{i},0);
end

t = toc; t_factor_QR = t_factor_QR + t;


%%QR on R
tic
Rk = khatrirao(RF);
[Q0,R0] = qr(Rk,0);

t = toc; t_QR_R = t_QR_R + t;


%kappa = cond(K);
XXy = cell(d-1,1);

%%Apply factor QR to RHS
tic
for i =  1:d-1
    XXy{i} = QF{i}' * Xy{i};
end
t = toc; t_apply_factor_QR = t_apply_factor_QR + t;

Kx = khatrirao(XXy);



%% Apply R's QR
tic
%Kx = mttkrp(Q0',XXy,d-1);
Kx = Q0' * Kx;
t = toc; t_apply_QR_R = t_apply_QR_R + t;


%%solve time
tic
 XXX = R0 \ (Kx * X.U{d}');
 T.U{d} = XXX';
 t = toc; t_back_solve = t_back_solve + t;
 
%exp_err = norm(full(T) - full(X)) / norm(X)
 
expt = [t_factor_QR,t_QR_R,t_apply_factor_QR,t_apply_QR_R,t_apply_gram,t_back_solve];

time = expt;




end
