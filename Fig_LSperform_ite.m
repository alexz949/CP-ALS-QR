
clear
n = [1000,100,50,25,15,10];
per_data = struct;
per_data.res = zeros(24,7);

j = 1;
tp = 1;
for d = 3:8
  d
t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;



T = sinsums(d,n(j));
X = sinsum_full(d,n(j));
%true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end

%% test for exp QR
tic
 K = khatrirao(Ty);
 
 
 t = toc; t_krp = t_krp + t;
tic
QF = cell(d-1,1);
RF = cell(d-1,1);
for i = 1 : d-1
    [QF{i},RF{i}] = qr(Ty{i},0);
end
t = toc; t_comp = t_comp + t;
tic
Rk = khatrirao(RF);
[Q0,R0] = qr(Rk,0);
t = toc; t_par = t_par + t;
kappa = cond(K);
XXy = cell(d-1,1);
tic
for i =  1:d-1
    XXy{i} = QF{i}' * Xy{i};
end
t = toc; t_comp_apply = t_comp_apply + t;
Kx = khatrirao(Xy);
tic
Kx = Q0' * Kx;
t = toc; t_par_apply = t_par_apply + t;
tic
 XXX = R0 \ (Kx * X.U{d}');
 T.U{d} = XXX';
 t = toc; t_back = t_back + t;
 
%exp_err = norm(full(T) - full(X)) / norm(X)
 
 expt = [t_krp, t_comp,t_comp_apply,t_par,t_par_apply,t_apply,t_back];

t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;

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
t = toc; t_apply = t_apply + t;

tic
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);
t = toc; t_back = t_back + t;

%normal_err = norm(full(T) - full(X)) / norm(X)

nort = [t_krp, t_comp,t_comp_apply,t_par,t_par_apply,t_apply,t_back];


t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;



%test for pairwise elimination

[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});

%condR = cond(Rp)

tic
XX = (Rp \ D)';
T.U{d} = XX;
t = toc; t_back = t_back+t;

t_comp = ttc;
t_comp_apply = ttp;
t_par = tttc;
t_par_apply = tttp;
%pairwise_err = norm(full(T) - full(X)) / norm(X)

part = [t_krp, t_comp,t_par,t_comp_apply,t_par_apply,t_apply,t_back];



time = [part; nort;expt; 0 0 0 0 0 0 0];

per_data.res(tp:tp+3,:) = time;
tp = tp + 4;

j = j  +1;

end
save('per_data.mat','per_data');
















