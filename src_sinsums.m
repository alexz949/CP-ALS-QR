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

%% 10-way 
d = 10; %number of modes
r = 10;
maxiter = 40;
tol = 0;
rng(3)

% form sin of sums tensor
T = sinsums(d,n);
X = sinsum_full(d,n);



% Compute CP decomposition
% CP-ALS

[M_als6,U_als6,out_als6] = cp_als_time(X,r,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);


% CP-ALS-QR-new

[M_imp6,U_imp6,out_imp6] = cp_als_qr_new(X,r,'init',U_als6,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);

%% 7-way
d = 7; %number of modes
r = 7;
maxiter = 40;
tol = 0;
rng(3)

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
rng(3)

% form sin of sums tensor
T = sinsums(d,n);
X = sinsum_full(d,n);



% Compute CP decomposition
% CP-ALS

[M_als8,U_als8,out_als8] = cp_als_time(X,r,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);


% CP-ALS-QR-new

[M_imp8,U_imp8,out_imp8] = cp_als_qr_new(X,r,'init',U_als8,'maxiters',maxiter,'tol',tol,'printitn',pl,'errmethod',em);


%% 6-way prep
als_data.als6 = out_als6.relerr;
als_data.imp6 = out_imp6.relerr;

%% 7-way prep
als_data.als7 = out_als7.relerr;
als_data.imp7 = out_imp7.relerr;

%% 5-way prep
als_data.als8 = out_als8.relerr;
als_data.imp8 = out_imp8.relerr;

save('als_data.mat','als_data');




