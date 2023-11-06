clear
maxNumCompThreads(1);
n = 2000;
per_data = struct;
per_data.res = zeros(24,5);




maxiter = 10;
for it = 1:maxiter
tp = 1;

for d = 3:8
  d
  
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

nort = [t_apply_gram,t_gram,t_apply_QR_R,t_QR_R,t_back_solve];

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

part = [t_apply_factor_QR,t_factor_QR,t_apply_QR_R,t_QR_R,t_back_solve];





per_data.res(tp,:) = per_data.res(tp,:) + part;
per_data.res(tp+1,:) = per_data.res(tp+1,:) + nort;
per_data.res(tp+2,:) = per_data.res(tp+2,:) + expt;

tp = tp + 4;



end


end

per_data.res = per_data.res / maxiter;
save('per_data.mat','per_data');