%% src_sinsums
%
% Generates Fig 5 from
%   'CP Decomposition for Tensors via Alternating 
%    Least Squares with QR Decomposition'
%       - Minster, Viviano, Liu, Ballard
%
% tests accuracy of CP-ALS, CP-ALS-PINV, CP-ALS-QR, & CP-ALS-QR-SVD
% on 10-way sin of sums tensor

%clear
als_data = struct;
n = 8 %dimension of tensor
em = 'lowmem'
pl = 10
rng(3)

%% 10-way 
d = 10; %number of modes
r = 10;
maxiter = 40;
tol = 0;

% form sin of sums tensor
T = sinsums(d,n);
X = sinsum_full(d,n);


% Compute CP decomposition
% CP-ALS
[M_als10,U_als10,out_als10] = cp_als_time(X,r,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);
% CP-ALS-QR-new
[M_imp10,U_imp10,out_imp10] = cp_als_qr_new(X,r,'init',U_als10,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);

%% 7-way
d = 7; %number of modes
r = 7;
maxiter = 40;
tol = 0;

% form sin of sums tensor
T = sinsums(d,n);
X = sinsum_full(d,n);

% Compute CP decomposition
% CP-ALS
[M_als7,U_als7,out_als7] = cp_als_time(X,r,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);
% CP-ALS-QR-new
[M_imp7,U_imp7,out_imp7] = cp_als_qr_new(X,r,'init',U_als7,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);

%% 5-way
d = 5; %number of modes
r = 5;
maxiter = 40;
tol = 0;

% form sin of sums tensor
T = sinsums(d,n);
X = sinsum_full(d,n);

% Compute CP decomposition
% CP-ALS
[M_als5,U_als5,out_als5] = cp_als_time(X,r,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);
% CP-ALS-QR-new
[M_imp5,U_imp5,out_imp5] = cp_als_qr_new(X,r,'init',U_als5,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);

%% 10-way prep
als_data.als10 = out_als10.relerr;
als_data.imp10 = out_imp10.relerr;

%% 7-way prep
als_data.als7 = out_als7.relerr;
als_data.imp7 = out_imp7.relerr;

%% 5-way prep
als_data.als5 = out_als5.relerr;
als_data.imp5 = out_imp5.relerr;
save('Fig4.mat','als_data');








