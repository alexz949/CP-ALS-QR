
clear
n = [1000,100,50,25,15,10];
edata = struct;
edata.ek = zeros(6,1);
edata.et = zeros(6,1);
edata.en = zeros(6,1);
edata.eq = zeros(6,1);
edata.ep = zeros(6,1);
j = 1;
for d = 3:8
    d
    T = sinsums(d,n(j));
    X = sinsum_full(d,n(j));
    true_err = norm(full(T) - full(X)) / norm(X);
    
    % generate random ktensor fac tors
    Ty = cell(d-1,1);
    Xy = cell(d-1,1);
    for i = 1 : d-1
        Ty{i} = T.U{i};
        Xy{i} = X.U{i};
    end


%%
%test for exp QR

K = khatrirao(Ty);
Kx = khatrirao(Xy);
[Qk,Rk] = qr(K,0);

kappa = cond(K);

Kx = Qk' * Kx;
XXX = Rk \ (Kx * X.U{d}');
T.U{d} = XXX';

exp_err = norm(full(T) - full(X)) / norm(X);



%%
% test for normal equation
%Grams

G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end

% precompute cross products with F
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end



% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);

normal_err = norm(full(T) - full(X)) / norm(X);





%$
% test for pairwise elimination

[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});




XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err = norm(full(T) - full(X)) / norm(X);

edata.ek(j) = kappa;
edata.et(j) = true_err;
edata.en(j) = normal_err;
edata.eq(j) = exp_err;
edata.ep(j) = pairwise_err;

j = j+1;


end
save('edata.mat','edata');

