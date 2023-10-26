clear
maxNumCompThreads(1);
n = 2000;
per_data = struct;
per_data.res = zeros(24,6);


tol_time = zeros(24,1);

maxiter = 5;
for it = 1:maxiter
tp = 1;

for d = 3:8
  d;
  
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

% %% test for exp QR
% %% KRP
% 
% %K = khatrirao(Ty);
% 
% 
% 
% %%QR on Factor matrices
% tic
% QF = cell(d-1,1);
% RF = cell(d-1,1);
% for i = 1 : d-1
%     [QF{i},RF{i}] = qr(Ty{i},0);
% end
% 
% t = toc; t_factor_QR = t_factor_QR + t;
% 
% 
% %%QR on R
% tic
% Rk = khatrirao(RF);
% [Q0,R0] = qr(Rk,0);
% 
% t = toc; t_QR_R = t_QR_R + t;
% 
% 
% %kappa = cond(K);
% XXy = cell(d-1,1);
% 
% %%Apply factor QR to RHS
% tic
% for i =  1:d-1
%     XXy{i} = QF{i}' * Xy{i};
% end
% t = toc; t_apply_factor_QR = t_apply_factor_QR + t;
% 
% Kx = khatrirao(XXy);
% 
% 
% 
% %% Apply R's QR
% tic
% %Kx = mttkrp(Q0',XXy,d-1);
% Kx = Q0' * Kx;
% t = toc; t_apply_QR_R = t_apply_QR_R + t;
% 
% 
% %%solve time
% tic
%  XXX = R0 \ (Kx * X.U{d}');
%  T.U{d} = XXX';
%  t = toc; t_back_solve = t_back_solve + t;
%  
% %exp_err = norm(full(T) - full(X)) / norm(X)
%  
% expt = [t_factor_QR,t_QR_R,t_apply_factor_QR,t_apply_QR_R,t_apply_gram,t_back_solve];
expt = exp_time(d,n);

t_krp = 0;
t_back_solve = 0;
t_gram = 0;
t_factor_QR = 0;
t_apply_factor_QR = 0;
t_QR_R = 0;
t_apply_QR_R = 0;
t_apply_gram = 0;

%test for normal equation

%Grams
tic
G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
t = toc; t_gram = t_gram + t;
% precompute cross products with F
tic
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end
t = toc; t_apply_gram = t_apply_gram + t;

tic
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);
t = toc; t_back_solve = t_back_solve + t;

%normal_err = norm(full(T) - full(X)) / norm(X)

nort = [t_gram,t_QR_R,t_apply_factor_QR,t_apply_QR_R,t_apply_gram,t_back_solve];


t_krp = 0;
t_back_solve = 0;
t_gram = 0;
t_factor_QR = 0;
t_apply_factor_QR = 0;
t_QR_R = 0;
t_apply_QR_R = 0;
t_apply_gram = 0;



%test for pairwise elimination

[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});

%condR = cond(Rp)

tic
XX = (Rp \ D);
T.U{d} = XX';
t = toc; t_back_solve = t_back_solve+t;

t_factor_QR = ttc;
t_QR_R = ttp;
t_apply_factor_QR = tttc;
t_apply_QR_R = tttp;
%pairwise_err = norm(full(T) - full(X)) / norm(X)

part = [t_factor_QR,t_QR_R,t_apply_factor_QR,t_apply_QR_R,t_apply_gram,t_back_solve];



time = [part; nort;expt; 0 0 0 0 0 0 ];
% tol_time(tp) = tol_time(tp) + sum(part);
% tol_time(tp+1) = tol_time(tp+1) + sum(nort);
% tol_time(tp+2) = tol_time(tp+2) + sum(expt);

per_data.res(tp,:) = per_data.res(tp,:) + part;
per_data.res(tp+1,:) = per_data.res(tp+1,:) + nort;
per_data.res(tp+2,:) = per_data.res(tp+2,:) + expt;

%per_data.res(tp:tp+3,:) = per_data.res(tp:tp+3,:) + time;
tp = tp + 4;



end


end

per_data.res = per_data.res / maxiter;
save('per_data.mat','per_data');