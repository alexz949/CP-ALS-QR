clear
d = 6;
n = 10;

T = sinsums(d,n);
    X = sinsum_full(d,n);
    true_err = norm(full(T) - full(X)) / norm(X);
    
    % generate random ktensor fac tors
    Ty = cell(d-1,1);
    Xy = cell(d-1,1);
    for i = 1 : d-1
        Ty{i} = T.U{i};
        Xy{i} = X.U{i};
    end
    
    
 
 K = khatrirao(Ty);
 condK = cond(K)
% Kx = khatrirao(Xy);
% [Qk,Rk] = qr(K,0);
% 
% kappa = cond(K);
% 
% Kx = Qk' * Kx;
% XXX = Rk \ (Kx * X.U{d}');
% T.U{d} = XXX';
% 
% exp_err = norm(full(T) - full(X)) / norm(X)

% test for normal equation
%Grams

G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
condG = cond(G)

% precompute cross products with F
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end



% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);

normal_err = norm(full(T) - full(X)) / norm(X)



[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});




XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err = norm(full(T) - full(X)) / norm(X)
